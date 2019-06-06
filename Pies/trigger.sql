-- Реализуйте ограничение “чтобы получить скидку 10% надо в сумме накупить пирогов не менее чем на 10000 рублей”. 
-- Изменение скидки должно отвергаться, если это ограничение нарушается. И желательно наоборот, как только требуемая сумма
-- накоплена, так сразу скидка должна автоматически стать 10%.
create view piesCost as (select pName, (pricePerKg * weight) as pCost from Pies);
create view ordersCost as select Orders.orderId, customer, sum(pNumber * pCost) as oCost
from Orders
inner join (ordersPies inner join PiesCost on piesCost.pName = ordersPies.pName) as ordersPies2
on Orders.orderId = ordersPies2.orderId group by Orders.orderId;

create trigger discountTrigger after insert or update of discount on Orders
execute procedure discount_trigger();
create or replace function discount_trigger()
 returns trigger as
$BODY$ 
--declare cust1 varchar(20) = (select top1 customer from new);
--declare cust2 varchar(20) = (select top1 customer from old);
declare totalCost int = (select sum(oCost) from ordersCost where customer = new.customer);
begin
if totalCost < 10000 then
    update orders set discount = 0 where orderId = new.orderId;
else
   update orders set discount = 0 where orderId = new.orderId; 
end if;
return new;
end;
$BODY$
LANGUAGE plpgsql VOLATILE;

select * from Orders;