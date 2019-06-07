insert into Pies values ('Apple', 3, 1000, 30, 60);
insert into Pies values ('Chicken', 1.5, 3000, 40, 50);
insert into Pies values ('Cherry', 1, 2000, 70, 20);
insert into Pies values ('Meat', 1, 3000, 30, 40);

insert into Receits values ('Apple', 'Apples', 1);
insert into Receits values ('Apple', 'Flour', 1);
insert into Receits values ('Apple', 'Eggs', 1);
insert into Receits values ('Chicken', 'Chicken', 1);
insert into Receits values ('Chicken', 'Flour', 0.5);
insert into Receits values ('Chicken', 'Caraway', 1);
insert into Receits values ('Cherry', 'Cherries', 1);
insert into Receits values ('Cherry', 'Flour', 0.5);
insert into Receits values ('Meat', 'Beef', 0.5);
insert into Receits values ('Meat', 'Pork', 0.4);
insert into Receits values ('Meat', 'Flour', 0.1);

insert into Products values ('Apples', 4);
insert into Products values ('Flour', 1);
insert into Products values ('Chicken', 5);
insert into Products values ('Cherries', 0);
insert into Products values ('Caraway', 1);
insert into Products values ('Eggs', 10)
insert into Products values ('Beef', 1);
insert into Products values ('Pork', 1);

insert into Providers values ('fruits', '111', '+70005559911');
insert into Providers values ('flourProv', '222', '+39293334455');
insert into Providers values ('meat', '333', '+78881112233');
insert into Providers values ('flavours', '444', '+81234567890');

insert into Provisions values ('fruits', 'Apples', 100, 10);
insert into Provisions values ('fruits', 'Cherries', 200, 10);
insert into Provisions values ('flourProv', 'Flour', 50, 11);
insert into Provisions values ('meat', 'Chicken', 300, 5);
insert into Provisions values ('flavours', 'Caraway', 10, 20);

insert into Orders values (1, to_date('04.06.2019', 'dd.mm.yyyy'), 'anna', 'aaa', 'completed', 0);
insert into Orders values (2, to_date('04.06.2019', 'dd.mm.yyyy'), 'ivan', 'bbb', 'completed', 0);
insert into Orders values (3, to_date('02.06.2019', 'dd.mm.yyyy'), 'denis', 'ccc', 'completed', 0);
insert into Orders values (4, to_date('04.06.2019', 'dd.mm.yyyy'), 'anna', 'aaa', 'accepted', 0);
insert into Orders values (5, 'tomorrow', 'anna', 'aaa', 'accepted', 0);
insert into Orders values (6, 'tomorrow', 'denis', 'ccc', 'accepted', 0);

delete from orderspies where orderId > 3;
delete from orders where orderId > 3;
select * from orders;

insert into OrdersPies values (1, 'Chicken', 1);
insert into OrdersPies values (1, 'Apple', 3);
insert into OrdersPies values (2, 'Chicken', 2);
insert into OrdersPies values (2, 'Meat', 2);
insert into OrdersPies values (3, 'Meat', 3);
insert into OrdersPies values (4, 'Chicken', 4);
insert into OrdersPies values (5, 'Chicken', 1);
insert into OrdersPies values (6, 'Chicken', 2);

