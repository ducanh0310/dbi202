drop database GROUP2
CREATE DATABASE GROUP2

use GROUP2

CREATE TABLE MIEN(
MIENID INT PRIMARY KEY,
TENMIEN NVARCHAR(50)
)

CREATE TABLE THANHPHO(
THANHPHOID INT PRIMARY KEY,
TENTHANHPHO NVARCHAR(50),
MIENID INT FOREIGN KEY REFERENCES MIEN(MIENID)
)

CREATE TABLE THANHVIEN(
THANHVIENID INT,
TENTHANHVIEN NVARCHAR(50) primary key ,
EMAIL NVARCHAR(50),
KIEUTHANHVIEN NVARCHAR(50) ,
SOLUONGTIN INT default 0
)

CREATE TABLE TINTUC(
MATIN INT PRIMARY KEY,
TIEUDE NVARCHAR(100),
NGAYDANG DATETIME,
LUOTXEM INT default 0,
TENTHANHVIEN NVARCHAR(50) FOREIGN KEY REFERENCES THANHVIEN(TENTHANHVIEN) default 'Khach vang lai',
SODIENTHOAI NVARCHAR(10)
)

CREATE TABLE CHUYENMUC(
MATIN INT FOREIGN KEY REFERENCES TINTUC(MATIN),
CHUYEMUC NVARCHAR(50)
)

CREATE TABLE CHITIET(
MATIN INT FOREIGN KEY REFERENCES TINTUC(MATIN),
CHITIETID INT PRIMARY KEY 
)

CREATE TABLE PHUONGTIEN(
CHITIETID INT FOREIGN KEY REFERENCES CHITIET(CHITIETID),
HANGXE NVARCHAR(50),
CHATLUONG NVARCHAR(50),
NGAYSANXUAT DATETIME,
GIA INT 
)


CREATE TABLE DICHVUDAT(
CHITIETID INT FOREIGN KEY REFERENCES CHITIET(CHITIETID),
GIA BIGINT,
DIENTICH FLOAT,
DIACHI NVARCHAR(100),
MUCDICH NVARCHAR(100),
HUONG NVARCHAR(50),
GIAYTOPHAPLY BIT,
MATTIEN INT
)
                                                                         
                                              
CREATE TABLE QUANLY(
QUANLYID INT PRIMARY KEY,
TENQUANLY NVARCHAR(40),
DIACHI NVARCHAR(50),
SODIENTHOAI NVARCHAR(10),
EMAIL NVARCHAR(50)
)

CREATE TABLE PHANCONG(
MATIN INT FOREIGN KEY REFERENCES TINTUC(MATIN),
QUANLYID INT FOREIGN KEY REFERENCES QUANLY(QUANLYID)
)


CREATE TABLE COSO(
MATIN int FOREIGN KEY REFERENCES TINTUC(MATIN),
THANHPHOID int FOREIGN KEY REFERENCES THANHPHO(THANHPHOID)
)

go
create procedure xem_tin_tuc 
@ma_tin int out
as
begin 
	select * from TINTUC 
	where @ma_tin = TINTUC.MATIN 
	update TINTUC 
	set LUOTXEM = LUOTXEM + 1
	where @ma_tin = TINTUC.MATIN 
end
--drop procedure xem_tin_tuc

go
create trigger dem_so_luong_tin
on TINTUC 
after insert 
as 
begin 
	update THANHVIEN 
	set SOLUONGTIN = a.SOLUONG from (select COUNT(TINTUC.TENTHANHVIEN) as SOLUONG,TINTUC.TENTHANHVIEN from TINTUC
						group by TINTUC.TENTHANHVIEN) a
	where THANHVIEN.TENTHANHVIEN=a.TENTHANHVIEN
	
end
--drop trigger dem_so_luong_tin

go
-- add miền 
insert into MIEN(MIENID,TENMIEN) 
values (1,'Mien Bac')
insert into MIEN(MIENID,TENMIEN) 
values (2,'Mien Trung')
insert into MIEN(MIENID,TENMIEN) 
values (3,'Mien Nam')

