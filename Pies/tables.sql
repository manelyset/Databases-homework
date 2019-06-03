create table Pies
(pName varchar(50) primary key,
 weight float not null check (weight > 0),
 pricePerKg int not null check (pricePerKg > 0),
 workdayStats int not null check (workdayStats >= 0 and workdayStats <= 100),
 weekendStats int not null check (weekendStats >= 0 and weekendStats <= 100)
);  

create table Products
(prName varchar(50) primary key,
 restKg float check (restKg >= 0)
);

create table Providers
(provName varchar(50) primary key,
 address varchar(100) not null,
 phone char(12) not null check (phone like '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

create table Receits 
(pName varchar(50) references Pies(pName),
 prName varchar(50) references Products(prName),
 unique(pName, prName),
 amount float check (amount > 0)
);

create table Provisions
(provName varchar(50) references Providers(provName),
 prName varchar(50) references Products(prName),
 unique (provName, prName),
 pricePerKg int not null check (pricePerKg > 0),
 maxKgPerDay int not null check (maxKgPerDay > 0)
); 

create table Orders
(orderId int primary key,
 orderDate date not null,
 customer varchar(20) not null,
 adress varchar(100) not null,
 status varchar(9) check (status in ('accepted', 'processed', 'shipped', 'completed')),
 discount int not null check (discount >= 0 and discount < 100)
);

create table OrdersPies
(orderId int references Orders(orderId),
 pName varchar(50) references Pies(pName),
 unique (orderId, pName),
 pNumber int not null check (pNumber > 0)
);

drop table orderspies;
drop table orders;
drop table provisions;
drop table providers;
drop table products;
drop table receits;
drop table pies;