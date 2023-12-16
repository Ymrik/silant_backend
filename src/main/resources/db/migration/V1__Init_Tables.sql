set search_path to silant_db;

CREATE TABLE d_technic_model
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE d_engine_model
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE d_transmission_model
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE d_drive_axle_model
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE d_guiding_axle_model
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE d_maintenance_type
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE d_failure_type
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE d_repair_method
(
    id          serial PRIMARY KEY,
    name        text,
    description text
);

CREATE TABLE users
(
    username varchar(40) PRIMARY KEY,
    password varchar(20)
);

CREATE TABLE roles
(
    id serial PRIMARY KEY ,
    name varchar(20)
);

CREATE TABLE user_roles
(
    username varchar(40),
    role_id integer,
    CONSTRAINT user_fk FOREIGN KEY(username) REFERENCES users(username),
    CONSTRAINT role_fk FOREIGN KEY(role_id) REFERENCES roles(id),
    CONSTRAINT user_role_pk PRIMARY KEY (username, role_id)
);


CREATE TABLE service_company
(
    id serial PRIMARY KEY,
    username varchar(40),
    name text,
    description text,
    CONSTRAINT user_fk FOREIGN KEY (username) REFERENCES users(username),
    CONSTRAINT user_unique UNIQUE (username)
);

CREATE TABLE client
(
    id serial PRIMARY KEY,
    username varchar(40),
    name text,
    CONSTRAINT user_fk FOREIGN KEY (username) REFERENCES users(username),
    CONSTRAINT user_unique UNIQUE (username)
);

CREATE TABLE machine
(
    id serial PRIMARY KEY,
    serial_number text,
    technic_model_id integer,
    engine_model_id integer,
    engine_serial_number text,
    transmission_model_id integer,
    transmission_serial_number text,
    drive_axle_model_id integer,
    drive_axle_serial_number text,
    guiding_axle_model_id integer,
    guiding_axle_serial_number text,
    delivery_agreement text,
    shipment_date date,
    consumer text,
    consumer_address text,
    configuration text,
    service_company_id integer,
    CONSTRAINT technic_model_fk FOREIGN KEY (technic_model_id) REFERENCES d_technic_model(id),
    CONSTRAINT engine_model_fk FOREIGN KEY (engine_model_id) REFERENCES d_engine_model(id),
    CONSTRAINT transmission_model_fk FOREIGN KEY (transmission_model_id) REFERENCES d_transmission_model(id),
    CONSTRAINT drive_axle_model_fk FOREIGN KEY (drive_axle_model_id) REFERENCES d_drive_axle_model(id),
    CONSTRAINT guiding_axle_model_fk FOREIGN KEY (guiding_axle_model_id) REFERENCES d_guiding_axle_model(id),
    CONSTRAINT service_company_fk FOREIGN KEY (service_company_id) REFERENCES service_company(id),
    CONSTRAINT serial_number_unique UNIQUE (serial_number),
    CONSTRAINT engine_serial_number_unique UNIQUE (engine_serial_number),
    CONSTRAINT transmission_serial_number_unique UNIQUE (transmission_serial_number),
    CONSTRAINT drive_axle_serial_number_unique UNIQUE (drive_axle_serial_number),
    CONSTRAINT guiding_axle_serial_number_unique UNIQUE (guiding_axle_serial_number)
);

CREATE TABLE maintenance
(
    id serial PRIMARY KEY,
    maintenance_type_id integer,
    maintenance_date date,
    operating_type numeric,
    purchase_order_number text,
    purchase_order_date date,
    service_company_id integer,
    machine_id integer,
    CONSTRAINT maintenance_fk FOREIGN KEY (maintenance_type_id) REFERENCES maintenance(id),
    CONSTRAINT service_company_fk FOREIGN KEY (service_company_id) REFERENCES service_company(id),
    CONSTRAINT machine_fk FOREIGN KEY (machine_id) REFERENCES machine(id),
    CONSTRAINT purchase_order_number_unique UNIQUE (purchase_order_number)
);

CREATE TABLE reclamation
(
    id serial PRIMARY KEY,
    machine_id integer,
    failure_date date,
    operating_type numeric,
    failure_type_id integer,
    failure_description text,
    repair_method_id integer,
    spare_parts text,
    restoration_date date,
    downtime text,
    service_company_id integer,
    CONSTRAINT machine_fk FOREIGN KEY (machine_id) REFERENCES machine(id),
    CONSTRAINT failure_type_fk FOREIGN KEY (failure_type_id) REFERENCES d_failure_type(id),
    CONSTRAINT repair_method_fk FOREIGN KEY (repair_method_id) REFERENCES d_repair_method(id),
    CONSTRAINT service_company_fk FOREIGN KEY (service_company_id) REFERENCES service_company(id)
);


