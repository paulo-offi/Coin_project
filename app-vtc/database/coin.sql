CREATE DATABASE vtc_database;

USE vtc_database;



CREATE TABLE enterprise (
    enterprise_id
        INT 
        NOT NULL 
        AUTO_INCREMENT 
        PRIMARY KEY
    , 
    enterprise_name
        VARCHAR(255)
        NOT NULL
    ,
    representative
        VARCHAR(255)
        NOT NULL
    ,
    balance
        DOUBLE(10, 2)
    ,
    enterprise_description
        TEXT
        NOT NULL
);

CREATE TABLE product (
    product_id
        INT 
        NOT NULL 
        AUTO_INCREMENT 
        PRIMARY KEY
    , 
    product_name 
        VARCHAR(255)
        NOT NULL
    ,
    product_value
        DOUBLE(6, 2)
    ,
    FK_product_enterprise
		INT
        NOT NULL
	,
    FOREIGN KEY (FK_product_enterprise) REFERENCES enterprise(enterprise_id)

);

CREATE TABLE `client` (
    qrcode_guid
		VARCHAR(32)
        NOT NULL
        PRIMARY KEY
    , 
    client_name
        VARCHAR(255)
        NOT NULL
    ,
    client_wallet
        DOUBLE(10, 2)
    ,
    birth_date
        DATE
        NOT NULL
);

CREATE TABLE `user`(
    user_id
        INT
        NOT NULL 
        AUTO_INCREMENT
        PRIMARY KEY
    ,
    user_name
        VARCHAR(255)
        NOT NULL
    ,
    occupation
        ENUM ("admin", "commission", "worker")
    ,
    user_login
        VARCHAR(255)
        NOT NULL
    ,
    user_password
        VARCHAR(255)
        DEFAULT "123@change"
    ,
    observation
        TEXT
    ,
    FK_user_enterprise
		INT
        NOT NULL
	,
    FOREIGN KEY (FK_user_enterprise) REFERENCES enterprise(enterprise_id)
);



CREATE TABLE paybox (
    paybox_id
        INT
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY
    ,
    paybox_description
        VARCHAR(255)
        NOT NULL
    ,
    paybox_type
        ENUM ("input", "output")
        NOT NULL
    ,
    payment_voucher
        BLOB
        NOT NULL
    ,
    paybox_value
        DOUBLE(8, 2)
        NOT NULL
    ,
    date_hour
        DATETIME
        NOT NULL
    ,
    responsible
        VARCHAR(255)
        NOT NULL
    ,
    FK_paybox_enterprise
		INT
        NOT NULL
	,
    FK_paybox_user
		INT
        NOT NULL
	,
    
    FOREIGN KEY (FK_paybox_enterprise) REFERENCES enterprise(enterprise_id)
    ,
    FOREIGN KEY (FK_paybox_user) REFERENCES `user`(user_id)
);

CREATE TABLE purchase (
    purchase_id
        INT
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY
    ,
    FK_purchase_client
		VARCHAR(32)
        NOT NULL
	,
    FK_purchase_product
		INT
        NOT NULL
	,
    FK_purchase_paybox
		INT
        NOT NULL
	,
    FOREIGN KEY (FK_purchase_client) REFERENCES `client`(qrcode_guid)
    ,
    FOREIGN KEY (FK_purchase_product) REFERENCES product(product_id)
    ,
    FOREIGN KEY (FK_purchase_paybox) REFERENCES paybox(paybox_id)
);
