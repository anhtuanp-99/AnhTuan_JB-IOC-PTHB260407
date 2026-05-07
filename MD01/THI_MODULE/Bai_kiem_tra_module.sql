CREATE TABLE Passengers(
	passenger_id VARCHAR(5) PRIMARY KEY,
	passenger_full_name VARCHAR(100),
	passenger_email VARCHAR(100),
	passenger_phone VARCHAR(15),
	passenger_cccd VARCHAR(20)
);

CREATE TABLE Trains(
	train_id VARCHAR(5) PRIMARY KEY,
	train_name VARCHAR(100),
	train_type VARCHAR(10),
	total_seats INT
);

CREATE TABLE Tickets(
	ticket_id VARCHAR(5) PRIMARY KEY,
	passenger_id VARCHAR(100) REFERENCES Passengers(passenger_id),
	train_id VARCHAR(10) REFERENCES Trains(train_id),
	departure_date DATE,
	seat_number VARCHAR(10),
	ticket_price DECIMAL(10,2)
);

CREATE TABLE Transactions(
	transaction_id VARCHAR(5) PRIMARY KEY,
	ticket_id VARCHAR(5) REFERENCES Tickets(ticket_id),
	payment_method VARCHAR(50),
	transaction_date DATE,
	amount DECIMAL(10,2)
);

SELECT * FROM Passengers;
SELECT * FROM Trains;
SELECT * FROM Tickets;
SELECT * FROM Transactions;

INSERT INTO Passengers(passenger_id, passenger_full_name, passenger_email, passenger_phone, passenger_cccd) VALUES
('P001', 'Nguyen Van An', 'an.nguyen@example.com', '0912345678', '001234567890'),
('P002', 'Tran Thi Binh', 'binh.tran@example.com', '0923456789', '002345678901'),
('P003', 'Le Minh Chau', 'chau.le@example.com', '0934567890', '003456789012'),
('P004', 'Pham Quoc Dat', 'dat.pham@example.com', '0945678901', '004567890123'),
('P005', 'Vo Thanh Em', 'em.vo@example.com', '0956789012', '005678901234');

INSERT INTO Trains(train_id, train_name, train_type, total_seats) VALUES
('T001', 'Tau Thong Nhat 1', 'SE', 500),
('T002', 'Tau Thong Nhat 2', 'TN', 450),
('T003', 'Tau Sai Gon - Hue', 'SE', 400),
('T004', 'Tau Ha Noi - Lao Cai', 'TN', 350),
('T005', 'Tau Da Nang Express', 'SE', 300);

INSERT INTO Tickets(ticket_id, passenger_id, train_id, departure_date, seat_number, ticket_price) VALUES
('TK001', 'P001', 'T001', '2025-06-10', 'A01', 850000),
('TK002', 'P002', 'T002', '2025-06-11', 'B05', 650000),
('TK003', 'P003', 'T003', '2025-06-12', 'C10', 720000),
('TK004', 'P004', 'T004', '2025-06-13', 'D12', 500000),
('TK005', 'P005', 'T005', '2025-06-14', 'E08', 900000);

INSERT INTO Transactions(transaction_id, ticket_id, payment_method, transaction_date, amount) VALUES
('TR001', 'TK001', 'Credit Card', 	'2025-06-01', 850000),
('TR002', 'TK002', 'Cash', 			'2025-06-02', 650000),
('TR003', 'TK003', 'Bank Transfer',  '2025-06-03', 720000),
('TR004', 'TK004', 'E-Wallet',       '2025-06-04', 500000),
('TR005', 'TK005', 'Credit Card',    '2025-06-05', 900000);

DROP TABLE Passengers CASCADE;
DROP TABLE Trains CASCADE;
DROP TABLE Tickets CASCADE;
DROP TABLE Transactions CASCADE;


-- 3. Cập nhật dữ liệu (6 điểm) Viết câu lệnh UPDATE giảm giá vé 15% (price = price * 0.85) cho các vé tàu có ngày khởi hành trước ngày 2025-05-01.
UPDATE Tickets
SET ticket_price = ticket_price * 0.85
WHERE departure_date < '2025-05-01';

-- 4. Xóa dữ liệu (6 điểm) Viết câu lệnh DELETE xóa các giao dịch có phương thức là "E-Wallet" và số tiền nhỏ hơn 200.000 VNĐ.
DELETE FROM Transactions
WHERE payment_method = 'E-Wallet' AND amount < 200000;

