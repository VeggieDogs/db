DROP DATABASE IF EXISTS orders;
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
     
-- Insert sample data into Users table
INSERT INTO Users (username, email, first_name, last_name, phone_number, address) VALUES
('john_doe', 'john.doe@example.com', 'John', 'Doe', '1234567890', '123 Main St'),
('jane_smith', 'jane.smith@example.com', 'Jane', 'Smith', '9876543210', '456 Oak Ave'),
('alice_wong', 'alice.wong@example.com', 'Alice', 'Wong', '5555555555', '789 Elm Rd'),
('bob_lee', 'bob.lee@example.com', 'Bob', 'Lee', '4444444444', '321 Maple Blvd');

-- Insert sample data into Products table
INSERT INTO Products (product_name, price, quantity, description, image_url, seller_id) VALUES
('Laptop', 999.99, 10, 'A high-end laptop.', 'https://example.com/laptop.jpg', 1),
('Smartphone', 699.99, 20, 'Latest smartphone model.', 'https://example.com/smartphone.jpg', 2),
('Headphones', 199.99, 15, 'Noise-cancelling headphones.', 'https://example.com/headphones.jpg', 3),
('Backpack', 49.99, 50, 'Durable and stylish backpack.', 'https://example.com/backpack.jpg', 4);

-- Insert sample data into Orders table
INSERT INTO Orders (quantity, total_price, status, seller_id, buyer_id, product_id) VALUES
(1, 999.99, 'Shipped', 1, 2, 1),
(2, 1399.98, 'Processing', 2, 3, 2),
(1, 199.99, 'Delivered', 3, 4, 3),
(3, 149.97, 'Pending', 4, 1, 4);
