
USE `db_wali_band`;

INSERT INTO `profil_beranda` (`id_profil`, `tagline`, `teks_sejarah`, `url_foto_banner`, `url_foto_disamping_sejarah`) VALUES
(1, 'Membawa pesan perdamaian, harapan, dan cinta melalui melodi sejak 1999.',
 'Wali Band dibentuk pada bulan Oktober 1999 di Ciputat, Tangerang Selatan. Sangat berakar pada tema-tema spiritual dan cerita sehari-hari yang tulus.',
 '/img/banner.jpg', '/img/sejarah.jpg');

INSERT INTO `profil_tentang` (`id_tentang`, `url_photo`, `sejarah_lengkap`) VALUES
(1, '/img/tentang.jpg',
 'Didirikan pada 31 Oktober 1999 di Ciputat, Tangerang Selatan, Wali Band bermula sebagai grup mahasiswa yang berbagi semangat untuk mengekspresikan perjuangan sehari-hari, wawasan spiritual, dan cinta melalui melodi pop yang mudah diakses.');

INSERT INTO `profil_musik` (`id_profil_musik`, `url_photo`) VALUES
(1, '/img/banner-musik.jpg');

INSERT INTO `profil_tur` (`id_profil_tur`, `url_photo`) VALUES
(1, '/img/banner-tur.jpg');

INSERT INTO `profil_halaman_toko` (`id_profil_toko`, `url_photo`) VALUES
(1, '/img/banner-toko.jpg');

INSERT INTO `personil_band` (`id_personil`, `nama_panggung`, `posisi`, `url_photo_personil`, `deskripsi_profil`) VALUES
(1, 'Faank', 'Vokalis', '/img/faank.jpg', 'Salah satu pendiri dan suara khas Wali.'),
(2, 'Apoy', 'Gitaris & Komposer', '/img/apoy.jpg', 'Dalang musik yang menulis dan menyusun lagu-lagu Wali.'),
(3, 'Tomi', 'Drummer', '/img/tomi.jpg', 'Menyediakan tulang punggung dan ritme yang solid dan energik.'),
(4, 'Ovie', 'Pemain Keyboard', '/img/ovie.jpg', 'Memperkaya lanskap suara Wali dengan lapisan piano yang indah.');

INSERT INTO `karir` (`id_karir`, `tahun`, `deskripsi_kejadian`) VALUES
(1, 1999, 'Fatih Band dibentuk di Tangerang Selatan, kemudian berganti nama menjadi WALI.'),
(2, 2008, 'Merilis album debut "Orang Bilang".'),
(3, 2009, 'Merilis album kedua "Cari Jodoh".'),
(4, 2010, 'Lagu andalan "Baik-Baik Sayang" diterjemahkan dan populer di berbagai negara.'),
(5, 2020, 'Merilis album "2020", merayakan lebih dari 20 tahun kreativitas berkelanjutan.');

INSERT INTO `penghargaan` (`id_penghargaan`, `nama_penghargaan`, `tahun`, `deskripsi_penghargaan`) VALUES
(1, 'SCTV Awards', 2010, 'Band Pop Paling Populer'),
(2, 'Pemegang Rekor MURI', NULL, 'Unduhan Ring Back Tone (RBT) tercepat'),
(3, 'Anugerah Musik Indonesia (AMI)', NULL, 'Grup Pop Melayu Terbaik, Desain Album Terbaik, Penjualan RBT Terbaik');

INSERT INTO `faq_tur` (`id_faq`, `quest`, `answer`) VALUES
(1, 'Di mana saya bisa membeli tiket konser resmi Wali Band?', 'Tiket resmi hanya dijual melalui website ini.'),
(2, 'Apakah ada batasan usia untuk masuk konser?', 'Silakan merujuk pada ketentuan masing-masing konser.'),
(3, 'Bisakah saya menukar atau mengembalikan tiket saya?', 'Tiket yang sudah dibeli tidak dapat dikembalikan.'),
(4, 'Barang apa saja yang sangat dilarang di dalam stadion?', 'Senjata tajam, obat terlarang, dan barang berbahaya lainnya.');

