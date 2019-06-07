-- Реализуйте ограничение “чтобы получить скидку 10% надо в сумме накупить пирогов не менее чем на 10000 рублей”. 
-- Изменение скидки должно отвергаться, если это ограничение нарушается. И желательно наоборот, как только требуемая сумма
-- накоплена, так сразу скидка должна автоматически стать 10%.
create view piesCost as (select pName, (pricePerKg * weight) as pCost from Pies);
create view ordersCost as select Orders.orderId, customer, sum(pNumber * pCost) as oCost
from Orders
inner join (ordersPies inner join PiesCost on piesCost.pName = ordersPies.pName) as ordersPies2
on Orders.orderId = ordersPies2.orderId group by Orders.orderId;
drop trigger discountTrigger on Orders;
create trigger discountTrigger before insert or update on Orders
for each row
execute procedure discount_trigger();
create or replace function discount_trigger()
 returns trigger as
$BODY$ 
declare totalCost double precision = (select sum(oCost) from ordersCost where customer = new.customer);
begin
raise notice '%', new.customer;
if totalCost < 10000 or totalCost is null then
    raise notice '0';
    new.discount := 0;
else
    raise notice '10';
    new.discount := 10;
end if;
return new;
end;
$BODY$
LANGUAGE plpgsql VOLATILE;
