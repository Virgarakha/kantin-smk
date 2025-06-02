-- Tabel categories
CREATE TABLE categories (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Tabel users
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    role ENUM('penjual', 'pembeli')
);

-- Tabel toko
CREATE TABLE toko (
    id INT PRIMARY KEY,
    nama_toko VARCHAR(255),
    deskripsi_toko TEXT,
    status_oprasional ENUM('buka', 'tutup')
);

-- Tabel product
CREATE TABLE product (
    id INT PRIMARY KEY,
    nama VARCHAR(255),
    deskripsi TEXT,
    gambar VARCHAR(255),
    stock INT,
    harga DECIMAL(10, 2),
    status ENUM('tersedia', 'habis'),
    category_id INT,
    toko_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (toko_id) REFERENCES toko(id)
);

-- Tabel rating
CREATE TABLE rating (
    id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    rating INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- Tabel orders
CREATE TABLE orders (
    id INT PRIMARY KEY,
    user_id INT,
    date_pesanan DATE,
    max_harga DECIMAL(10, 2),
    pajak_1p DECIMAL(10, 2),
    harga DECIMAL(10, 2),
    status ENUM('pending', 'proses', 'selesai'),
    kelas VARCHAR(255),
    jurusan VARCHAR(255),
    product_id INT,
    jumlah_pesanan INT,
    metode_pembayaran ENUM('cod', 'qris'),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);
