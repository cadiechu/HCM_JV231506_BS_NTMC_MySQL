create database test;
use test;

create table categories
(
    category_id int primary key auto_increment,
    name        varchar(100) not null unique,
    status      tinyint default 0
);
insert into categories (name, status)
values ('Ao', '1'),
       ('Quan', '1'),
       ('Mu', '1'),
       ('Giay', '1');
create table products
(
    products_id int primary key auto_increment,
    name        varchar(200) not null,
    price       float        not null,
    image       varchar(200),
    category_id int,
    foreign key (category_id) references categories (category_id)
);
alter table products
    Add sale_price float;
insert into products (name, category_id, price, sale_price)
VALUES ('Ao so Mi', '1', 150000, 149000),
       ('Ao khoac da', 1, 500000, 499000),
       ('Quan Kaki', 2, 200000, 199000),
       ('Quan Tay', 4, 1000000, 900000),
       ('Mu Bao Hiem', 3, 100000, 90000);
create table customers
(
    customers_id int primary key auto_increment,
    name         varchar(100) not null,
    email        varchar(100) not null unique,
    image        varchar(200),
    birthday     date,
    gender       tinyint
);
insert into customers (name, email, birthday, gender)
VALUES ('Nguyen Khoi Minh', 'khoi@gmail.com', '2021-12-21', 1),
       ('Nguyen Khanh Linh', 'linh@gmail.com', '2021-12-12', 0),
       ('Do Khanh Linh', 'linh2@gmail.com', '1999-01-01', 0);
create table orders
(
    orders_id    int primary key auto_increment,
    customers_id int,
    created      timestamp default now(),
    status       tinyint   default 0,
    foreign key (customers_id) references customers (customers_id)
);
insert into orders (customers_id, created, status)
values (1, '2023-11-08', 0),
       (2, '2023-11-09', 0),
       (1, '2023-11-09', 0),
       (3, '2023-11-09', 0);
create table order_details
(
    orders_id   int,
    products_id int,
    quantity    int   not null,
    price       float not null,
    foreign key (orders_id) references orders (orders_id),
    foreign key (products_id) references products (products_id)
);
insert into order_details
(orders_id, products_id, quantity, price)
values (1, 1, 1, 149000),
       (1, 2, 1, 499000),
       (2, 2, 2, 499000),
       (3, 2, 1, 499000),
       (4, 1, 1, 149000);

# 1. Hiển thị danh sách danh mục gồm id,name,status (3đ)
select *
from categories;
# 2. Hiển thị danh sách sản phẩm gồm id,name,price,sale_price,category_name(tên danh mục) (7đ).
select p.products_id, p.name, p.price, p.sale_price, c.name
from products p
         join categories c on p.category_id = c.category_id;
# 3. Hiển thị danh sách sản phẩm có giá lớn hơn 200000 (5đ).
select *
from products
where price > 200000;
# 4. Hiển thị 3 sản phẩm có giá cao nhất (5đ).
select *
from products
order by price desc
limit 3;
# 5. Hiển thị danh sách đơn hàng gồm id,customer_name,created,status.(5đ)
select o.customers_id, c.name, o.created, o.status
from orders o
         join customers c on o.customers_id = o.customers_id;
# 6. Cập nhật trạng thái đơn hàng có id là 1(5đ)
update orders
set status = 1
where orders_id = 1;
# 7. Hiển thị chi tiết đơn hàng của đơn hàng có id là 1, bao gồm order_id,product_name,quantity,price,total_money là giá trị của (price * quantity)(10đ)
select od.orders_id, p.name, od.quantity, od.price, od.price * od.quantity as total_money
from order_details od
         join products p on od.products_id = od.products_id
where orders_id like 1;
# 8. Danh sách danh mục gồm, id,name, quantity_product(đếm trong bảng product) (20đ)
select c.category_id, c.name, count(*) as quantity_product
from categories c
         join products p on c.category_id = p.category_id
group by c.category_id