-- add cac tinh thanh 
insert into THANHPHO(MIENID,THANHPHOID,TENTHANHPHO)
values (1,1,'Ha Noi'), 
(1,2,'Hai Phong'), 
(1,3,'Hai Duong'),
(1,4,'Quang Ninh'), 
(1,5,'Bac Ninh'), 
(1,6,'Thanh Hoa'),
(1,7,'Cac tinh mien bac Khac'),
(2,8,'Da Nang'), 
(2,9,'Khanh Hoa'), 
(2,10,'Quang Nam'), 
(2,11,'Thua Thien Hue'),
(2,12,'Cac tinh mien trung khac'), 
(3,13,'TP HCM'),
(3,14,'Binh Duong'),
(3,15,'Can Tho'),
(3,16,'Ba Ria-Vung Tau'),
(3,17,'Dong Nai'),
(3,18,'Long An'),
(3,19,'Cac tinh mien Nam khac')

insert into THANHVIEN(THANHVIENID,TENTHANHVIEN,EMAIL,KIEUTHANHVIEN)
values (128,'huyhoangstore2000@gmail.com','huyhoangstore2000@gmail.com','Thanh Vien Thuong'),
(23,'Quynh212','quyanh12@gmail.com','Thanh Vien Thuong'),
(15,'GiayDep','tuancs21@gmail.com','Thanh Vien Thuong'),
(1,'Tuan Anh','tanh12@gmail.com','Thanh Vien Thuong'),
(142,'LannAnhStore','lananhstore@gmailcom','Thanh Vien Thuong'),
(421,'Do Go Nghe Thuat','anhdw2122@gmail.com','Thanh Vien Thuong'),
(552,'Lam Vuon 123','huy2112@gmail.com','Thanh Vien Thuong'),
(333,'DoChoBe','dangdr22@gmail.com','Thanh Vien Thuong'),
(117,'nguyentuan@gmail.com','nguyentuan@gmail.com','Thanh Vien Thuong'),
(394,'dienmaynha123@gmailcom','dienmaynha123@gmailcom','Thanh Vien Thuong'),
(63,'doanh2322@gmail.com','doanh2322@gmail.com','Thanh Vien Thuong'),
(443,'Duc Tien Iphone','tienduc1222@gmail.com','Thanh Vien Thuong'),
(641,'hoangduc','hoangduc22@gmail.com','Thanh Vien Thuong'),
(120,'congtidondep20','dadanh222@gmail.com','Thanh Vien Thuong'),
(311,'Hoang Anh','anhhh21@gmail.com','Thanh Vien Thuong'),
(611,'Hoang Huy','huyyh121@gmail.com','Thanh Vien Thuong')

