-- Реализуйте ограничение “чтобы получить скидку 10% надо в сумме накупить пирогов не менее чем на 10000 рублей”. 
-- Изменение скидки должно отвергаться, если это ограничение нарушается. И желательно наоборот, как только требуемая сумма
-- накоплена, так сразу скидка должна автоматически стать 10%.
with piesCost as (select pName, pCost as (pricePerKg * weight))
create view ordersCost as select orderId, customer, oCost as sum(pNumber * pCost)
from Orders
inner join ordersPies2 as (ordersPies inner join PiesCost on piesCost.pName = ordersPies.pName)
on Orders.orderId =ordersPies2.orderId group by orderId;

create trigger discountTrigger on Orders instead of insert, update as
begin
declare @cust1 varchar(20)= select top1 customer from inserted
declare @cust2 varchar(20)= select top1 customer from deleted
declare @totalCost int = select sum(oCost) from ordersCost where customer = @cust1
if @totalCost < 10000 then
    if @cust2 is null then
	    insert into Orders values (select top 1 orderId from inserted,
								  select top 1 orderDate from inserted,
								  select top 1 customer from inserted,
								  select top 1 adress from inserted,
								  select top 1 status from inserted,
								  0)
	else
	update Orders set discount = 0 where orderId = (select top 1 orderId from inserted)
else
    if @cust2 is null then
	    insert into Orders values (select top 1 orderId from inserted,
								  select top 1 orderDate from inserted,
								  select top 1 customer from inserted,
								  select top 1 adress from inserted,
								  select top 1 status from inserted,
								  10) 
	else
	    update Orders set discount = 10 where orderId = (select top 1 orderId from inserted)
end