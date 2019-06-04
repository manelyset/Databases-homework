-- Найдите все пироги, в состав которых входит ингредиент “тмин”
select t1.pName from Pies t1 inner join Receits t2 on t1.pName = t2.pName where prName = 'Caraway' group by t1.pName;

-- Запрос: напишите запрос, выдающий выполненные заказы, в которых было более двух мясных пирогов, в порядке убывания даты
-- (самый свежий заказ идет первым, самый давний последним)
select t1.orderId, orderDate from Orders t1 inner join OrdersPies t2 on t1.orderId = t2.orderId 
where (status = 'completed' and pName = 'Meat' and pNumber >= 2) order by orderDate;

-- Для каждого вида пирогов выведите его название и суммарный доход от этих пирогов в выполненных заказах
with piesCost as (select pName, (pricePerKg * weight) as pCost from Pies),
nbPiesOrdered as (select pName, sum(pNumber) as num from Orders t1 inner join OrdersPies t2 on t1.orderId = t2.OrderId where status = 'completed' group by pName)
select t1.pName, (pCost * num) as profit from piesCost t1 inner join nbPiesOrdered t2 on t1.pName = t2.pName;

-- Вы хотите поощрить клиентов, заказывающих много пирогов. Напишите представление, которое выведет клиентов, в чьих заказах
-- никогда не было пирогов меньше, чем средний размер заказа по всем клиентам. В представлении должны быть данные о клиенте
-- и минимальный размер его заказа.
create view totalPies1 as (select orderId, sum(pNumber) as sumPies from OrdersPies group by orderId);
create view totalPies as select totalPies1.orderId, customer, adress, sumPies from totalPies1 inner join Orders 
on totalPies1.orderId = Orders.orderId;

with minimums as (select customer, adress, min(sumPies) as minOrder from totalPies group by customer, adress)
select customer, adress, minOrder from minimums where (minOrder >= (select avg(sumPies) from totalPies));