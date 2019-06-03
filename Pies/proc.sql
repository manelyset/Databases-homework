create proc missingProducts as
begin
with uncompReceits1 as select pNumber, prName, amount from
nbPies as (uncompleted as (select orderId from Orders where (status = 'accepted' or status = 'processed'))
inner join ordersPies on uncompleted.orderId = ordersPies.orderId)
inner join receits on nbPies.pName = receits.pName
view uncompReceits as select prName, neededAmount as (pNumber * amount) from uncompReceits1;

with totalNeeded as select prName, totalAmount as sum(neededAmount) from uncompReceits group by prName
view comparison as select * from totalNeeded left join products on totalNeeded.pName = products.pName

select prName, toBuy as (totalAmount - rest) from comparison where toBuy > 0
end