import connection from '../dataBase/database.js';
import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';

dotenv.config();

export async function AuthorizeUser (req, res, next) {
    const { authorization } = req.headers;
    const token = authorization?.replace('Bearer ', '');

    const chaveSecreta = process.env.JWT_SECRET;

    if (!token) {
        return res.sendStatus(401);
    }

    try {
        const dados = jwt.verify(token, chaveSecreta);
        const findUser = await connection.query(`SELECT * FROM users WHERE email = $1;`, [dados.user]);
        const filterEmail = findUser.rows.map(item => item.email);

        if (!filterEmail[0]) {
            return res.sendStatus(401);
        }

        res.locals.user = findUser;
        res.locals.userEmail = filterEmail;
        next()
    } catch (error) {
        res.sendStatus(500);
    }
}