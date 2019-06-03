select pName from Pies t1 inner join Receits t2 on t1.pName = t2.pName where prName = 'caraway' group by pName;

select orderId, orderDate from Orders inner join OrdersPies where (status = 'completed' and pName = 'meat' and pNumber >= 2) order by orderDate;

with piesCost as (select pName, pCost as (pricePerKg * weight)),
nbPiesOrdered as (select pName, sum(pNumber) from Orders inner join OrdersPies where status = 'completed' group by pName)
select pName, profit as (pCost * pNumber) from piesCost inner join nbPiesOrdered;

with totalPies1 as (select orderId, sumPies as sum(pNumber) from OrdersPies group by orderId)
create view totalPies as select orderId, customer, adress, sumPies from totalPies1 inner join Orders 
on totalPies1.orderId = Orders.orderId;

with minimums as (select customer, adress, minOrder as min(sumPies) from totalPies group by customer),
averageOrder as (select avg(sumPies) from totalPies)
select customer, adress, minOrder from minimums where (minOrder >= averageOrder)