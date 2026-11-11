CREATE DATABASE `db_wali_band`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `db_wali_band`;

CREATE TABLE `profil_beranda` (
  `id_profil` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik tabel',
  `tagline` varchar(255) NOT NULL COMMENT 'Slogan utama pada banner hero',
  `teks_sejarah` text NOT NULL COMMENT 'Paragraf ringkasan sejarah Wali Band',
  `url_foto_banner` varchar(255) DEFAULT NULL COMMENT 'Path/URL file gambar hero banner',
  `url_foto_disamping_sejarah` varchar(255) DEFAULT NULL COMMENT 'Path/URL file foto di samping seksi sejarah',
  PRIMARY KEY (`id_profil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `profil_tentang` (
  `id_tentang` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik tabel',
  `url_photo` varchar(255) DEFAULT NULL COMMENT 'Path/URL foto utama halaman tentang',
  `sejarah_lengkap` text NOT NULL COMMENT 'Teks narasi sejarah lengkap Wali Band',
  PRIMARY KEY (`id_tentang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `profil_musik` (
  `id_profil_musik` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik',
  `url_photo` varchar(255) DEFAULT NULL COMMENT 'Path/URL foto banner utama halaman musik',
  PRIMARY KEY (`id_profil_musik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `profil_tur` (
  `id_profil_tur` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik',
  `url_photo` varchar(255) DEFAULT NULL COMMENT 'Path/URL foto banner header tur',
  PRIMARY KEY (`id_profil_tur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `profil_halaman_toko` (
  `id_profil_toko` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik',
  `url_photo` varchar(255) DEFAULT NULL COMMENT 'Path/URL foto banner header toko',
  PRIMARY KEY (`id_profil_toko`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `personil_band` (
  `id_personil` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik personil',
  `nama_panggung` varchar(100) NOT NULL COMMENT 'Nama panggung personil (misal: Faank)',
  `posisi` varchar(50) NOT NULL COMMENT 'Posisi/peran (Vokalis, Gitaris, dll)',
  `url_photo_personil` varchar(255) DEFAULT NULL COMMENT 'Path/URL foto profil personil',
  `deskripsi_profil` text COMMENT 'Biografi/deskripsi singkat personil',
  PRIMARY KEY (`id_personil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `karir` (
  `id_karir` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik',
  `tahun` year NOT NULL COMMENT 'Tahun peristiwa/momen penting',
  `deskripsi_kejadian` text NOT NULL COMMENT 'Penjelasan peristiwa perjalanan karir',
  PRIMARY KEY (`id_karir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `penghargaan` (
  `id_penghargaan` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik',
  `nama_penghargaan` varchar(150) NOT NULL COMMENT 'Nama penghargaan/piala yang diraih',
  `tahun` year DEFAULT NULL COMMENT 'Tahun penerimaan penghargaan',
  `deskripsi_penghargaan` text COMMENT 'Kategori atau keterangan penghargaan',
  PRIMARY KEY (`id_penghargaan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `faq_tur` (
  `id_faq` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik FAQ',
  `quest` text NOT NULL COMMENT 'Pertanyaan (Question)',
  `answer` text NOT NULL COMMENT 'Jawaban (Answer)',
  PRIMARY KEY (`id_faq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `album_musik` (
  `id_album` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik album',
  `judul_album` varchar(100) NOT NULL COMMENT 'Judul album',
  `tahun_rilis` year NOT NULL COMMENT 'Tahun peluncuran album',
  `jumlah_lagu` int DEFAULT '0' COMMENT 'Jumlah trek lagu dalam album (angka resmi, bukan COUNT tabel lagu)',
  `produser_lagu` varchar(100) DEFAULT NULL COMMENT 'Nama produser/label rekaman',
  `deskripsi_album` text COMMENT 'Deskripsi ringkas album',
  `url_cover` varchar(255) DEFAULT NULL COMMENT 'Path/URL gambar cover album (tampil di Beranda & Musik)',
  PRIMARY KEY (`id_album`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `jadwal_tur` (
  `id_tur` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik tur',
  `tgl_konser` date NOT NULL COMMENT 'Tanggal pelaksanaan konser',
  `kota` varchar(100) NOT NULL COMMENT 'Kota lokasi konser',
  `lokasi_venue` varchar(150) NOT NULL COMMENT 'Nama venue / stadion / lokasi',
  `nama_acara` varchar(150) NOT NULL COMMENT 'Nama festival / tur konser',
  `open_gate` time DEFAULT NULL COMMENT 'Jam buka pintu venue (contoh: 16:00:00)',
  `status` enum('Akan Datang','Selesai') DEFAULT 'Akan Datang' COMMENT 'Status acara',
  PRIMARY KEY (`id_tur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `produk_toko` (
  `id_produk` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik produk',
  `nama_produk` varchar(150) NOT NULL COMMENT 'Nama barang/merchandise',
  `deskripsi_singkat` text COMMENT 'Keterangan bahan, desain, dan informasi produk',
  `harga_satuan` decimal(12,2) NOT NULL COMMENT 'Harga produk per unit (Rupiah)',
  `url_gambar` varchar(255) DEFAULT NULL COMMENT 'Path/URL file foto produk utama',
  `status_tampil` tinyint(1) DEFAULT '1' COMMENT 'Status tayang (1 = Tersedia/Aktif, 0 = Sembunyikan)',
  PRIMARY KEY (`id_produk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `pesanan_tiket` (
  `id_pesanan_tiket` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik transaksi',
  `kode_pesanan` varchar(30) NOT NULL COMMENT 'Nomor pesanan tampil ke pembeli (TKT-20260815-0001)',
  `nama_pemesan` varchar(100) NOT NULL COMMENT 'Nama lengkap pembeli',
  `email_pemesan` varchar(100) NOT NULL COMMENT 'Email penagihan & pengiriman e-ticket',
  `no_wa_pemesan` varchar(20) NOT NULL COMMENT 'Nomor WhatsApp pemesan',
  `total_harga` decimal(12,2) NOT NULL COMMENT 'Total nominal tagihan (Rupiah)',
  `metode_pembayaran` varchar(50) NOT NULL COMMENT 'Metode bayar (QRIS, Transfer VA, E-Wallet)',
  `status_pembayaran` enum('Menunggu','Lunas','Gagal','Kedaluwarsa') DEFAULT 'Menunggu' COMMENT 'Status transaksi',
  `id_transaksi_gateway` varchar(100) DEFAULT NULL COMMENT 'ID transaksi dari payment gateway',
  `tanggal_transaksi` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu terjadinya transaksi',
  `batas_waktu_bayar` datetime DEFAULT NULL COMMENT 'Batas akhir pembayaran; lewat = Kedaluwarsa',
  PRIMARY KEY (`id_pesanan_tiket`),
  UNIQUE KEY `uq_pesanan_tiket_kode` (`kode_pesanan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `pesanan_toko` (
  `id_pesanan_toko` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik pesanan',
  `kode_pesanan` varchar(30) NOT NULL COMMENT 'Nomor pesanan tampil ke pembeli (MRC-20260815-0001)',
  `nama_penerima` varchar(100) NOT NULL COMMENT 'Nama lengkap penerima paket',
  `email_pembeli` varchar(100) NOT NULL COMMENT 'Email untuk konfirmasi & resi',
  `no_wa_penerima` varchar(20) NOT NULL COMMENT 'Nomor WhatsApp penerima / pembeli',
  `alamat_lengkap` text NOT NULL COMMENT 'Alamat jalan, RT/RW, dan patokan',
  `provinsi` varchar(100) NOT NULL COMMENT 'Provinsi alamat pengiriman',
  `kota_kabupaten` varchar(100) NOT NULL COMMENT 'Kota/kabupaten alamat pengiriman',
  `kode_pos` varchar(10) NOT NULL COMMENT 'Kode pos alamat pengiriman',
  `ongkos_kirim` decimal(12,2) NOT NULL COMMENT 'Biaya pengiriman kurir (Rupiah)',
  `total_belanja` decimal(12,2) NOT NULL COMMENT 'Total tagihan (Barang + Ongkir)',
  `metode_pembayaran` varchar(50) NOT NULL COMMENT 'Metode bayar (Transfer VA, QRIS, dll)',
  `status_pembayaran` enum('Menunggu','Lunas','Gagal','Kedaluwarsa') DEFAULT 'Menunggu' COMMENT 'Status pembayaran (terpisah dari status pengiriman)',
  `id_transaksi_gateway` varchar(100) DEFAULT NULL COMMENT 'ID transaksi dari payment gateway',
  `status_pesanan` enum('Menunggu','Diproses','Dikirim','Selesai','Dibatalkan') DEFAULT 'Menunggu' COMMENT 'Status progres pesanan',
  `kurir` varchar(50) DEFAULT NULL COMMENT 'Nama kurir pengiriman (JNE, J&T, dll)',
  `nomor_resi` varchar(100) DEFAULT NULL COMMENT 'Nomor resi pelacakan kurir',
  `tanggal_pemesanan` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Waktu terjadinya transaksi',
  `batas_waktu_bayar` datetime DEFAULT NULL COMMENT 'Batas akhir pembayaran; lewat = Kedaluwarsa',
  PRIMARY KEY (`id_pesanan_toko`),
  UNIQUE KEY `uq_pesanan_toko_kode` (`kode_pesanan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tabel_daftar_lagu_hits` (
  `id_lagu` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik lagu',
  `id_album` int NOT NULL COMMENT 'Foreign Key penghubung ke album',
  `judul_lagu` varchar(150) NOT NULL COMMENT 'Judul lagu',
  `durasi` varchar(10) DEFAULT NULL COMMENT 'Durasi lagu (contoh: 03:45)',
  `lirik_lagu` text COMMENT 'Teks lirik lagu lengkap',
  `url_lagu` varchar(255) DEFAULT NULL COMMENT 'Path/URL file audio atau streaming',
  PRIMARY KEY (`id_lagu`),
  KEY `fk_lagu_album` (`id_album`),
  CONSTRAINT `fk_lagu_album` FOREIGN KEY (`id_album`)
    REFERENCES `album_musik` (`id_album`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `galeri_konser` (
  `id_galeri` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik galeri',
  `id_tur` int DEFAULT NULL COMMENT '(Opsional) Relasi ke tur tertentu',
  `url_gambar` varchar(255) NOT NULL COMMENT 'Path/URL file foto dokumentasi',
  PRIMARY KEY (`id_galeri`),
  KEY `fk_galeri_tur` (`id_tur`),
  CONSTRAINT `fk_galeri_tur` FOREIGN KEY (`id_tur`)
    REFERENCES `jadwal_tur` (`id_tur`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `kategori_tiket` (
  `id_kategori_tiket` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik kategori',
  `id_tur` int NOT NULL COMMENT 'Kategori ini berlaku untuk konser mana',
  `nama_kategori` varchar(50) NOT NULL COMMENT 'Nama kategori (Reguler, VIP, VVIP)',
  `deskripsi_benefit` varchar(255) DEFAULT NULL COMMENT 'Benefit kategori',
  `harga` decimal(12,2) NOT NULL COMMENT 'Harga tiket per kategori (Rupiah)',
  `kuota` int NOT NULL DEFAULT '0' COMMENT 'Jumlah tiket yang tersedia',
  PRIMARY KEY (`id_kategori_tiket`),
  KEY `fk_kategori_tur` (`id_tur`),
  CONSTRAINT `fk_kategori_tur` FOREIGN KEY (`id_tur`)
    REFERENCES `jadwal_tur` (`id_tur`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `keranjang_tiket` (
  `id_keranjang_tiket` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik keranjang tiket',
  `session_id` varchar(100) NOT NULL COMMENT 'ID sesi browser/pengguna unik',
  `id_kategori_tiket` int NOT NULL COMMENT 'Foreign Key ke kategori tiket',
  `jumlah` int NOT NULL DEFAULT '1' COMMENT 'Jumlah tiket yang dimasukkan',
  PRIMARY KEY (`id_keranjang_tiket`),
  KEY `fk_keranjang_tiket_kategori` (`id_kategori_tiket`),
  CONSTRAINT `fk_keranjang_tiket_kategori` FOREIGN KEY (`id_kategori_tiket`)
    REFERENCES `kategori_tiket` (`id_kategori_tiket`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `detail_pemilik_tiket` (
  `id_tiket` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik e-ticket',
  `id_pesanan_tiket` int NOT NULL COMMENT 'Foreign Key ke header pemesanan',
  `id_kategori_tiket` int NOT NULL COMMENT 'Relasi ke kategori tiket',
  `harga_saat_beli` decimal(12,2) NOT NULL COMMENT 'Snapshot harga saat transaksi',
  `nama_depan` varchar(50) NOT NULL COMMENT 'Nama depan pemegang tiket',
  `nama_belakang` varchar(50) DEFAULT NULL COMMENT 'Nama belakang pemegang tiket',
  `jenis_identitas` enum('KTP','SIM','Paspor','Kartu Pelajar') NOT NULL COMMENT 'Jenis dokumen identitas',
  `nomor_identitas` varchar(50) NOT NULL COMMENT 'Nomor NIK / KTP / SIM / Paspor',
  `email_pemilik` varchar(100) NOT NULL COMMENT 'Email pemilik tiket',
  `no_wa_pemilik` varchar(20) NOT NULL COMMENT 'Nomor WhatsApp pemilik tiket',
  `umur` tinyint NOT NULL COMMENT 'Usia pemilik tiket',
  `kabupaten_kota` varchar(100) NOT NULL COMMENT 'Kota asal domisili pemilik tiket',
  `jenis_kelamin` enum('L','P') NOT NULL COMMENT 'L = Laki-laki, P = Perempuan',
  `kode_barcode` varchar(100) NOT NULL COMMENT 'Kode acak/hash unik untuk QR Code entry',
  `status_checkin` enum('Belum Checkin','Sudah Checkin') DEFAULT 'Belum Checkin' COMMENT 'Status scan di pintu masuk',
  `waktu_checkin` datetime DEFAULT NULL COMMENT 'Waktu tiket di-scan di pintu masuk',
  PRIMARY KEY (`id_tiket`),
  UNIQUE KEY `uq_tiket_barcode` (`kode_barcode`),
  KEY `fk_tiket_pesanan` (`id_pesanan_tiket`),
  KEY `fk_tiket_kategori` (`id_kategori_tiket`),
  CONSTRAINT `fk_tiket_pesanan` FOREIGN KEY (`id_pesanan_tiket`)
    REFERENCES `pesanan_tiket` (`id_pesanan_tiket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tiket_kategori` FOREIGN KEY (`id_kategori_tiket`)
    REFERENCES `kategori_tiket` (`id_kategori_tiket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `variasi_ukuran_produk` (
  `id_variasi` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik variasi',
  `id_produk` int NOT NULL COMMENT 'Foreign Key penghubung ke produk',
  `ukuran` varchar(10) NOT NULL COMMENT 'Ukuran barang (S, M, L, XL, XXL, All Size)',
  `stok_tersedia` int DEFAULT '0' COMMENT 'Jumlah sisa stok unit yang tersedia',
  PRIMARY KEY (`id_variasi`),
  KEY `fk_variasi_produk` (`id_produk`),
  CONSTRAINT `fk_variasi_produk` FOREIGN KEY (`id_produk`)
    REFERENCES `produk_toko` (`id_produk`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `keranjang_toko` (
  `id_keranjang` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik keranjang',
  `session_id` varchar(100) NOT NULL COMMENT 'ID sesi browser/pengguna unik',
  `id_variasi` int NOT NULL COMMENT 'Foreign Key ke variasi produk & ukuran',
  `jumlah` int DEFAULT '1' COMMENT 'Jumlah kuantitas item yang dimasukkan',
  PRIMARY KEY (`id_keranjang`),
  KEY `fk_keranjang_variasi` (`id_variasi`),
  CONSTRAINT `fk_keranjang_variasi` FOREIGN KEY (`id_variasi`)
    REFERENCES `variasi_ukuran_produk` (`id_variasi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `detail_pesanan_toko` (
  `id_detail_toko` int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key unik rincian item',
  `id_pesanan_toko` int NOT NULL COMMENT 'Foreign Key ke header pesanan',
  `id_variasi` int NOT NULL COMMENT 'Foreign Key ke item variasi ukuran',
  `jumlah_beli` int NOT NULL COMMENT 'Kuantitas produk yang dibeli',
  `harga_satuan` decimal(12,2) NOT NULL COMMENT 'Harga per unit saat transaksi terjadi',
  `sub_total` decimal(12,2) NOT NULL COMMENT 'jumlah_beli x harga_satuan',
  PRIMARY KEY (`id_detail_toko`),
  KEY `fk_detail_toko_pesanan` (`id_pesanan_toko`),
  KEY `fk_detail_toko_variasi` (`id_variasi`),
  CONSTRAINT `fk_detail_toko_pesanan` FOREIGN KEY (`id_pesanan_toko`)
    REFERENCES `pesanan_toko` (`id_pesanan_toko`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detail_toko_variasi` FOREIGN KEY (`id_variasi`)
    REFERENCES `variasi_ukuran_produk` (`id_variasi`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
