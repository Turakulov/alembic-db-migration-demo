## Alembic generic single-database configuration for database schema migration

[Alembic documentation](https://alembic.sqlalchemy.org/en/latest/index.html)

### How to use

1) Install alembic using `pip`
```python
pip install alembic
```

2) Create one using alembic init. This will create an environment using the “generic” template:
```console
foo@bar:~$ alembic init --template generic ./scripts
```

3)  Setting up the SQLAlchemy URL in schema.py
```python
source_engine = sqlalchemy.create_engine('postgresql+psycopg2://username:password@localhost:host/dbname')
```

4) Create a initial Migration Script
```console
foo@bar:~$ alembic revision -m "init"
```

5) Running First Migration
```console
foo@bar:~$ alembic upgrade head
INFO  [alembic.context] Context class PostgresqlContext.
INFO  [alembic.context] Will assume transactional DDL.
INFO  [alembic.context] Running upgrade None -> 25eca03e9e6f
```

6) Create Auto Generating Migrations
```console
foo@bar:~$ alembic revision --autogenerate -m "autogenerated migration"
INFO [alembic.context] Detected added table 'account'
Generating /path/to/foo/alembic/versions/ecfd9fefb5fc.py...done 
```

7) Offline migrations using generated SQL scripts. In order to specify target DB you have to use -x argument `-x url=<DB_URL>`
```console
foo@bar:~$ alembic upgrade ecfd9fefb5fc -x url=<DB_URL> --sql > migration.sql
```

```sql
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
```

### In this project we used alembic for postgres -> postgres migration
