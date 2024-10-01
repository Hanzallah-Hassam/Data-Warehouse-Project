USE DATABASE globalmart;


CREATE TABLE RAW.Customers (
    customer_id STRING PRIMARY KEY, 
    customer_unique_id STRING,
    customer_zip_code_prefix INT,
    customer_city STRING,
    customer_state STRING
);
COPY INTO RAW.Customers
FROM @raw.customer/olist_customers_dataset.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);


CREATE TABLE RAW.Geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city STRING,
    geolocation_state STRING,
    PRIMARY KEY (geolocation_zip_code_prefix)
);
COPY INTO RAW.Geolocation
FROM @raw.customer/olist_geolocation_dataset.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);


CREATE TABLE RAW.Order_Items (
    order_id STRING,
    order_item_id INT,
    product_id STRING,
    seller_id STRING,
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES RAW.Orders(order_id),  
    FOREIGN KEY (product_id) REFERENCES RAW.Products(product_id),  
    FOREIGN KEY (seller_id) REFERENCES RAW.Sellers(seller_id)  
);
COPY INTO RAW.Order_Items
FROM @raw.customer/olist_order_items_dataset.csv.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);


CREATE TABLE RAW.Order_Payments (
    order_id STRING,
    payment_sequential INT,
    payment_type STRING,
    payment_installments INT,
    payment_value FLOAT,
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES RAW.Orders(order_id)  
);
COPY INTO RAW.Order_Payments
FROM @raw.customer/olist_order_payments_dataset.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);


CREATE TABLE RAW.Order_Reviews (
    review_id STRING PRIMARY KEY, 
    order_id STRING,
    review_score INT,
    review_comment_title STRING,
    review_comment_message STRING,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES RAW.Orders(order_id)  
);
COPY INTO RAW.Order_Reviews
FROM @raw.customer/olist_order_reviews_dataset.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);


CREATE TABLE RAW.Orders (
    order_id STRING PRIMARY KEY,  
    customer_id STRING,
    order_status STRING,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES RAW.Customers(customer_id)  
);
COPY INTO RAW.Orders 
FROM @raw.customer/olist_orders_dataset.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);


CREATE TABLE RAW.Products (
    product_id STRING PRIMARY KEY,  
    product_category_name STRING,
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT,
    FOREIGN KEY (product_category_name) REFERENCES RAW.Product_Category_Name_Translation(product_category_name) 
);
COPY INTO RAW.Products
FROM @raw.customer/olist_products_dataset.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

CREATE TABLE RAW.Sellers (
    seller_id STRING PRIMARY KEY,  
    seller_zip_code_prefix INT,
    seller_city STRING,
    seller_state STRING
);
COPY INTO RAW.Sellers
FROM @raw.customer/olist_sellers_dataset.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);


CREATE TABLE RAW.Product_Category_Name_Translation (
    product_category_name STRING PRIMARY KEY, 
    product_category_name_english STRING
);
COPY INTO RAW.Product_Category_Name_Translation
FROM @raw.customer/product_category_name_translation.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
