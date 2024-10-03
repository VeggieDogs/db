CREATE DATABASE orders;

USE orders;

create table Users
(
    user_id      int auto_increment
        primary key,
    username     varchar(255)                        not null,
    email        varchar(255)                        not null,
    first_name   varchar(255)                        null,
    last_name    varchar(255)                        null,
    phone_number varchar(20)                         null,
    address      varchar(255)                        null,
    created_at   timestamp default CURRENT_TIMESTAMP null,
    constraint email
        unique (email)
);

create table Products
(
    product_id   int auto_increment
        primary key,
    product_name varchar(255)                         not null,
    price        decimal(10, 2)                       not null,
    quantity     int                                  not null,
    description  text                                 null,
    image_url    varchar(255)                         null,
    is_sold      tinyint(1) default 0                 null,
    created_at   timestamp  default CURRENT_TIMESTAMP null,
    seller_id    int                                  null,
    constraint Products_ibfk_1
        foreign key (seller_id) references Users (user_id)
);

create table Orders
(
    order_id      int auto_increment
        primary key,
    quantity      int                                 not null,
    total_price   decimal(10, 2)                      not null,
    purchase_time timestamp default CURRENT_TIMESTAMP null,
    status        varchar(50)                         null,
    seller_id     int                                 null,
    buyer_id      int                                 null,
    product_id    int                                 null,
    created_at    timestamp default CURRENT_TIMESTAMP null,
    constraint Orders_ibfk_1
        foreign key (seller_id) references Users (user_id),
    constraint Orders_ibfk_2
        foreign key (buyer_id) references Users (user_id),
    constraint Orders_ibfk_3
        foreign key (product_id) references Products (product_id)
);

create index buyer_id
    on Orders (buyer_id);

create index product_id
    on Orders (product_id);

create index seller_id
    on Orders (seller_id);

create index seller_id
    on Products (seller_id);