INSERT INTO `album_musik` (`id_album`, `judul_album`, `tahun_rilis`, `jumlah_lagu`, `produser_lagu`, `deskripsi_album`, `url_cover`) VALUES
(1, 'Orang Bilang', 2008, 10, 'Nagaswara Records', 'Album debut yang luar biasa termasuk hits utama "Emang Dasar" dan "Dik".', '/img/orang-bilang.jpg'),
(2, 'Cari Jodoh', 2009, 12, 'Nagaswara Records', 'Berisi "Baik-Baik Sayang" yang memecahkan jutaan rekor penjualan.', '/img/cari-jodoh.jpg'),
(3, 'Aku Bukan Bang Toyib', 2011, 10, 'Nagaswara Records', 'Narasi yang relevan, lucu namun menyentuh.', '/img/bang-toyib.jpg');

INSERT INTO `jadwal_tur` (`id_tur`, `tgl_konser`, `kota`, `lokasi_venue`, `nama_acara`, `open_gate`, `status`) VALUES
(1, '2026-08-15', 'Jakarta', 'Stadion Utama Gelora Bung Karno', 'Pertunjukan Arena Nasional', '17:00:00', 'Akan Datang'),
(2, '2026-08-18', 'Semarang', 'Stadion Jatidiri', 'Festival Jawa Tengah', '18:00:00', 'Akan Datang'),
(3, '2026-08-28', 'Bandung', 'Stadion Gelora Bandung Lautan Api', 'Tur Jawa Barat', '17:30:00', 'Akan Datang'),
(4, '2026-09-10', 'Surabaya', 'Stadion Gelora Bung Tomo', 'Tur Jawa Timur', '17:00:00', 'Akan Datang'),
(5, '2026-09-15', 'Yogyakarta', 'Stadion Mandala Krida', 'Konser Spesial Budaya', '18:00:00', 'Akan Datang');

INSERT INTO `produk_toko` (`id_produk`, `nama_produk`, `deskripsi_singkat`, `harga_satuan`, `url_gambar`, `status_tampil`) VALUES
(1, 'Kaos Parawali + ID Card', 'Kaos Parawali resmi dengan bonus ID card eksklusif.', 150000.00, '/img/kaos.jpg', 1),
(2, 'Jersey - Classic Stripe', 'Jersey olahraga WALI Classic Stripe.', 165000.00, '/img/jersey.jpg', 1),
(3, 'Topi Wali Official', 'Topi resmi Wali Band bahan katun.', 85000.00, '/img/topi.jpg', 1);

INSERT INTO `pesanan_tiket` (`id_pesanan_tiket`, `kode_pesanan`, `nama_pemesan`, `email_pemesan`, `no_wa_pemesan`, `total_harga`, `metode_pembayaran`, `status_pembayaran`, `id_transaksi_gateway`, `batas_waktu_bayar`) VALUES
(1, 'TKT-20260815-0001', 'Budi Santoso', 'budi@example.com', '081234567890', 750000.00, 'QRIS', 'Lunas', 'GTW-TKT-0001', '2026-08-10 23:59:59'),
(2, 'TKT-20260815-0002', 'Siti Aminah', 'siti@example.com', '081298765432', 1000000.00, 'Transfer VA', 'Menunggu', NULL, '2026-08-11 23:59:59');

