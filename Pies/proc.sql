-- Подсчитайте остатки продуктов и определите, какое количество продуктов надо заказать, чтобы выполнить все заказы.
create or replace function missingProducts ()
 returns table (
	prName varchar(50),
	toBuy int
)
LANGUAGE plpgsql
as $$
begin
create view nbPies as select pName, pNumber, status from Orders inner join ordersPies on orders.orderId = ordersPies.orderId
where (status = 'accepted' or status = 'proceeded');
create view uncompReceits1 as (select nbPies.pName, prName, amount, pNumber from nbPies inner join receits on nbPies.pName = receits.pName);
create view uncompReceits as select prName, (pNumber * amount) as neededAmount from uncompReceits1;

create view totalNeeded as select prName, sum(neededAmount) as totalAmount from uncompReceits group by prName;
create view comparison as select totalNeeded.prName, totalAmount, restkg from totalNeeded left join products on totalNeeded.prName = products.prName;

return query select prName, (totalAmount - restkg) as toBuy from comparison where (totalAmount - restkg) > 0 ;
end;
$$;

select missingProducts();
