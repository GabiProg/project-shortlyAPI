import pkg from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const { Pool } = pkg;

const user = 'postgres';
const password = `${process.env.PASSWORD}`;
const host = 'localhost';
const port = 5432;
const database = 'shortly';

const connection = new Pool({
    user,
    password,
    host,
    port,
    database,
});

export default connection;