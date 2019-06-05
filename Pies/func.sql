-- У компании возникли проблемы с поставщиками. Подсчитайте остатки продуктов и определите, какое максимальное количество
-- заказов на завтра можно выполнить из имеющихся в наличии запасов
-- (если в заказе два пирога, а можно испечь только один, то такой заказ считается невыполненным).
create or replace function maxOrders ()
 returns int
LANGUAGE plpgsql
as $$
declare maxord int = 0;
declare r orders%rowtype;
declare r1 products%rowtype;
begin
create view tomorrowOrders as select * from orders
where (orderDate = 'tomorrow' and (status = 'accepted' or status = 'proceeded'))
order by orderId;
for r in select * from tomorrowOrders
loop
    create view productsNeeded as
	(with piesInOrder as (select * from ordersPies, r where ordersPies.orderId = r.orderId)
	select prName, sum (pNumber * amount) as amount from piesInOrder inner join receits on piesInOrder.pName = receits.pName
	group by prName);
	create view restAfterOrder as
	select productsNeeded.prName, (rest - productsNeeded.amount) as rest from productsNeeded inner join products on produtsNeeded.prName = products.prName;
	exit when sum(restAfterOrder.rest) != abs(sum(restAfterOrder.rest));
	for r1 in select * from restAfterOrder
	loop
	    update products set rest = r1.rest where products.prName = r1.prName;
 	end loop;    
	maxord := maxord + 1;
	drop view if exists productsNeeded cascade;
    drop view if exists restAfterOrder cascade;
end loop;
drop view if exists tomorrowOrders cascade;
drop view if exists productsNeeded cascade;
drop view if exists restAfterOrder cascade;
return maxord;
end;
$$;

select maxOrders();
