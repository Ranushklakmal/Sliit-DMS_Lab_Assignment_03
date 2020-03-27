-- Question 1 --
-- IT 16151420 - M.A.R.L Sanklapa -- 
-- LabSheet 03 --
-- DMS --



-- 1st create Customer table--

CREATE TABLE Customer(

custId CHAR(4) PRIMARY KEY, 
custName VARCHAR(20), 
address_ VARCHAR(30), 
phone CHAR(10), 
loyalityPoints INTEGER

);

-- Create Staff Table --

CREATE TABLE Staff(

staffId CHAR(4) PRIMARY KEY, 
staffName VARCHAR(20), 
phone CHAR(10)

);

--create Supplier table --

CREATE TABLE Supplier (

supId INTEGER PRIMARY KEY, 
contactName1 VARCHAR(20), --in the table repeated 'contactName' so suggested 'contactName1' and 'contactName2'-- 
contactName2 VARCHAR(20),
phone CHAR(10), 
address_ VARCHAR(30)

);

-- Now we can create create Product table --

CREATE TABLE Product (

prodId CHAR(5) PRIMARY KEY, 
prodName VARCHAR(20), 
qty INTEGER CHECK (qty > 0), -- quantity of a product is always greater than 0 --
unitPrice INTEGER, 
ROL INTEGER, 
supplier INTEGER FOREIGN KEY REFERENCES Supplier,

);

-- Finally create Sales table --

CREATE TABLE Sales (

pid CHAR(5) FOREIGN KEY REFERENCES Product,  -- add foreign key constrain --
cid CHAR(4) FOREIGN KEY REFERENCES Customer, 
sid_ CHAR(4) FOREIGN KEY REFERENCES Staff,	 -- use '_' this special character,because of sid genarated error --
salesDate date default getdate(), -- default date for a sale is the system date --
PRIMARY KEY(pid,cid,sid_,salesDate), -- add primary key --
 
);

-- inserting values to Customer Table--

INSERT INTO Customer VALUES ('C100' , 'Ravi Perera' , 'Colombo ' , '0112123456' , 1200 );
INSERT INTO Customer VALUES ('C101' , 'Nimali Alwis' , 'Gampaha ' , '0332212345' , 275 );

SELECT * FROM Customer;


-- inserting values to Staff Table --

INSERT INTO Staff VALUES ('S001', 'Kamal Silva' , '0718123456');
INSERT INTO Staff VALUES ('S002', 'Amila Namal' , '0714222222');

Select * From Staff;

-- Inserting values to Supplier Table --

INSERT INTO Supplier VALUES (1 , 'Ceylon Biscuits' , 'Amal Ranjith' , 'Ratmalana' , '0112111111');
INSERT INTO Supplier VALUES (2 , 'Unilvers' , 'Nadeeka Perera' , 'Borella' , '0114555666');

Select * From Supplier;


-- Inserting values to Product Table -- 

INSERT INTO Product VALUES ('P0001' , 'Lemon Puff' , 22 , 85 , 20 , 1);
INSERT INTO Product VALUES ('P0201' , 'Knor Soup' , 8 , 100 , 10 , 2);
INSERT INTO Product VALUES ('P0084' , 'Lipton Ceylonta' , 12 , 125 , 15 , 2);
INSERT INTO Product VALUES ('P0222' , 'chocolate fingers' , 14 , 50 , 8 , 1);

SELECT * FROM Product;


-- Inserting values to Sales Table --

INSERT INTO Sales VALUES ('P0201' , 'C100' , 'S001' , GETDATE() );
INSERT INTO Sales VALUES ('P0222' , 'C101' , 'S002' , GETDATE() );
INSERT INTO Sales VALUES ('P0084' , 'C100' , 'S001' , GETDATE() );
INSERT INTO Sales VALUES ('P0201' , 'C100' , 'S002' , GETDATE() );



Select * From Customer;
Select * From Staff;
Select * From Supplier;
SELECT * FROM Product;
SELECT * FROM Sales;