insert into TINTUC(MATIN,TIEUDE,NGAYDANG,TENTHANHVIEN,SODIENTHOAI)
values (55544525,'Banh bong lan trung muoi sieu ngon','6/15/2022','Quynh212','0472838221'),-- di choi thoi covid
(85447475,'Khau trang 3 lop dam bao chat luong kiemdinh y te','8/4/2021','LannAnhStore','0685985479'),
(74541114,'Can ban oto mazda moi di duoc 2000km','12/8/2021','hoangduc','0966362555'),--oto
(33252151,'Oto cu KIA can ban gap,gia ca thuong luong','6/25/2021','Hoang Anh','0365888525'),
(85658555,'Oto suzuki doi 2020 da su dung','12/5/2021','Hoang Huy','0365452525'),
(34332134,'Ban xe Lead be dk 2011 vo dang su dung','3/12/2021','huyhoangstore2000@gmail.com','0965477477'),--xe may
(88832312,'Can ban xe SH MODE doi 2018 da su dung','5/12/2021',null,'0984324222'),
(28108850,'Ao thun dong phuc, ao thun dep ','4/20/2022','Quynh212','0472838221'),--thoi trang
(27318323,'Giay adidas chat luong cao, gia re, ','11/9/2021','GiayDep','0865232512'),
(83274123,'Ao gio da nang, chong tham nuoc, chong tia UV','2/2/2022','Tuan Anh','0953254847'),
(20568461,'Ao phong nam dep, phu hop nguoi co can nang tu 40-80kg','5/12/2021',null,'0858569223'),
(52421038,'Quan the thao thich hop di chay bo thoi trang phong cac','12/11/2021','Tuan Anh','0953254847'),
(57477457,'Vay da hoi danh cho nu HaNoi','6/2/2022','LannAnhStore','0685985479'),
(84652588,'Bo ban ghe go noi that danh cho gia dinh','6/12/2021','Do Go Nghe Thuat','0958623511'),--nha va vuon
(53655586,'Tham co thich hop de trang tri san vuon','4/12/2021','Lam Vuon 123','0998636333'),
(55232021,'Ghe xich du danh cho tre nho','2/12/2021','DoChoBe','0955553682'),
(56955336,'Bo do nghe lam vuon','8/21/2021','Lam Vuon 123','0998636333'),
(35628465,'Loa nhap khau chau au','3/12/2022','nguyentuan@gmail.com','0989852031'),--thiet bi dien tu
(41542586,'Dieu hoa sony ho tro lap dat mien phi','1/12/2022','dienmaynha123@gmailcom','0386525222'),
(66963658,'Dieu hoa hai chieu bao hanh 48 thang','5/12/2021','dienmaynha123@gmailcom','0386525222'),
(85554655,'May giat co chan ke, ho tro lap dat bao hanh 12 thang','4/16/2021','doanh2322@gmail.com','099652352'),
(63233302,'Dien thoai iphone 12 pro max bao hanh 12 thang','5/1/2022','huyhoangstore2000@gmail.com','0965477477'),-- dien thoai sim 
(69365444,'Samsung s9 cu bao hanh 6 thang, freeship','8/12/2021','Duc Tien Iphone','0923666522'),
(48444585,'Dien Thoai Iphone X,XS,XR 99% bao hanh 12 thang','6/21/2022','Duc Tien Iphone','0923666522'),
(78544585,'May Tinh bang gia re tai Ha Noi','8/5/2021',null,'099963255'),
(85552366,'Sua tivi,may tinh tai Ha Noi','12/5/2021','hoangduc','0966362555'),--dich vu viec lam
(66366220,'Don dep nha cua, dam bao uy tin, nhanh , sach','9/12/2021','congtidondep20','0996365554'),
(69985655,'Sua chua xe may,oto goi la den ','8/22/2020',null,'0996558888'),
(65478877,'Can tuyen editor kinh nghiem 1 nam, luong thoa thuan','12/8/2020',null,'0936555811'),
(84554888,'Can ban dat vi tri dep','3/5/2021','congtidondep20','0996365554'),
(22253685,'Rao ban dat tai Ho Tay gia re, ca ban gap','4/2/2021','doanh2322@gmail.com','099652352')

insert into QUANLY(QUANLYID,TENQUANLY,SODIENTHOAI,DIACHI,EMAIL)
values (0001,'Nguyen Van Huy','0936656210','Ha Noi','nghuy1032@gmail.com'),
(0022,'Ngo Anh Tuan','0936665288','TPHCM','anhtuan212@gmail.com'),
(0027,'Dang Thuy Tien','0965544111','Ha Noi','thuytien2@gmail.com'),
(0005,'Hoang Tuan Son','0998555222','Da Nang','sonth21@gmail.com')

