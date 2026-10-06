CREATE DATABASE Library;
USE Library;


CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15)
);


CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    quantity INT DEFAULT 1
);


CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Issued', 'Returned') DEFAULT 'Issued',

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO users (name, email, phone)
VALUES
('Madhumitha', 'madhu@gmail.com', '9876543210'),
('Mayoori', 'mayoori@gmail.com', '9876543211');

INSERT INTO books (title, author, category, quantity)
VALUES
('Java Programming', 'Herbert', 'Programming', 5),
('Database Management Systems', 'Raghu', 'Database', 3),
('Artificial Intelligence', ' Russell', 'AI', 4);

INSERT INTO transactions
(user_id, book_id, issue_date, status)
VALUES
(1, 1, CURDATE(), 'Issued');

UPDATE books
SET quantity = quantity - 1
WHERE book_id = 1 AND quantity > 0;

UPDATE transactions
SET return_date = CURDATE(),
    status = 'Returned'
WHERE transaction_id = 1;

UPDATE books
SET quantity = quantity + 1
WHERE book_id = 1;

SELECT
    t.transaction_id,
    u.name AS user_name,
    b.title AS book_title,
    t.issue_date
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN books b ON t.book_id = b.book_id
WHERE t.status = 'Issued';

SELECT
    t.transaction_id,
    u.name AS user_name,
    b.title AS book_title,
    t.issue_date,
    t.return_date,
    t.status
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN books b ON t.book_id = b.book_id
ORDER BY t.issue_date DESC;

SELECT
    u.name,
    b.title,
    t.issue_date,
    t.return_date,
    t.status
FROM transactions t
JOIN users u ON t.user_id = u.user_id
JOIN books b ON t.book_id = b.book_id
WHERE u.user_id = 1;

SELECT *
FROM books
WHERE quantity > 0;