-- =====================================================================
-- WBS 2.3 - Operasi UPDATE dan DELETE untuk Semua Tabel
-- Database : db_wali_band (MySQL)
-- Prasyarat: jalankan db_wali_band.sql lalu 02_insert_select.sql terlebih dahulu
-- =====================================================================

USE `db_wali_band`;

-- =====================================================================
-- BAGIAN A: UPDATE (mengubah data) - satu contoh untuk setiap tabel
-- =====================================================================

UPDATE `profil_beranda`
SET `tagline` = 'Membawa pesan perdamaian, harapan, dan cinta melalui melodi sejak 1999 hingga kini.'
WHERE `id_profil` = 1;

UPDATE `profil_tentang`
SET `url_photo` = '/img/tentang-baru.jpg'
WHERE `id_tentang` = 1;

UPDATE `profil_musik`
SET `url_photo` = '/img/banner-musik-baru.jpg'
WHERE `id_profil_musik` = 1;

UPDATE `profil_tur`
SET `url_photo` = '/img/banner-tur-baru.jpg'
WHERE `id_profil_tur` = 1;

UPDATE `profil_halaman_toko`
SET `url_photo` = '/img/banner-toko-baru.jpg'
WHERE `id_profil_toko` = 1;

UPDATE `personil_band`
SET `deskripsi_profil` = 'Salah satu pendiri dan vokalis dengan suara khas Wali.'
WHERE `id_personil` = 1;

UPDATE `karir`
SET `deskripsi_kejadian` = 'Merilis album debut "Orang Bilang" dengan hits "Emang Dasar".'
WHERE `id_karir` = 2;

UPDATE `penghargaan`
SET `tahun` = 2009
WHERE `id_penghargaan` = 2;

UPDATE `faq_tur`
SET `answer` = 'Tiket resmi hanya dijual melalui website resmi Wali Band.'
WHERE `id_faq` = 1;

UPDATE `album_musik`
SET `jumlah_lagu` = 11
WHERE `id_album` = 1;

UPDATE `tabel_daftar_lagu_hits`
SET `durasi` = '03:45', `url_lagu` = '/audio/orang-bilang.mp3'
WHERE `id_lagu` = 1;

UPDATE `jadwal_tur`
SET `status` = 'Selesai'
WHERE `id_tur` = 1;

UPDATE `galeri_konser`
SET `id_tur` = 3
WHERE `id_galeri` = 1;

UPDATE `kategori_tiket`
SET `harga` = 275000.00, `kuota` = 4500
WHERE `id_kategori_tiket` = 1;

UPDATE `keranjang_tiket`
SET `jumlah` = 3
WHERE `id_keranjang_tiket` = 1;

UPDATE `pesanan_tiket`
SET `status_pembayaran` = 'Lunas', `id_transaksi_gateway` = 'GTW-TKT-0002'
WHERE `id_pesanan_tiket` = 2;

UPDATE `detail_pemilik_tiket`
SET `status_checkin` = 'Sudah Checkin', `waktu_checkin` = '2026-08-15 17:30:00'
WHERE `id_tiket` = 1;

UPDATE `produk_toko`
SET `harga_satuan` = 155000.00
WHERE `id_produk` = 1;

UPDATE `variasi_ukuran_produk`
SET `stok_tersedia` = 18
WHERE `id_variasi` = 1;

UPDATE `keranjang_toko`
SET `jumlah` = 3
WHERE `id_keranjang` = 2;

UPDATE `pesanan_toko`
SET `status_pembayaran` = 'Lunas', `status_pesanan` = 'Diproses', `kurir` = 'J&T'
WHERE `id_pesanan_toko` = 2;

UPDATE `detail_pesanan_toko`
SET `jumlah_beli` = 3, `sub_total` = 450000.00
WHERE `id_detail_toko` = 3;

-- =====================================================================
-- BAGIAN B: DELETE (menghapus data) - satu contoh untuk setiap tabel
-- Urutan: tabel anak dahulu, baru tabel induk (menghindari error foreign key)
-- =====================================================================

-- ---------- B.1 Tabel anak / transaksi ----------

DELETE FROM `detail_pemilik_tiket` WHERE `id_tiket` = 3;
DELETE FROM `keranjang_tiket` WHERE `id_keranjang_tiket` = 2;
DELETE FROM `detail_pesanan_toko` WHERE `id_detail_toko` = 3;
DELETE FROM `keranjang_toko` WHERE `id_keranjang` = 2;
DELETE FROM `galeri_konser` WHERE `id_galeri` = 4;
DELETE FROM `tabel_daftar_lagu_hits` WHERE `id_lagu` = 4;

-- ---------- B.2 Tabel induk (setelah data anaknya terhapus) ----------

-- pesanan_tiket id 2: tiket miliknya (id_tiket 3) sudah dihapus di atas
DELETE FROM `pesanan_tiket` WHERE `id_pesanan_tiket` = 2;

-- pesanan_toko id 2: rincian itemnya (id_detail_toko 3) sudah dihapus di atas
DELETE FROM `pesanan_toko` WHERE `id_pesanan_toko` = 2;

-- kategori_tiket id 4: tidak punya tiket/keranjang lagi
DELETE FROM `kategori_tiket` WHERE `id_kategori_tiket` = 4;

-- produk_toko id 3: variasinya (id_variasi 8) ikut terhapus otomatis (ON DELETE CASCADE)
DELETE FROM `produk_toko` WHERE `id_produk` = 3;

-- variasi_ukuran_produk id 4: tidak dipakai di keranjang maupun pesanan
DELETE FROM `variasi_ukuran_produk` WHERE `id_variasi` = 4;

-- jadwal_tur id 5: tidak punya kategori tiket
DELETE FROM `jadwal_tur` WHERE `id_tur` = 5;

-- album_musik id 3: tidak punya lagu
DELETE FROM `album_musik` WHERE `id_album` = 3;

-- ---------- B.3 Tabel independen ----------

DELETE FROM `personil_band` WHERE `id_personil` = 4;
DELETE FROM `karir` WHERE `id_karir` = 5;
DELETE FROM `penghargaan` WHERE `id_penghargaan` = 3;
DELETE FROM `faq_tur` WHERE `id_faq` = 4;

-- Tabel profil hanya berisi 1 baris; dihapus sebagai contoh operasi DELETE
DELETE FROM `profil_beranda` WHERE `id_profil` = 1;
DELETE FROM `profil_tentang` WHERE `id_tentang` = 1;
DELETE FROM `profil_musik` WHERE `id_profil_musik` = 1;
DELETE FROM `profil_tur` WHERE `id_profil_tur` = 1;
DELETE FROM `profil_halaman_toko` WHERE `id_profil_toko` = 1;

-- =====================================================================
-- BAGIAN C: Verifikasi hasil (SELECT)
-- =====================================================================

SELECT * FROM `jadwal_tur`;
SELECT * FROM `kategori_tiket`;
SELECT * FROM `produk_toko`;
SELECT * FROM `variasi_ukuran_produk`;
SELECT * FROM `pesanan_tiket`;
SELECT * FROM `pesanan_toko`;