insert into CHUYENMUC(MATIN,CHUYEMUC)
values (28108850,'Thoi trang'),
(27318323,'Thoi trang'),
(83274123,'Thoi trang'),
(20568461,'Thoi trang'),
(52421038,'Thoi trang'),
(57477457,'Thoi trang'),
(84652588,'Thoi trang'),--nha va vuon
(53655586,'Thoi trang'),
(55232021,'Thoi trang'),
(56955336,'Thoi trang'),
(35628465,'Thiet bị dien tu'),--thiet bi dien tu
(41542586,'Thiet bị dien tu'),
(66963658,'Thiet bị dien tu'),
(85554655,'Thiet bị dien tu'),
(63233302,'Dien thoai va Sim'),-- dien thoai sim 
(69365444,'Dien thoai va Sim'),
(48444585,'Dien thoai va Sim'),
(78544585,'Dien thoai va Sim'),
(85552366,'Dich vu, Viec lam'),--dich vu viec lam
(66366220,'Dich vu, Viec lam'),
(69985655,'Dich vu, Viec lam'),
(65478877,'Dich vu, Viec lam'),
(55544525,'Di choi thoi covid'),-- di choi thoi covid
(85447475,'Di choi thoi covid'),
(74541114,'Oto, xe may'),--oto
(33252151,'Oto, xe may'),
(85658555,'Oto, xe may'),
(34332134,'Oto, xe may'),--xe may
(88832312,'Oto, xe may'),
(84554888,'Mua ban dat'),--dat dai
(22253685,'Mua ban dat')

insert into CHITIET(MATIN,CHITIETID)
values (74541114,1230),--oto
(33252151,1231),
(85658555,1232),
(34332134,1220),--xe may
(88832312,1221),
(84554888,1110),--dat dai
(22253685,1111)

insert into DICHVUDAT(CHITIETID,GIA,DIENTICH,DIACHI,MUCDICH,HUONG,GIAYTOPHAPLY,MATTIEN)
values (1110,2300000000,'86.5','Long Bien-Ha Noi','Ban','Dong Nam',1,4),--dat dai
(1111,4100000000,102.3,'Ho Tay-Ha Noi','Ban','Bac',1,6)

insert into PHUONGTIEN(CHITIETID ,HANGXE,CHATLUONG,NGAYSANXUAT,GIA)
values (1230,'Mazda','Cu','2018',2000000000),--oto
(1231,'KIA','Cu','2020',800000000),
(1232,'Suzuki','Cu','2016',500000000),
(1220,'Lead','Cu','2011',40000000),--xe may
(1221,'Sh Mode','Cu','2018',46000000)

insert into PHANCONG(MATIN,QUANLYID)
values (28108850,0001),
(27318323,0001),
(83274123,0001),
(20568461,0001),
(52421038,0001),
(57477457,0001),
(84652588,0022),--nha va vuon
(53655586,0022),
(55232021,0022),
(56955336,0022),
(35628465,0027),--thiet bi dien tu
(41542586,0027),
(66963658,0027),
(85554655,0027),
(63233302,0005),-- dien thoai sim 
(69365444,0005),
(48444585,0005),
(78544585,0005),
(85552366,0005),--dich vu viec lam
(66366220,0005),
(69985655,0005),
(65478877,0005),
(55544525,0001),-- di choi thoi covid
(85447475,0001),
(74541114,0022),--oto
(33252151,0022),
(85658555,0022),
(34332134,0022),--xe may
(88832312,0022),
(84554888,0022),--dat dai
(22253685,0022)

insert into COSO(MATIN,THANHPHOID)
values (28108850,1),
(27318323,1),
(83274123,1),
(20568461,4),
(52421038,8),
(57477457,12),
(84652588,13),--nha va vuon
(53655586,1),
(55232021,13),
(56955336,8),
(35628465,2),--thiet bi dien tu
(41542586,2),
(66963658,1),
(85554655,1),
(63233302,13),-- dien thoai sim 
(69365444,9),
(48444585,10),
(78544585,13),
(85552366,5),--dich vu viec lam
(66366220,1),
(69985655,13),
(65478877,13),
(55544525,1),-- di choi thoi covid
(85447475,13),
(74541114,2),--oto
(33252151,1),
(85658555,1),
(34332134,13),--xe may
(88832312,1),
(84554888,1),--dat dai
(22253685,1)

--exec xem_tin_tuc [MATIN]

select * from DICHVUDAT