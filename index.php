<?php
require __DIR__.'/db.php'; require __DIR__.'/functions.php';
session_start();
if (empty($_SESSION['csrf'])) $_SESSION['csrf']=bin2hex(random_bytes(32));
function flash(string $message, string $type='success'): void { $_SESSION['flash']=['message'=>$message,'type'=>$type]; }
function redirectTo(string $url): never { header('Location: '.$url); exit; }
$table = $_GET['table'] ?? '';
$action = $_GET['action'] ?? 'list';
$id = $_GET['id'] ?? null;
if ($table !== '' && !tableAllowed($table)) { http_response_code(404); exit('Tabel tidak ditemukan.'); }
$allTables=[]; foreach($groups as $g) foreach($g as $t) $allTables[]=$t;
if ($_SERVER['REQUEST_METHOD']==='POST' && isset($_POST['delete_table'])) {
    $t=$_POST['delete_table']; if (!tableAllowed($t) || !hash_equals($_SESSION['csrf'], $_POST['csrf'] ?? '')) exit('Permintaan tidak valid.');
    $cols=columns($pdo,$t); $pk=primaryKey($cols);
    try { $s=$pdo->prepare("DELETE FROM `{$t}` WHERE `{$pk}`=?"); $s->execute([$_POST['delete_id']]); flash('Data berhasil dihapus.'); }
    catch(PDOException $e) { flash('Data tidak dapat dihapus karena masih digunakan oleh data lain. Hapus/perbarui data terkait terlebih dahulu.','danger'); }
    redirectTo('index.php?table='.urlencode($t));
}
if ($_SERVER['REQUEST_METHOD']==='POST' && isset($_POST['save_record'])) {
    $t=$_POST['table'] ?? ''; if (!tableAllowed($t) || !hash_equals($_SESSION['csrf'], $_POST['csrf'] ?? '')) exit('Permintaan tidak valid.');
    $cols=columns($pdo,$t); $pk=primaryKey($cols); $fk=foreignKeys($pdo,$t); $data=[];
    foreach($cols as $c) {
        $name=$c['Field']; $extra=strtolower($c['Extra']);
        if ($name===$pk && str_contains($extra,'auto_increment')) continue;
        if (in_array($name,['tanggal_transaksi','tanggal_pemesanan'],true) && empty($_POST[$name])) continue;
        if (isset($_POST[$name])) $data[$name]=$_POST[$name]==='' ? null : $_POST[$name];
        elseif (str_contains(strtolower($c['Type']),'tinyint(1)')) $data[$name]=0;
    }
    try {
        if (($_POST['record_id'] ?? '') !== '') {
            $sets=[]; foreach(array_keys($data) as $col) $sets[]="`{$col}`=?";
            if ($sets) { $sql="UPDATE `{$t}` SET ".implode(',',$sets)." WHERE `{$pk}`=?"; $vals=array_values($data); $vals[]=$_POST['record_id']; $s=$pdo->prepare($sql); $s->execute($vals); }
            flash('Data berhasil diperbarui.');
        } else {
            $names=array_keys($data); $sql="INSERT INTO `{$t}` (`".implode('`,`',$names)."`) VALUES (".implode(',',array_fill(0,count($names),'?')).")";
            $s=$pdo->prepare($sql); $s->execute(array_values($data)); flash('Data berhasil ditambahkan.');
        }
        redirectTo('index.php?table='.urlencode($t));
    } catch(PDOException $e) { $formError='Gagal menyimpan data: '.$e->getMessage(); $table=$t; $action='form'; $id=$_POST['record_id'] ?? null; }
}
$flash=$_SESSION['flash'] ?? null; unset($_SESSION['flash']);
$pageTitle=$table ? ($labels[$table] ?? $table) : 'Dashboard';
$rows=[]; $cols=[]; $record=null; $fk=[]; $formError=$formError ?? null;
if ($table) {
    if ($action==='create') $action='form';
    $cols=columns($pdo,$table); $pk=primaryKey($cols); $fk=foreignKeys($pdo,$table);
    if ($action==='edit' && $id!==null) { $s=$pdo->prepare("SELECT * FROM `{$table}` WHERE `{$pk}`=?"); $s->execute([$id]); $record=$s->fetch(); if(!$record) { flash('Data tidak ditemukan.','warning'); redirectTo('index.php?table='.$table); } $action='form'; }
    if ($action==='form' && !$record && $id!==null) { $s=$pdo->prepare("SELECT * FROM `{$table}` WHERE `{$pk}`=?"); $s->execute([$id]); $record=$s->fetch(); }
    if ($action==='list') {
        $search=trim($_GET['q'] ?? ''); $sql="SELECT * FROM `{$table}`"; $params=[];
        if($search!=='') { $parts=[]; foreach($cols as $c) { if(preg_match('/char|text|enum|year|int|decimal|date|time/i',$c['Type'])) { $parts[]="CAST(`{$c['Field']}` AS CHAR) LIKE ?"; $params[]="%{$search}%"; } } if($parts) $sql.=' WHERE '.implode(' OR ',$parts); }
        $sql.=" ORDER BY `{$pk}` DESC LIMIT 200"; $s=$pdo->prepare($sql); $s->execute($params); $rows=$s->fetchAll();
    }
}
function renderField(PDO $pdo,array $c,array $fk,array $record): void {
    $name=$c['Field']; $type=strtolower($c['Type']); $value=$record[$name] ?? ($c['Default'] ?? ''); $nullable=$c['Null']==='YES'; $extra=strtolower($c['Extra']);
    if($name===primaryKey(columns($pdo, $_GET['table'] ?? '')) && str_contains($extra,'auto_increment')) return;
    $required=!$nullable && $c['Default']===null && !str_contains($extra,'auto_increment') && !str_contains($type,'timestamp');
    $label=ucwords(str_replace('_',' ',$name)); echo '<div class="mb-3"><label class="form-label">'.h($label).($required?' <span class="text-danger">*</span>':'').'</label>';
    if(isset($fk[$name])) {
        $r=$fk[$name]; $refTable=$r['REFERENCED_TABLE_NAME']; $refCol=$r['REFERENCED_COLUMN_NAME']; $refCols=columns($pdo,$refTable); $display=$refCol;
        foreach($refCols as $rc) if($rc['Field']!==$refCol && preg_match('/nama|judul|kode|kota|quest|session/i',$rc['Field'])) {$display=$rc['Field'];break;}
        $opts=$pdo->query("SELECT `{$refCol}` AS id, `{$display}` AS label FROM `{$refTable}` ORDER BY `{$refCol}` DESC LIMIT 500")->fetchAll();
        echo '<select class="form-select" name="'.h($name).'" '.($required?'required':'').'><option value="">-- Pilih '.h($label).' --</option>'; foreach($opts as $o) echo '<option value="'.h($o['id']).'" '.((string)$value===(string)$o['id']?'selected':'').'>'.h($o['id'].' - '.$o['label']).'</option>'; echo '</select>';
    } elseif(str_starts_with($type,'enum(')) {
        echo '<select class="form-select" name="'.h($name).'" '.($required?'required':'').'><option value="">-- Pilih --</option>'; foreach(enumValues($type) as $v) echo '<option '.((string)$value===$v?'selected':'').' value="'.h($v).'">'.h($v).'</option>'; echo '</select>';
    } elseif(str_contains($type,'text')) {
        echo '<textarea class="form-control" name="'.h($name).'" rows="4" '.($required?'required':'').'>'.h($value).'</textarea>';
    } else {
        $input='text'; if(str_contains($type,'int')||str_contains($type,'decimal')||str_contains($type,'float')) $input='number'; elseif(str_contains($type,'date') && !str_contains($type,'datetime')) $input='date'; elseif(str_contains($type,'time') && !str_contains($type,'datetime')) $input='time'; elseif(str_contains($type,'datetime')||str_contains($type,'timestamp')) $input='datetime-local'; elseif(str_contains($type,'year')) $input='number';
        $step=str_contains($type,'decimal')?'0.01':(str_contains($type,'int')?'1':''); $min=str_contains($type,'int')||str_contains($type,'decimal')?' min="0"':'';
        if(str_contains($type,'tinyint(1)')) { echo '<select class="form-select" name="'.h($name).'"> <option value="1" '.((string)$value==='1'?'selected':'').'>Aktif / Ya</option><option value="0" '.((string)$value==='0'?'selected':'').'>Nonaktif / Tidak</option></select>'; }
        else { $v=$value; if($input==='datetime-local' && $v) $v=date('Y-m-d\TH:i',strtotime($v)); echo '<input class="form-control" type="'.h($input).'" name="'.h($name).'" value="'.h($v).'" '.($required?'required':'').($step?' step="'.$step.'"':'').$min.'>'; }
    }
    echo '<div class="form-text">Tipe database: '.h($c['Type']).($nullable?' · boleh kosong':' · wajib diisi').'</div></div>';
}
?>
<!doctype html><html lang="id"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title><?=h($pageTitle)?> | Wali Band Admin</title><link rel="stylesheet" href="assets/dist/css/adminlte.min.css"><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.2/css/all.min.css"><style>.brand-text{font-weight:600}.content-wrapper{min-height:100vh}.table td{vertical-align:middle}.small-box h3{font-size:2rem}</style></head>
<body class="layout-fixed sidebar-expand-lg sidebar-open bg-body-tertiary"><div class="app-wrapper">
<nav class="app-header navbar navbar-expand bg-body"><div class="container-fluid"><ul class="navbar-nav"><li class="nav-item"><a class="nav-link" data-lte-toggle="sidebar" href="#"><i class="fa-solid fa-bars"></i></a></li><li class="nav-item d-none d-md-block"><a href="index.php" class="nav-link">Wali Band Admin</a></li></ul><ul class="navbar-nav ms-auto"><li class="nav-item"><span class="nav-link"><i class="fa-solid fa-user-shield me-1"></i> Administrator</span></li></ul></div></nav>
<aside class="app-sidebar bg-dark shadow" data-bs-theme="dark"><div class="sidebar-brand"><a href="index.php" class="brand-link"><img src="assets/dist/assets/img/AdminLTELogo.png" class="brand-image opacity-75 shadow" alt="AdminLTE"><span class="brand-text">Wali Band Admin</span></a></div><div class="sidebar-wrapper"><nav class="mt-2"><ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="menu" data-accordion="false"><li class="nav-item"><a href="index.php" class="nav-link <?=!$table?'active':''?>"><i class="nav-icon fa-solid fa-gauge"></i><p>Dashboard</p></a></li>
<?php foreach($groups as $group=>$tables): ?><li class="nav-header"><?=h(strtoupper($group))?></li><?php foreach($tables as $t): ?><li class="nav-item"><a href="index.php?table=<?=h($t)?>" class="nav-link <?=$table===$t?'active':''?>"><i class="nav-icon fa-regular fa-circle"></i><p><?=h($labels[$t]??$t)?></p></a></li><?php endforeach; endforeach; ?>
</ul></nav></div></aside>
<main class="app-main"><div class="app-content-header"><div class="container-fluid"><div class="row"><div class="col-sm-6"><h3 class="mb-0"><?=h($pageTitle)?></h3></div><div class="col-sm-6"><ol class="breadcrumb float-sm-end"><li class="breadcrumb-item"><a href="index.php">Home</a></li><li class="breadcrumb-item active"><?=h($pageTitle)?></li></ol></div></div></div></div>
<div class="app-content"><div class="container-fluid">
<?php if($flash): ?><div class="alert alert-<?=h($flash['type'])?> alert-dismissible"><button type="button" class="btn-close" data-bs-dismiss="alert"></button><?=h($flash['message'])?></div><?php endif; ?>
<?php if($formError): ?><div class="alert alert-danger"><?=h($formError)?></div><?php endif; ?>
<?php if(!$table): ?>
<div class="row"><div class="col-12"><div class="card"><div class="card-header"><h3 class="card-title">Ringkasan Database</h3></div><div class="card-body"><p>Selamat datang di panel administrasi website Wali Band. Pilih modul pada sidebar untuk mengelola data.</p></div></div></div></div>
<div class="row"><?php foreach($groups as $group=>$tables): foreach($tables as $t): $count=(int)$pdo->query("SELECT COUNT(*) FROM `{$t}`")->fetchColumn(); ?><div class="col-xl-3 col-md-4 col-sm-6"><div class="small-box text-bg-primary"><div class="inner"><h3><?=number_format($count)?></h3><p><?=h($labels[$t]??$t)?></p></div><div class="small-box-icon"><i class="fa-solid fa-database"></i></div><a href="index.php?table=<?=h($t)?>" class="small-box-footer link-light link-underline-opacity-0">Kelola data <i class="fa-solid fa-arrow-circle-right"></i></a></div></div><?php endforeach; endforeach; ?></div>
<?php elseif($action==='form'): ?>
<div class="card card-primary card-outline"><div class="card-header"><h3 class="card-title"><?=$record?'Ubah':'Tambah'?> <?=h($pageTitle)?></h3></div><form method="post"><div class="card-body"><input type="hidden" name="csrf" value="<?=h($_SESSION['csrf'])?>"><input type="hidden" name="table" value="<?=h($table)?>"><input type="hidden" name="record_id" value="<?=h($record[$pk]??'')?>"><input type="hidden" name="save_record" value="1"><div class="row"><?php foreach($cols as $c): ?><div class="col-lg-6"><?php renderField($pdo,$c,$fk,$record??[]); ?></div><?php endforeach; ?></div></div><div class="card-footer"><button class="btn btn-primary" type="submit"><i class="fa-solid fa-floppy-disk me-1"></i> Simpan</button> <a class="btn btn-secondary" href="index.php?table=<?=h($table)?>">Batal</a></div></form></div>
<?php else: ?>
<div class="card"><div class="card-header"><h3 class="card-title">Data <?=h($pageTitle)?></h3><div class="card-tools"><a href="index.php?table=<?=h($table)?>&action=create" class="btn btn-primary btn-sm"><i class="fa-solid fa-plus me-1"></i> Tambah Data</a></div></div><div class="card-body"><form class="row g-2 mb-3" method="get"><input type="hidden" name="table" value="<?=h($table)?>"><div class="col-md-5"><input class="form-control" name="q" value="<?=h($_GET['q']??'')?>" placeholder="Cari data..."></div><div class="col-auto"><button class="btn btn-outline-primary"><i class="fa-solid fa-search"></i> Cari</button> <a class="btn btn-outline-secondary" href="index.php?table=<?=h($table)?>">Reset</a></div></form><div class="table-responsive"><table class="table table-bordered table-striped table-hover"><thead><tr><?php foreach($cols as $c): ?><th><?=h(ucwords(str_replace('_',' ',$c['Field'])))?></th><?php endforeach; ?><th style="min-width:135px">Aksi</th></tr></thead><tbody><?php if(!$rows): ?><tr><td colspan="<?=count($cols)+1?>" class="text-center text-muted py-4">Belum ada data.</td></tr><?php else: foreach($rows as $r): ?><tr><?php foreach($cols as $c): ?><td><?=h(displayValue($r[$c['Field']]))?></td><?php endforeach; ?><td class="text-nowrap"><a class="btn btn-warning btn-sm" href="index.php?table=<?=h($table)?>&action=edit&id=<?=h($r[$pk])?>"><i class="fa-solid fa-pen"></i> Edit</a> <form method="post" class="d-inline" onsubmit="return confirm('Yakin ingin menghapus data ini?')"><input type="hidden" name="csrf" value="<?=h($_SESSION['csrf'])?>"><input type="hidden" name="delete_table" value="<?=h($table)?>"><input type="hidden" name="delete_id" value="<?=h($r[$pk])?>"><button class="btn btn-danger btn-sm"><i class="fa-solid fa-trash"></i> Hapus</button></form></td></tr><?php endforeach; endif; ?></tbody></table></div><small class="text-muted">Menampilkan maksimal 200 baris data terbaru.</small></div></div>
<?php endif; ?>
</div></div></main><footer class="app-footer"><strong>Wali Band Admin</strong> · AdminLTE 4.10.0 · PHP Native & MySQL</footer></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script><script src="assets/dist/js/adminlte.min.js"></script></body></html>
