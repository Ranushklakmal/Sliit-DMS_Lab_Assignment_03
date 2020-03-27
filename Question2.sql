CREATE TABLE Bank(

code INTEGER PRIMARY KEY,
name_ VARCHAR(20),
registration CHAR(5)

);

INSERT INTO Bank VALUES(1 , 'Com Bank' , 'Reg12');
INSERT INTO Bank VALUES(2 , 'Sampath Bank' , 'Reg23');
INSERT INTO Bank VALUES(3 , 'NTB Bank' , 'Reg45');
INSERT INTO Bank VALUES(4 , 'NSB Bank' , 'Reg67');

select * from Bank

CREATE TABLE Branch(

code INTEGER FOREIGN KEY REFERENCES Bank,
branchNo INTEGER,
name_ VARCHAR(20),
address_ VARCHAR(30),
PRIMARY KEY(code , branchNo)

);

INSERT INTO Branch VALUES(1 , 111 , 'Laugfs Super Branch', 'No 432,Colombo Road');
INSERT INTO Branch VALUES(1 , 112 , 'Keyzer Street Branch', 'No 32 Keyzer StColombo');
INSERT INTO Branch VALUES(1 , 113 , 'Bambalapitiya Branch', '232 Galle Rd, Colombo');

INSERT INTO Branch VALUES(2 , 222 , 'Malabe Branch', 'Udawaththa Road, Malabe');
INSERT INTO Branch VALUES(2 , 223 , 'Maradana Branch', '653 AC19, Colombo 01000');

INSERT INTO Branch VALUES(3 , 333 , 'Kaduwela Branch', 'No 32, Kandy Road, Kaduwela');
INSERT INTO Branch VALUES(3 , 334 , 'Maharagama Branch', 'No 50, New Road, Maharagama');

INSERT INTO Branch VALUES(4 , 444 ,'Colombo Branch' , 'No 55, Colobo 7');
INSERT INTO Branch VALUES(4 , 445 ,'Dematagoda Branch' , '352 Kelaniya RD, Dematagoda');


CREATE TABLE AccountType(
code INTEGER , 
name_ VARCHAR (20), 
description_ VARCHAR(40),
PRIMARY KEY(code)
);

INSERT INTO AccountType VALUES(1234,'Savings Account','Highest Rate:1.75%');
INSERT INTO AccountType VALUES(2233,'Current Account','Highest Rate:2.63%');
INSERT INTO AccountType VALUES(4455,'Fixed Account','Highest Rate:8.63%');


CREATE TABLE Account(
accNo INTEGER , 
balance REAL CHECK (balance >= 0),				--Ensure that the balance in an account is always non-negative number (>= 0). --
code INTEGER,
branchNo INTEGER,
accTypeCode INTEGER FOREIGN KEY REFERENCES AccountType,
PRIMARY KEY (accNo),
FOREIGN KEY (code,branchNo) REFERENCES Branch

);


INSERT INTO Account VALUES(42164224,15752.25, 1 ,111 ,1234);
INSERT INTO Account VALUES(42555884,124785.80, 1 ,113 ,2233);
INSERT INTO Account VALUES(55224477,24578.62, 2 ,222 ,1234);
INSERT INTO Account VALUES(12457893,51588.25, 3 ,333 ,2233);
INSERT INTO Account VALUES(65256356,95595.85, 4 ,444 ,4455);


CREATE TABLE Savings(
code INTEGER PRIMARY KEY,
interest_rate REAL CHECK (interest_rate >= 0), -- Ensure that the interest_rate of Savings account is a non-negative number (>= 0). --
FOREIGN KEY (code) REFERENCES AccountType
);

INSERT INTO Savings Values(1234,1.75);


CREATE TABLE Current_ (
code INTEGER PRIMARY KEY,
maxCheque real,
FOREIGN KEY (code) REFERENCES AccountType
);

INSERT INTO Current_ Values (2233 , 500000.40);


CREATE TABLE Customer(

number INTEGER PRIMARY KEY,
name_ VARCHAR(20) NOT NULL,																-- Ensure that the customer’s name is not null --
address_ VARCHAR(50),
phone CHAR(10),
nic CHAR(10) CHECK (nic LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][V|v]'),	-- Ensure that the customer’s NIC number contains 10 digits --
pin CHAR(4) CHECK (pin LIKE '[0-9][0-9][0-9][0-9]' )									--Ensure that the customer’s PIN number is a four digit (0-9) number --

);


INSERT INTO Customer Values (1001,'Amal Jayalath', '30A,Kaduwela,','0712233458' ,'978452562V','1588');

INSERT INTO Customer Values (1002,'Jayanka srimal', 'No 50,Malabe,','0112456789' ,'953344875V','3000');
INSERT INTO Customer Values (1003,'Mayantha perera', 'No 40,Kottawa,','0754868245' ,'978452562V','4512');
INSERT INTO Customer Values (1004,'Janith Perera', '20/3,Padukka RD, Awissawella','0702214789' ,'957892147V','5878');

select * from Customer


Create TABLE Transaction_ (

tid INTEGER PRIMARY KEY,
ammount REAL,
description_ VARCHAR(40),
executed_by VARCHAR(30) CHECK (executed_by in ('ATM' , 'Teller' , 'Bank' ,'Standing Order' , 'Cheque' , 'On-Line' , 'Other' )),			--In the Transaction table, the value for by attribute must be one of the following: “ATM”, “Teller”, “Bank”, “Standing Order”, “Cheque”, “On-Line” or “Other”. --
dateTime_ DATETIME  DEFAULT GETDATE()				 -- In the Transaction table, the default value for date&time should be the system datetime. --

);

INSERT INTO Transaction_ VALUES (222212,1200.50,'Water Bill Payment','Cheque', GETDATE() );
INSERT INTO Transaction_ VALUES (333345,20455.80,'Online Payment','Other', GETDATE() );
INSERT INTO Transaction_ VALUES (444513,1452.12,'Current Bill ','Bank', GETDATE() );
INSERT INTO Transaction_ VALUES (555482,20000.00,'Transfer Money ','Standing Order', GETDATE() );

select * from Transaction_;


Create TABLE Belongs_To(

cno INTEGER FOREIGN KEY REFERENCES Customer, 
accno INTEGER FOREIGN KEY REFERENCES Account,
PRIMARY KEY(cno,accno),

);

INSERT INTO Belongs_To VALUES(1001,42164224);
INSERT INTO Belongs_To VALUES(1002,42555884);
INSERT INTO Belongs_To VALUES(1003,55224477);
INSERT INTO Belongs_To VALUES(1004,12457893);

select * from Belongs_To;

CREATE TABLE Has(

accno INTEGER FOREIGN KEY REFERENCES Account,
tid INTEGER FOREIGN KEY REFERENCES Transaction_,
type_ VARCHAR(30) CHECK (type_ in ('credit', 'debit')),			-- The type descriptive attribute of the “has” relationshipbetween  Transaction  table  and Account table should have one of the following values: “credit” or “debit”. -- 
PRIMARY KEY(accno,tid)

);

INSERT INTO Has VALUES (42164224,222212,'credit')
INSERT INTO Has VALUES (42555884,333345,'credit')
INSERT INTO Has VALUES (55224477,444513,'credit')
INSERT INTO Has VALUES (12457893,555482,'debit')