INSERT INTO `pesanan_toko` (`id_pesanan_toko`, `kode_pesanan`, `nama_penerima`, `email_pembeli`, `no_wa_penerima`, `alamat_lengkap`, `provinsi`, `kota_kabupaten`, `kode_pos`, `ongkos_kirim`, `total_belanja`, `metode_pembayaran`, `status_pembayaran`, `id_transaksi_gateway`, `status_pesanan`, `kurir`, `nomor_resi`, `batas_waktu_bayar`) VALUES
(1, 'MRC-20260815-0001', 'Andi Pratama', 'andi@example.com', '081311112222', 'Jl. Merdeka No. 10, RT 02/RW 03', 'Kalimantan Barat', 'Pontianak', '78111', 20000.00, 485000.00, 'QRIS', 'Lunas', 'GTW-MRC-0001', 'Dikirim', 'JNE', 'JNE1234567890', '2026-08-12 23:59:59'),
(2, 'MRC-20260815-0002', 'Rina Wulandari', 'rina@example.com', '081333334444', 'Jl. Ahmad Yani No. 5', 'Kalimantan Barat', 'Kubu Raya', '78391', 15000.00, 165000.00, 'Transfer VA', 'Menunggu', NULL, 'Menunggu', NULL, NULL, '2026-08-13 23:59:59');

INSERT INTO `tabel_daftar_lagu_hits` (`id_lagu`, `id_album`, `judul_lagu`, `durasi`, `lirik_lagu`, `url_lagu`) VALUES
(1, 1, 'Orang Bilang', '03:42', NULL, NULL),
(2, 1, 'Emang Dasar', '03:20', NULL, NULL),
(3, 1, 'Dik', '04:15', NULL, NULL),
(4, 1, 'Egokah Aku', '03:52', NULL, NULL);

INSERT INTO `galeri_konser` (`id_galeri`, `id_tur`, `url_gambar`) VALUES
(1, NULL, '/img/galeri1.jpg'),
(2, NULL, '/img/galeri2.jpg'),
(3, 1, '/img/galeri3.jpg'),
(4, 2, '/img/galeri4.jpg');

INSERT INTO `kategori_tiket` (`id_kategori_tiket`, `id_tur`, `nama_kategori`, `deskripsi_benefit`, `harga`, `kuota`) VALUES
(1, 1, 'Reguler', 'Akses area festival', 250000.00, 5000),
(2, 1, 'VIP', 'Area duduk, Fast Track', 500000.00, 1000),
(3, 1, 'VVIP', 'Meet & Greet, Merchandise, Front Row', 1000000.00, 200),
(4, 2, 'Reguler', 'Akses area festival', 200000.00, 3000);

INSERT INTO `variasi_ukuran_produk` (`id_variasi`, `id_produk`, `ukuran`, `stok_tersedia`) VALUES
(1, 1, 'S', 20),
(2, 1, 'M', 30),
(3, 1, 'L', 30),
(4, 1, 'XL', 15),
(5, 2, 'M', 20),
(6, 2, 'L', 25),
(7, 2, 'XL', 10),
(8, 3, 'All Size', 40);

INSERT INTO `keranjang_tiket` (`id_keranjang_tiket`, `session_id`, `id_kategori_tiket`, `jumlah`) VALUES
(1, 'sess_a1b2c3d4e5', 1, 2),
(2, 'sess_f6g7h8i9j0', 4, 1);

INSERT INTO `keranjang_toko` (`id_keranjang`, `session_id`, `id_variasi`, `jumlah`) VALUES
(1, 'sess_a1b2c3d4e5', 1, 1),
(2, 'sess_f6g7h8i9j0', 5, 2);

INSERT INTO `detail_pemilik_tiket` (`id_tiket`, `id_pesanan_tiket`, `id_kategori_tiket`, `harga_saat_beli`, `nama_depan`, `nama_belakang`, `jenis_identitas`, `nomor_identitas`, `email_pemilik`, `no_wa_pemilik`, `umur`, `kabupaten_kota`, `jenis_kelamin`, `kode_barcode`, `status_checkin`, `waktu_checkin`) VALUES
(1, 1, 1, 250000.00, 'Budi', 'Santoso', 'KTP', '6171010101900001', 'budi@example.com', '081234567890', 28, 'Pontianak', 'L', 'WALI-TKT-0001-A1B2C3', 'Belum Checkin', NULL),
(2, 1, 2, 500000.00, 'Dewi', 'Lestari', 'KTP', '6171010202950002', 'dewi@example.com', '081234567891', 24, 'Pontianak', 'P', 'WALI-TKT-0001-D4E5F6', 'Belum Checkin', NULL),
(3, 2, 3, 1000000.00, 'Siti', 'Aminah', 'SIM', '120012345678', 'siti@example.com', '081298765432', 31, 'Kubu Raya', 'P', 'WALI-TKT-0002-G7H8I9', 'Belum Checkin', NULL);

