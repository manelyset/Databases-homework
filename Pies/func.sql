-- У компании возникли проблемы с поставщиками. Подсчитайте остатки продуктов и определите, какое максимальное количество
-- заказов на завтра можно выполнить из имеющихся в наличии запасов
-- (если в заказе два пирога, а можно испечь только один, то такой заказ считается невыполненным).
create or replace function maxOrders ()
 returns int
LANGUAGE plpgsql
as $$
declare maxord int = 0;
declare oid orders%rowtype;
declare r products%rowtype;
declare n products%rowtype;
begin
CREATE TABLE products_copy (LIKE products INCLUDING ALL);
INSERT INTO products_copy
SELECT * FROM products;
create view tomorrowOrders as select * from orders
where (orderDate = 'tomorrow' and (status = 'accepted' or status = 'proceeded'))
order by orderId;
for oid in select orderId from tomorrowOrders
loop
    create view productsNeeded as
	(with piesInOrder as (select * from ordersPies where ordersPies.orderId = 5)
	select prName, sum (pNumber * amount) as amount from piesInOrder inner join receits on piesInOrder.pName = receits.pName
	group by prName);
	select * from productsNeeded;
	create view restAfterOrder as
	select productsNeeded.prName, (restkg - productsNeeded.amount) as rest from productsNeeded inner join products_copy on productsNeeded.prName = products_copy.prName;
	select * from restAfterOrder;
	exit when sum(restAfterOrder.rest) != abs(sum(restAfterOrder.rest));
	for r in select rest from restAfterOrder
	loop
	    for n in select prName from restAfterOrder
		loop
	        update products_copy set rest = r where products.prName = n;
		end loop;	
 	end loop;    
	maxord := maxord + 1;
	drop view if exists productsNeeded cascade;
    drop view if exists restAfterOrder cascade;
end loop;
drop view if exists tomorrowOrders cascade;
drop view if exists productsNeeded cascade;
drop view if exists restAfterOrder cascade;
drop table products_copy cascade;
return maxord;
end;
$$;

select maxOrders();


