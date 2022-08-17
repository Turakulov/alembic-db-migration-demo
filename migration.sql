BEGIN;

-- Running upgrade 25eca03e9e6f -> ecfd9fefb5fc

CREATE TABLE public.account (
    id SERIAL NOT NULL, 
    project_id VARCHAR(255), 
    db_alias VARCHAR(255) DEFAULT 'db'::character varying, 
    tn VARCHAR(255), 
    acl TEXT, 
    type VARCHAR(255) DEFAULT 'table'::character varying, 
    created_at TIMESTAMP WITH TIME ZONE, 
    updated_at TIMESTAMP WITH TIME ZONE, 
    CONSTRAINT nc_acl_pkey PRIMARY KEY (id)
);

UPDATE alembic_version SET version_num='ecfd9fefb5fc' WHERE alembic_version.version_num = '25eca03e9e6f';

COMMIT;

