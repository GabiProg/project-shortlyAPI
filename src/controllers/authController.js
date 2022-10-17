import connection from '../dataBase/database.js';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import dotenv from 'dotenv';
import joi from 'joi';

dotenv.config();

export async function SingUp (req, res) {
    const { name, email, password, confirmPassword } = req.body;

    const userSchema = joi.object({
        name: joi.string().required(),
        email: joi.string().email().required(),
        password: joi.string().min(6).required(),
        confirmPassword: joi.string().min(6).required()
    });

    const validation = userSchema.validate(req.body, {abortEarly: false});

    if (validation.error) {
        const erros = validation.error.details.map(detail => detail.message);
        res.status(422).send(erros);
        return;
    }

    const cryptoPassword = bcrypt.hashSync(password, 10);
    const cryptoConfirmPassword = bcrypt.hashSync(confirmPassword, 10);

    if (password !== confirmPassword) {
        return res.status(422).send('Por favor, confirme a senha corretamente.');
    }

    try {
        const alreadyUsed = await connection.query('SELECT * FROM users WHERE email = $1', [email]);
        const displayEmail = alreadyUsed.rows.map(item => item.email);
        if (displayEmail[0] === email) {
            res.status(409).send('O e-mail já está cadastrado.');
            return;
        }

        await connection.query(`
            INSERT INTO users (name, email, password, "confirmPassword") VALUES ($1, $2, $3, $4);
        `, [name, email, cryptoPassword, cryptoConfirmPassword]);
        
        res.status(201).send('Usuário cadastrado.');

    } catch (error) {
        res.sendStatus(500);
    }
}

export async function SingIn (req, res) {
    const { email, password } = req.body;

    const loginSchema = joi.object({
        email: joi.string().email().required(),
        password: joi.string().min(6).required()
    });

    const validation = loginSchema.validate(req.body, {abortEarly: false});

    if (validation.error) {
        const erros = validation.error.details.map(detail => detail.message);
        res.status(422).send(erros);
        return;
    }

    const chaveSecreta = process.env.JWT_SECRET;
    const dados = {user: email};
    
    try {
        const findUser = await connection.query(`SELECT * FROM users WHERE email = $1;`, [email]);
        const filterUser = findUser.rows.map(item => item.email);
        const filterId = findUser.rows.map(item => item.id);
        
        const token = jwt.sign(dados, chaveSecreta, { expiresIn: 60*60*24*30 });
        
        const filterPassword = findUser.rows.map(item => item.password);
        
        if (filterUser[0] && bcrypt.compareSync(password, filterPassword[0])) {
            await connection.query(
                `INSERT INTO sessions (token, "userId") VALUES ($1, $2);
            `, [token, filterId[0]]);
            res.status(200).send({token});
        } else {
            res.status(401).send('Senha ou email incorretos.');
        }
    } catch (error) {
        res.sendStatus(500);
    }    
}