SELECT * FROM Passengers;
SELECT * FROM Trains;
SELECT * FROM Tickets;
SELECT * FROM Transactions;

-- PHẦN 2
-- 5. (3 điểm) Lấy thông tin hành khách gồm: mã HK, họ tên, email, SĐT sắp xếp theo họ tên giảm dần.
SELECT passenger_id, passenger_full_name, passenger_email, passenger_phone
FROM Passengers
ORDER BY passenger_full_name DESC;

-- 6. (3 điểm) Lấy danh sách đoàn tàu gồm: mã tàu, tên tàu, tổng số ghế, sắp xếp theo số ghế tăng dần.
SELECT train_id, train_name, total_seats
FROM Trains
ORDER BY total_seats ASC;

-- 7. (3 điểm) Lấy thông tin vé đã đặt gồm: Họ tên hành khách, Tên tàu, Ngày khởi hành, Số ghế.
SELECT passenger_id, train_id, departure_date, seat_number
FROM Tickets;

-- 8. (3 điểm) Lấy danh sách hành khách và tổng tiền đã thanh toán: mã HK, họ tên, phương thức thanh toán, số tiền thanh toán, sắp xếp theo số tiền tăng dần.
SELECT p.passenger_id, p.passenger_full_name, tr.payment_method, tr.amount
FROM Passengers p
JOIN Tickets t ON t.passenger_id = p.passenger_id
JOIN Transactions tr ON tr.ticket_id = tr.ticket_id
ORDER BY tr.amount ASC;

-- 9. (3 điểm) Lấy thông tin hành khách từ vị trí thứ 3 đến thứ 5 trong bảng Passengers sắp xếp theo tên (Z-A).
SELECT *
FROM Passengers
ORDER BY passenger_full_name DESC
LIMIT 3 OFFSET 2;

-- 10. (5 điểm) Liệt kê các hành khách đã đặt ít nhất 3 vé tàu.
SELECT p.passenger_id, p.passenger_full_name, COUNT(tr.ticket_id)
FROM Tickets t
JOIN Passengers p ON p.passenger_id = t.passenger_id
JOIN Transactions tr ON tr.ticket_id = t.ticket_id
GROUP BY p.passenger_id, p.passenger_full_name
HAVING (COUNT(tr.ticket_id) >= 3);

-- 11. (5 điểm) Liệt kê các đoàn tàu đã có hơn 10 lượt khách đặt vé.
SELECT tra.train_id, tra.train_name, COUNT(tr.ticket_id)
FROM Tickets t
JOIN Passengers p ON p.passenger_id = t.passenger_id
JOIN Transactions tr ON tr.ticket_id = t.ticket_id
GROUP BY tra.train_id, tra.train_id
HAVING (COUNT(tr.ticket_id) >= 10);

-- 12. (5 điểm) Lấy danh sách hành khách có tổng tiền giao dịch > 2.000.000 VNĐ, gồm: mã HK, họ tên, mã tàu, tổng tiền.
SELECT p.passenger_id, p.passenger_full_name, train_id, SUM(tr.amount)
FROM Passengers p
JOIN Tickets t ON t.passenger_id = p.passenger_id
JOIN Transactions tr ON tr.ticket_id = t.ticket_id
GROUP BY p.passenger_id, p.passenger_full_name, t.train_id
HAVING (SUM(tr.amount) > 2000000);


-- 13. (6 điểm) Lấy danh sách hành khách có tên chứa chữ "Hoàng" hoặc địa chỉ email thuộc miền "@gmail.com". Sắp xếp theo tên tăng dần.
SELECT passenger_id, passenger_full_name, passenger_email
FROM Passengers
WHERE passenger_full_name ILIKE '%Hoàng%' OR passenger_email ILIKE '%@gmail.com'
ORDER BY passenger_full_name ASC;

-- 14. (4 điểm)  Lấy danh sách đoàn tàu (trang thứ 2, mỗi trang 5 bản ghi) sắp xếp theo số ghế giảm dần.
SELECT train_id, train_name, total_seats
FROM Trains
ORDER BY total_seats DESC
LIMIT 5 OFFSET 5;


