# Wali Band Admin Dashboard

Panel admin CRUD generik berbasis PHP Native, PDO, MySQL, dan AdminLTE 4.10.0. Modul dibuat mengikuti tabel pada `database.sql`.

## Kebutuhan
- PHP 8.1+ (ekstensi PDO MySQL dan mbstring)
- MySQL/MariaDB
- Apache (XAMPP atau Laragon)

## Instalasi (Laragon)
1. Pindahkan folder `wali` ke `C:\laragon\www\waliband-admin`.
2. Jalankan Apache dan MySQL melalui Laragon.
3. Buka phpMyAdmin, lalu import file `database.sql`. File tersebut membuat database `db_wali_band` sekaligus seluruh tabelnya.
4. Periksa `config.php`. Konfigurasi bawaan cocok untuk Laragon/XAMPP standar: host `127.0.0.1`, user `root`, password kosong.
5. Buka `http://localhost/waliband-admin/`.

## Fitur
- Dashboard hitung jumlah record untuk semua tabel.
- CRUD seluruh tabel yang didefinisikan di SQL.
- Form dibuat otomatis berdasarkan tipe kolom MySQL (text, angka, date, time, datetime, enum, dan tinyint(1)).
- Kolom foreign key menggunakan dropdown dari tabel referensi.
- Pencarian data, konfirmasi hapus, prepared statements, dan token CSRF.
- Jika database menolak penghapusan karena foreign key `RESTRICT`, aplikasi menampilkan pesan bahwa data terkait harus ditangani terlebih dahulu.

## Catatan penting
- Ini adalah panel administrasi dasar untuk kebutuhan tugas/praktikum. Belum dilengkapi login/role admin, upload file gambar, pagination, audit log, maupun integrasi payment gateway.
- Kolom gambar/audio saat ini diisi dengan path/URL file secara manual.
- Tabel keranjang (`keranjang_tiket` dan `keranjang_toko`) tetap disediakan CRUD-nya sesuai permintaan semua tabel, meskipun pada aplikasi produksi biasanya dikelola otomatis oleh sesi pembeli.
- Sebelum dipublikasikan ke internet, wajib tambahkan autentikasi admin, validasi bisnis, pembatasan akses, dan konfigurasi kredensial yang aman.
