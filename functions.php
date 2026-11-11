<?php
$groups = [
 'Profil Website' => ['profil_beranda','profil_tentang','profil_musik','profil_tur','profil_halaman_toko'],
 'Band' => ['personil_band','karir','penghargaan'],
 'Musik' => ['album_musik','tabel_daftar_lagu_hits'],
 'Tur & Konser' => ['jadwal_tur','faq_tur','galeri_konser','kategori_tiket'],
 'Toko Merchandise' => ['produk_toko','variasi_ukuran_produk'],
 'Transaksi' => ['pesanan_tiket','detail_pemilik_tiket','keranjang_tiket','pesanan_toko','detail_pesanan_toko','keranjang_toko'],
];
$labels = [
 'profil_beranda'=>'Profil Beranda','profil_tentang'=>'Profil Tentang','profil_musik'=>'Profil Musik','profil_tur'=>'Profil Tur','profil_halaman_toko'=>'Profil Halaman Toko',
 'personil_band'=>'Personil Band','karir'=>'Riwayat Karir','penghargaan'=>'Penghargaan','faq_tur'=>'FAQ Tur','album_musik'=>'Album Musik','jadwal_tur'=>'Jadwal Tur','produk_toko'=>'Produk Toko','pesanan_tiket'=>'Pesanan Tiket','pesanan_toko'=>'Pesanan Toko','tabel_daftar_lagu_hits'=>'Daftar Lagu','galeri_konser'=>'Galeri Konser','kategori_tiket'=>'Kategori Tiket','keranjang_tiket'=>'Keranjang Tiket','detail_pemilik_tiket'=>'Detail Pemilik Tiket','variasi_ukuran_produk'=>'Variasi Ukuran Produk','keranjang_toko'=>'Keranjang Toko','detail_pesanan_toko'=>'Detail Pesanan Toko'
];
function h($v) { return htmlspecialchars((string)($v ?? ''), ENT_QUOTES, 'UTF-8'); }
function tableAllowed($table) { global $groups; foreach ($groups as $tables) if (in_array($table, $tables, true)) return true; return false; }
function columns(PDO $pdo, string $table): array {
    $stmt = $pdo->query("SHOW COLUMNS FROM `{$table}`");
    return $stmt->fetchAll();
}
function primaryKey(array $cols): string { foreach ($cols as $c) if ($c['Key'] === 'PRI') return $c['Field']; return $cols[0]['Field']; }
function foreignKeys(PDO $pdo, string $table): array {
    $sql = "SELECT COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? AND REFERENCED_TABLE_NAME IS NOT NULL";
    $s=$pdo->prepare($sql); $s->execute([$table]); $out=[]; foreach($s as $r) $out[$r['COLUMN_NAME']]=$r; return $out;
}
function enumValues(string $type): array {
    if (!preg_match('/^(enum|set)\((.*)\)$/i', $type, $m)) return [];
    preg_match_all("/'((?:\\\\'|[^'])*)'/", $m[2], $matches);
    return array_map(fn($v)=>str_replace("\\'", "'", $v), $matches[1]);
}
function displayValue($value): string {
    if ($value === null || $value === '') return '—';
    return mb_strimwidth((string)$value, 0, 65, '…', 'UTF-8');
}