-- PHẦN 3
-- 15. (5 điểm) Tạo view vw_UpcomingTrips hiển thị thông tin tàu và hành khách đã đặt vé với ngày khởi hành sau ngày 2025-06-01, gồm: Họ tên, Tên tàu, Số ghế, Giá vé, Ngày khởi hành.
CREATE OR REPLACE VIEW vw_UpcomingTrips AS
SELECT p.passenger_full_name, tr.train_name, tr.total_seats, t.ticket_price, t.departure_date
FROM Tickets t
JOIN Passengers p ON p.passenger_id = t.passenger_id
JOIN Trains tr ON tr.train_id = t.train_id
WHERE departure_date > '2025-06-01';

SELECT * FROM vw_HighValueTickets;

-- 16. (5 điểm) Tạo view vw_HighValueTickets hiển thị khách hàng đặt vé có giá trị trên 500.000 VNĐ, gồm: Họ tên, Tên tàu, Số ghế, Giá vé.
CREATE OR REPLACE VIEW vw_HighValueTickets AS
SELECT p.passenger_full_name, tr.train_name, tr.total_seats, t.ticket_price
FROM Tickets t
JOIN Passengers p ON p.passenger_id = t.passenger_id
JOIN Trains tr ON tr.train_id = t.train_id
WHERE t.ticket_price > 500000;



-- PHẦN 4
-- 17. (5 điểm) Tạo trigger tg_check_ticket_date kiểm tra khi chèn vào bảng Tickets. Nếu ngày khởi hành nhỏ hơn ngày hiện tại thì báo lỗi "Ngày khởi hành không hợp lệ" và hủy thao tác.
CREATE OR REPLACE FUNCTION check_ticket_date()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
	v_current_date DATE := now();
BEGIN
	IF NEW.departure_date < v_current_date THEN
		RAISE EXCEPTION 'Ngày khởi hành không hợp lệ';
	END IF;
END;
$$;

CREATE TRIGGER tg_check_ticket_date
BEFORE INSERT ON Tickets
FOR EACH ROW
EXECUTE FUNCTION check_ticket_date();

-- 18. (5 điểm) Tạo trigger tg_update_seats tự động giảm total_seats của bảng Trains đi 1 khi có một bản ghi mới được thêm vào bảng Tickets.
CREATE OR REPLACE FUNCTION update_seats()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
BEGIN
	UPDATE Trains
	SET total_seats = total_seats - 1
	WHERE train_id = NEW.train_id; 
END;
$$;

CREATE TRIGGER tg_update_seats
AFTER INSERT ON Tickets
FOR EACH ROW
EXECUTE FUNCTION update_seats();

SELECT * FROM Passengers;
SELECT * FROM Trains;
SELECT * FROM Tickets;
SELECT * FROM Transactions;



--PHẦN 5
-- 19. (5 điểm) Viết Procedure sp_add_passenger để thêm mới một hành khách.
CREATE OR REPLACE PROCEDURE sp_add_passenger(
	IN p_passenger_id VARCHAR(5), 
	IN p_passenger_full_name VARCHAR(100), 
	IN p_passenger_email VARCHAR(100), 
	IN p_passenger_phone VARCHAR(15),
	IN p_passenger_cccd VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN

	INSERT INTO Passengers(passenger_id, passenger_full_name, passenger_email, passenger_phone, passenger_cccd) VALUES
	(p_passenger_id, p_passenger_full_name, p_passenger_email, p_passenger_phone, p_passenger_cccd);

EXCEPTION
	WHEN OTHERS THEN
		RAISE LOG 'Thao tác bị lỗi!';
	RAISE;
END;
$$;


SELECT * FROM Tickets;
-- 20. (5 điểm) Viết Procedure sp_cancel_ticket nhận vào p_ticket_id, thực hiện xóa vé trong bảng Tickets và các giao dịch liên quan trong bảng Transactions.
CREATE OR REPLACE PROCEDURE sp_cancel_ticket(
	IN p_ticket_id VARCHAR(5)
)
LANGUAGE plpgsql
AS $$
BEGIN

	IF p_ticket_id IS NULL THEN
		RAISE EXCEPTION 'Mã ticket_id không hợp lệ';
	END IF;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Mã ticket_id không tồn tại';
	END IF;
	
	DELETE FROM Transactions CASCADE
	WHERE ticket_id = p_ticket_id;

	DELETE FROM Tickets
	WHERE ticket_id = p_ticket_id;
	

	
EXCEPTION
	WHEN OTHERS THEN
		RAISE LOG 'Thao tác bị lỗi!';
	RAISE;
END;
$$;


CALL sp_cancel_ticket('TK004');