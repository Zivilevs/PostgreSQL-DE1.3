# Database set up in Postgres DB for Goodreads Dataset

Project to create Postgres database, model and populate with goodreads dataset and once set up to run some analytic queries.

Requirements: active `Postgres server` and `Postgres client` installed.</br>
Dataset was downloaded from [here](https://www.kaggle.com/datasets/thedevastator/comprehensive-overview-of-52478-goodreads-best-b).

After cloning this repo follow these steps:</br>
**Option 1** Step by step from CLI. In repo folder run:
1. `./0_data-preparation-cleaning.ipynb`
2. `./1_create_db_ingest_data.sh`
3. `./2_create_load_tables.sh`
4. `./3_create_table_relations.sh`
5. `./4_queries_in_booksDB.ipynb`


**Option 2** Restore database from file. In CLI run.</br>
1. login to Postgres
2. ` $ psql --host=localhost --port 5432 --username=zivile --password --dbname=books
`</br>
password to use `zivile123`

You can explore DB books from your favorite GUI Client like `pgAdmin`, `DBeaver` or other or directly from `psql` client.
 
  ## Data Model
 
 ![books](https://github.com/TuringCollegeSubmissions/zivval-DE1.3/blob/master/docs/goodread_model.png)
