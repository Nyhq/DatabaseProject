--Alter Session

ALTER session set nls_date_format = 'DD-MM-YYYY HH24';

--Drop table statements to ensure that no tables with the same names exist in the DB

DROP TABLE booking CASCADE CONSTRAINTS;

DROP TABLE burger_shack CASCADE CONSTRAINTS;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE party CASCADE CONSTRAINTS;

DROP TABLE staff CASCADE CONSTRAINTS;

DROP TABLE "Table" CASCADE CONSTRAINTS;

--Table creation statements
CREATE TABLE booking (
    booking_time       VARCHAR2(5) NOT NULL,
    number_of_people NUMBER(7) NOT NULL,
    "UID"            NUMBER(7) NOT NULL,
    fine             NUMBER(9, 2) DEFAULT 0,
    staff_uid        NUMBER(7) NOT NULL,
    duration         NUMBER(3) NOT NULL, --In mins
    CHECK (number_of_people <= 6)
);

ALTER TABLE booking ADD CONSTRAINT booking_pk PRIMARY KEY ( "UID" );

CREATE TABLE burger_shack (
    address      VARCHAR2(250) NOT NULL,
    phone_number NUMBER(11) NOT NULL,
    "UID"        NUMBER(7) NOT NULL
);

ALTER TABLE burger_shack ADD CONSTRAINT burger_shack_pk PRIMARY KEY ( "UID" );

CREATE TABLE customer (
    name        VARCHAR2(30) NOT NULL,
    address     VARCHAR2(50) NOT NULL,
    cust_email       VARCHAR2(30) NOT NULL,
    age         NUMBER(3) NOT NULL,
    "UID"       NUMBER(7) NOT NULL,
    booking_uid NUMBER(7) NOT NULL,
    CONSTRAINT Age_chk CHECK (Age >= 18),
    CONSTRAINT cust_email_chk CHECK(cust_email like '%_@_%._%')
);


ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( "UID" );

CREATE TABLE party (
    name         VARCHAR2(30) NOT NULL,
    email        VARCHAR2(35) NOT NULL,
    phone_number NUMBER(11) NOT NULL,
    "UID"        NUMBER(7) NOT NULL,
    customer_uid NUMBER(7) NOT NULL
);

ALTER TABLE party ADD CONSTRAINT party_pk PRIMARY KEY ( "UID" );

CREATE TABLE staff (
    name             VARCHAR2(30) NOT NULL,
    address          VARCHAR2(50) NOT NULL,
    phone_number     NUMBER(11) NOT NULL,
    staff_email      VARCHAR2(35) NOT NULL,
    dob              DATE NOT NULL,
    start_date       DATE NOT NULL,
    "UID"            NUMBER(7) NOT NULL,
    burger_shack_uid NUMBER(7) NOT NULL,
    CONSTRAINT WaiterEmail_chk CHECK(staff_email like '%@burgershack.com')
);

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( "UID" );

CREATE TABLE "Table" (
    type             NUMBER(4) NOT NULL,
    location         NUMBER(4) NOT NULL, --0 Exterior 1 Interior
    "UID"            NUMBER(7) NOT NULL,
    burger_shack_uid NUMBER(7) NOT NULL
);

ALTER TABLE "Table" ADD CONSTRAINT table_pk PRIMARY KEY ( "UID" );


--Foreign key defenitions
ALTER TABLE booking
    ADD CONSTRAINT booking_staff_fk FOREIGN KEY ( staff_uid )
        REFERENCES staff ( "UID" );

ALTER TABLE customer
    ADD CONSTRAINT customer_booking_fk FOREIGN KEY ( booking_uid )
        REFERENCES booking ( "UID" );

ALTER TABLE party
    ADD CONSTRAINT party_customer_fk FOREIGN KEY ( customer_uid )
        REFERENCES customer ( "UID" );


ALTER TABLE staff
    ADD CONSTRAINT staff_burger_shack_fk FOREIGN KEY ( burger_shack_uid )
        REFERENCES burger_shack ( "UID" );

ALTER TABLE "Table"
    ADD CONSTRAINT table_burger_shack_fk FOREIGN KEY ( burger_shack_uid )
        REFERENCES burger_shack ( "UID" );

--Constraints


