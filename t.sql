CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;

CREATE TABLE KHOA (
    MAKHOA INT PRIMARY KEY,
    TENKHOA NVARCHAR(50),
    NGTLAP DATE,
    TRGKHOA INT,
    FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV)
);

CREATE TABLE GIAOVIEN (
    MAGV INT PRIMARY KEY,
    HOTEN NVARCHAR(100),
    HOCVI NVARCHAR(50),
    HOCHAM NVARCHAR(50),
    GIOITINH CHAR(1),
    NGSINH DATE,
    NGVL DATE,
    HESO FLOAT,
    MUCLUONG FLOAT,
    MAKHOA INT,
    FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

CREATE TABLE LOP (
    MALOP NVARCHAR(10) PRIMARY KEY,
    TENLOP NVARCHAR(50),
    TRGLOP INT,
    SISO INT,
    MAGVCN INT,
    FOREIGN KEY (TRGLOP) REFERENCES GIAOVIEN(MAGV),
    FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN(MAGV)
);

CREATE TABLE MONHOC (
    MAMH INT PRIMARY KEY,
    TENMH NVARCHAR(50),
    TCLT INT,
    TCTH INT,
    MAKHOA INT,
    FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
);

CREATE TABLE HOCVIEN (
    MAHV INT PRIMARY KEY,
    HO NVARCHAR(50),
    TEN NVARCHAR(50),
    NGSINH DATE,
    GIOITINH CHAR(1),
    NOISINH NVARCHAR(100),
    MALOP NVARCHAR(10),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);

CREATE TABLE GIANGDAY (
    MALOP NVARCHAR(10),
    MAMH INT,
    MAGV INT,
    HOCKY INT,
    NAM INT,
    TUNGAY DATE,
    DENNGAY DATE,
    PRIMARY KEY (MALOP, MAMH, MAGV, HOCKY, NAM),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
);

CREATE TABLE KETQUATHI (
    MAHV INT,
    MAMH INT,
    LANTHI INT,
    NGTHI DATE,
    DIEM FLOAT,
    KQUA CHAR(1),
    PRIMARY KEY (MAHV, MAMH, LANTHI),
    FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);

CREATE TABLE DIEUKIEN (
    MAMH INT,
    MAMH_TRUOC INT,
    PRIMARY KEY (MAMH, MAMH_TRUOC),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
);

INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA) VALUES
(1, 'Khoa học máy tính', '2005-06-07', 1),
(2, 'Hệ thống thông tin', '2005-07-06', 2),
(3, 'Công nghệ phần mềm', '2005-07-06', 3),
(4, 'Mạng và truyền thông', '2005-10-20', 3),
(5, 'Kỹ thuật máy tính', '2005-12-20', NULL);

INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN) VALUES
('K11', 'Lớp 1 khoa 1', 1, 11, 7),
('K12', 'Lớp 2 khoa 1', 2, 12, 9),
('K13', 'Lớp 3 khoa 1', 3, 12, 14);

INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA) VALUES
(1, 'Tin học đại cương', 3, 1, 1),
(2, 'Cơ sở tri thức', 4, 1, 1),
(3, 'Cơ sở dữ liệu', 4, 1, 2),
(4, 'Cấu trúc dữ liệu và giải thuật', 4, 1, 1),
(5, 'Phân tích thiết kế hệ thống thông tin', 4, 1, 2),
(6, 'Đồ họa máy tính', 3, 1, 3),
(7, 'Kỹ thuật máy tính', 3, 1, 5),
(8, 'Thiết kế cơ sở dữ liệu', 3, 1, 2),
(9, 'Phân tích thiết kế hệ thống thông tin', 4, 1, 2),
(10, 'Lập trình hệ thống điều hành', 4, 1, 4),
(11, 'Mạng cơ bản và mạng phân tán', 3, 1, 4),
(12, 'Lập trình cơ sở và phần mềm', 3, 1, 1);

INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) VALUES
('K11', 1, 7, 1, 2005, '2005-12-10', '2006-05-10'),
('K11', 2, 5, 1, 2005, '2005-12-20', '2006-05-20'),
('K11', 3, 6, 2, 2006, '2006-01-15', '2006-05-15'),
('K12', 1, 6, 1, 2005, '2005-12-10', '2006-05-10'),
('K12', 4, 7, 1, 2005, '2005-12-15', '2006-05-15'),
('K12', 5, 5, 2, 2006, '2006-01-20', '2006-05-20'),
('K13', 1, 7, 1, 2005, '2005-12-25', '2006-05-25'),
('K13', 4, 6, 1, 2005, '2005-12-30', '2006-05-30'),
('K13', 3, 5, 2, 2006, '2006-01-10', '2006-05-10');

INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC) VALUES
('CSDL', 'CTDLGT'),
('CSDL', 'THDC'),
('CTDLGT', 'THDC'),
('PTTKHT', 'THDC'),
('PTTKHT', 'CSDL'),
('DHMT', 'LTHDT'),
('LTHDT', 'THDC'),
('PTTKHTT', 'CSDL');
INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA) VALUES
('GV01', 'Hồ Thanh Sơn', 'PTS', 'GS', 'Nam', '1965-05-25', '2005-11-16', 5.0, 2250000, 1),
('GV02', 'Trần Tấn Thanh', 'TS', 'PGS', 'Nam', '1960-12-17', '2005-05-12', 5.0, 2250000, 2),
('GV03', 'Đỗ Nghiêm Phụng', 'TS', 'GS', 'Nữ', '1961-11-22', '2005-04-16', 4.5, 2025000, 3),
('GV04', 'Trần Nam Sơn', 'PTS', NULL, 'Nam', '1964-09-15', '2005-02-25', 4.0, 1800000, 4),
('GV05', 'Đào Khánh Đan', 'THS', NULL, 'Nam', '1976-01-02', '2005-04-10', 3.5, 1575000, 1),
('GV06', 'Trần Doanh Hưng', 'THS', NULL, 'Nam', '1979-03-23', '2005-02-11', 3.0, 1350000, 2););


CREATE TABLE DIEUKIEN (
    MAMH INT,
    MAMH_TRUOC INT,
    PRIMARY KEY (MAMH, MAMH_TRUOC),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
);


CREATE TABLE LOP (
    MALOP INT PRIMARY KEY,
    TENLOP NVARCHAR(50),
    TRGLOP INT,
    SISO INT,
    MAGVCN INT,
    FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV),
    FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN(MAGV)
);
GO

CREATE TABLE HOCVIEN (
    MAHV INT PRIMARY KEY,
    HO NVARCHAR(50),
    TEN NVARCHAR(50),
    NGSINH DATE,
    GIOITINH CHAR(1),
    NOISINH NVARCHAR(100),
    MALOP INT,
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
);


CREATE TABLE GIANGDAY (
    MALOP INT,
    MAMH INT,
    MAGV INT,
    HOCKY INT,
    NAM INT,
    TUNGAY DATE,
    DENNGAY DATE,
    PRIMARY KEY (MALOP, MAMH, MAGV, HOCKY, NAM),
    FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
    FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
);


CREATE TABLE KETQUATHI (
    MAHV INT,
    MAMH INT,
    LANTHI INT,
    NGTHI DATE,
    DIEM FLOAT,
    KQUA CHAR(1),
    PRIMARY KEY (MAHV, MAMH, LANTHI),
    FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
    FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
);

INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA) VALUES
(1, 'Khoa học máy tính', '2005-06-07', 'GV01'),
(2, 'Hệ thống thông tin', '2005-07-06', 'GV02'),
(3, 'Công nghệ phần mềm', '2005-07-06', 'GV03'),
(4, 'Mạng và truyền thông', '2005-10-20', 'GV03'),
(5, 'Kỹ thuật máy tính', '2005-12-20', NULL);

INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN) VALUES
('K11', 'Lớp 1 khoa 1', 'K1108', 11, 'GV07'),
('K12', 'Lớp 2 khoa 1', 'K1205', 12, 'GV09'),
('K13', 'Lớp 3 khoa 1', 'K1305', 12, 'GV14');

INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC) VALUES
('CSDL', 'CTDLGT'),
('CSDL', 'THDC'),
('CTDLGT', 'THDC'),
('PTTKHT', 'THDC'),
('PTTKHT', 'CSDL'),
('DHMT', 'LTHDT'),
('LTHDT', 'THDC'),
('PTTKHTT', 'CSDL');


INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA) VALUES
('GV01', 'Hồ Thanh Sơn', 'PTS', 'GS', 'Nam', '1965-05-25', '2005-11-16', 5.0, 2250000, 1),
('GV02', 'Trần Tấn Thanh', 'TS', 'PGS', 'Nam', '1960-12-17', '2005-05-12', 5.0, 2250000, 2),
('GV03', 'Đỗ Nghiêm Phụng', 'TS', 'GS', 'Nữ', '1961-11-22', '2005-04-16', 4.5, 2025000, 3),
('GV04', 'Trần Nam Sơn', 'PTS', NULL, 'Nam', '1964-09-15', '2005-02-25', 4.0, 1800000, 4),
('GV05', 'Đào Khánh Đan', 'THS', NULL, 'Nam', '1976-01-02', '2005-04-10', 3.5, 1575000, 1),
('GV06', 'Trần Doanh Hưng', 'THS', NULL, 'Nam', '1979-03-23', '2005-02-11', 3.0, 1350000, 2),
('GV07', 'Nguyễn Minh Tiến', 'KS', NULL, 'Nam', '1976-11-29', '2005-09-19', 4.0, 1800000, 4),
('GV08', 'Lê Thi Lan', 'KS', NULL, 'Nữ', '1981-10-23', '2005-05-02', 3.0, 1350000, 3),
('GV09', 'Nguyễn Tôn Tân', 'TS', NULL, 'Nam', '1974-04-29', '2005-08-18', 4.0, 1800000, 2),
('GV10', 'Lê Trần Anh Lộc', 'THS', NULL, 'Nam', '1981-07-29', '2005-08-19', 3.0, 1350000, 4),
('GV11', 'Tô Thanh Tùng', 'THS', NULL, 'Nam', '1983-12-23', '2005-04-29', 3.0, 1350000, 1),
('GV12', 'Trần Văn Anh', 'CN', NULL, 'Nam', '1985-09-23', '2005-09-15', 2.7, 1215000, 4),
('GV13', 'Nguyễn Linh Đen', 'CN', NULL, 'Nữ', '1987-11-12', '2005-10-15', 2.7, 1215000, 3),
('GV14', 'Trương Minh Châu', 'THS', NULL, 'Nữ', '1975-01-30', '2005-05-15', 3.0, 1350000, 5),
('GV15', 'Lê Hà Thanh', 'THS', NULL, 'Nam', '1978-04-15', '2005-05-15', 3.0, 1350000, 1);


INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA) VALUES
('THDC', 'Tin học đại cương', 3, 1, 1),
('CTRR', 'Cơ sở tri thức', 4, 1, 1),
('CSDL', 'Cơ sở dữ liệu', 4, 1, 2),
('CTDLGT', 'Cấu trúc dữ liệu và giải thuật', 4, 1, 1),
('PTTKHT', 'Phân tích thiết kế hệ thống thông tin', 4, 1, 2),
('DHMT', 'Đồ họa máy tính', 3, 1, 3),
('KTMT', 'Kỹ thuật máy tính', 3, 1, 5),
('TKCSDL', 'Thiết kế cơ sở dữ liệu', 3, 1, 2),
('PTTKHTT', 'Phân tích thiết kế hệ thống thông tin', 4, 1, 2),
('LTHTDD', 'Lập trình hệ thống điều hành', 4, 1, 4),
('MCNMPTUD', 'Mạng cơ bản và mạng phân tán', 3, 1, 4),
('LTCVP', 'Lập trình cơ sở và phần mềm', 3, 1, 1);


INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) VALUES
('K11', 'THDC', 'GV07', 1, 2005, '2005-12-10', '2006-05-10'),
('K11', 'CTRR', 'GV05', 1, 2005, '2005-12-20', '2006-05-20'),
('K11', 'CSDL', 'GV06', 2, 2006, '2006-01-15', '2006-05-15'),
('K12', 'THDC', 'GV06', 1, 2005, '2005-12-10', '2006-05-10'),
('K12', 'CTDLGT', 'GV07', 1, 2005, '2005-12-15', '2006-05-15'),
('K12', 'PTTKHT', 'GV05', 2, 2006, '2006-01-20', '2006-05-20'),
('K13', 'THDC', 'GV07', 1, 2005, '2005-12-25', '2006-05-25'),
('K13', 'CTDLGT', 'GV06', 1, 2005, '2005-12-30', '2006-05-30'),
('K13', 'CSDL', 'GV05', 2, 2006, '2006-01-10', '2006-05-10');
GO
