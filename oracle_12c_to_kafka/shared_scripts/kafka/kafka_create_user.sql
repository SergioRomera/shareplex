drop user kafka cascade;

create user kafka identified by kafka;
grant dba to kafka;

CREATE TABLE KAFKA.kafka_table(
  id Number GENERATED ALWAYS AS IDENTITY(
    NOMAXVALUE
    NOMINVALUE
    CACHE 20) NOT NULL,
  description Varchar2(100 )
)
/

-- Add keys for table kafka_table

ALTER TABLE KAFKA.kafka_table ADD CONSTRAINT PK_kafka_table PRIMARY KEY (id)
/