INSERT INTO `detail_pesanan_toko` (`id_detail_toko`, `id_pesanan_toko`, `id_variasi`, `jumlah_beli`, `harga_satuan`, `sub_total`) VALUES
(1, 1, 2, 2, 150000.00, 300000.00),
(2, 1, 6, 1, 165000.00, 165000.00),
(3, 2, 3, 1, 150000.00, 150000.00);

SELECT * FROM `profil_beranda`;
SELECT * FROM `profil_tentang`;
SELECT * FROM `profil_musik`;
SELECT * FROM `profil_tur`;
SELECT * FROM `profil_halaman_toko`;
SELECT * FROM `personil_band`;
SELECT * FROM `karir`;
SELECT * FROM `penghargaan`;
SELECT * FROM `faq_tur`;
SELECT * FROM `album_musik`;
SELECT * FROM `tabel_daftar_lagu_hits`;
SELECT * FROM `jadwal_tur`;
SELECT * FROM `galeri_konser`;
SELECT * FROM `kategori_tiket`;
SELECT * FROM `keranjang_tiket`;
SELECT * FROM `pesanan_tiket`;
SELECT * FROM `detail_pemilik_tiket`;
SELECT * FROM `produk_toko`;
SELECT * FROM `variasi_ukuran_produk`;
SELECT * FROM `keranjang_toko`;
SELECT * FROM `pesanan_toko`;
SELECT * FROM `detail_pesanan_toko`;

SELECT l.`id_lagu`, l.`judul_lagu`, l.`durasi`, a.`judul_album`, a.`tahun_rilis`
FROM `tabel_daftar_lagu_hits` l
JOIN `album_musik` a ON l.`id_album` = a.`id_album`;

SELECT k.`id_kategori_tiket`, t.`nama_acara`, t.`kota`, t.`tgl_konser`, k.`nama_kategori`, k.`harga`, k.`kuota`
FROM `kategori_tiket` k
JOIN `jadwal_tur` t ON k.`id_tur` = t.`id_tur`;

SELECT d.`id_tiket`, p.`kode_pesanan`, CONCAT(d.`nama_depan`, ' ', d.`nama_belakang`) AS pemilik_tiket,
       k.`nama_kategori`, d.`harga_saat_beli`, d.`kode_barcode`, d.`status_checkin`
FROM `detail_pemilik_tiket` d
JOIN `pesanan_tiket` p ON d.`id_pesanan_tiket` = p.`id_pesanan_tiket`
JOIN `kategori_tiket` k ON d.`id_kategori_tiket` = k.`id_kategori_tiket`;

SELECT p.`nama_produk`, v.`ukuran`, v.`stok_tersedia`
FROM `variasi_ukuran_produk` v
JOIN `produk_toko` p ON v.`id_produk` = p.`id_produk`;

SELECT o.`kode_pesanan`, o.`nama_penerima`, p.`nama_produk`, v.`ukuran`,
       d.`jumlah_beli`, d.`harga_satuan`, d.`sub_total`
FROM `detail_pesanan_toko` d
JOIN `pesanan_toko` o ON d.`id_pesanan_toko` = o.`id_pesanan_toko`
JOIN `variasi_ukuran_produk` v ON d.`id_variasi` = v.`id_variasi`
JOIN `produk_toko` p ON v.`id_produk` = p.`id_produk`;

SELECT * FROM `jadwal_tur` WHERE `kota` = 'Jakarta';
SELECT * FROM `pesanan_tiket` WHERE `status_pembayaran` = 'Lunas';
SELECT * FROM `produk_toko` WHERE `status_tampil` = 1 ORDER BY `harga_satuan` DESC;
