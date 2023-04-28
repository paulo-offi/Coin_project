CREATE DATABASE vtc_DB;
USE vtc_DB;

CREATE TABLE enterprise (
    id_ent
        INT 
        NOT NULL 
        AUTO_INCREMENT 
        PRIMARY KEY
    , 
    name_ent 
        VARCHAR(255)
        NOT NULL
    ,
    balance
        DOUBLE(10, 2)
    ,
    description_ent
        TEXT
        NOT NULL
);

CREATE TABLE product (
    id_prod
        INT 
        NOT NULL 
        AUTO_INCREMENT 
        PRIMARY KEY
    , 
    name_prod 
        VARCHAR(255)
        NOT NULL
    ,
    value_prod
        DOUBLE(6, 2)
    ,
    fk_id_ent
        FOREIGN KEY (id_prod) REFERENCES enterprise(id_ent)
        NOT NULL
);

CREATE TABLE client (
    id_client
        GUID 
        NOT NULL
        PRIMARY KEY
    , 
    name_cli 
        VARCHAR(255)
        NOT NULL
    ,
    balance_client
        DOUBLE(10, 2)
    ,
    birth_data
        DATE
        NOT NULL
);

CREATE TABLE user (
    id_user
        INT
        NOT NULL 
        AUTO_INCREMENT
        PRIMARY KEY
    ,
    name_user
        VARCHAR(255)
        NOT NULL
    ,
    office
        ENUM ("admin", "commission", "worker")
    ,
    login_user
        VARCHAR(255)
        NOT NULL
    ,
    password_user
        VARCHAR(255)
        DEFAULT "123@change"
    ,
    observation
        TEXT
    ,
    fk_id_ent
        FOREIGN KEY (id_user) REFERENCES enterprise(id_ent)
);

CREATE TABLE pay_box (
    id_pb
        INT
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY
    ,
    description_pb
        VARCHAR(255)
        NOT NULL
    ,
    type_pb
        ENUM ("input", "output")
        NOT NULL
    ,
    checking_copy
        BLOB
        NOT NULL
    ,
    value_pb
        NOT NULL
        DOUBLE(8, 2)
    ,
    date_hour
        DATETIME
        NOT NULL
    ,
    responsible_action
        VARCHAR(255)
        NOT NULL
    ,
    fk_id_ent
        FOREIGN KEY (id_pb) REFERENCES enterprise(id_ent)
    ,
    fk_id_user
        FOREIGN KEY (id_pb) REFERENCES user(id_user)
);

CREATE TABLE purchase (
    id_purchase
        INT
        NOT NULL
        AUTO_INCREMENT
        PRIMARY KEY
    ,
    fk_id_client
        FOREIGN KEY (id_purchase) REFERENCES client(id_client)
    ,
    fk_id_product
        FOREIGN KEY (id_purchase) REFERENCES product(id_prod)
    ,
    fk_id_pb
        FOREIGN KEY (id_purchase) REFERENCES pay_box(id_pb)
);