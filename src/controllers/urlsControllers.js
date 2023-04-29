import connection from "../dataBase/database.js";
import { nanoid } from 'nanoid';
import dotenv from 'dotenv';
dotenv.config();

export async function shorten (req, res) {
    const { url } = req.body;

    const findUser = res.locals.user;
    const filterEmail = res.locals.userEmail;

    const expression = 
    /^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$/;
    const regex = new RegExp(expression);

    if (!url || !url.match(regex)) {
        return res.status(422).send('Url não foi enviada ou está incorreta.');
    }

    const ID = nanoid(8);
    
    try {
        const alreadyCreatedUrl = await connection.query(`
            SELECT * FROM urls WHERE url = $1;
        `, [url]); 
        
        const validateUrl = alreadyCreatedUrl.rows.map(item => item.url);
        
        if (validateUrl[0]) {
            return res.status(401).send('link já foi encurtado.');
        }

        const filterId = findUser.rows.map(item => item.id);

        await connection.query(`
                INSERT INTO urls (url, "userId") VALUES ($1, $2);
        `, [url, filterId[0]]);

        const findUrl = await connection.query(`SELECT * FROM urls WHERE url = $1;`, [url]);
        
        const filterUrlId = findUrl.rows.map(item => item.id);

        await connection.query(`
            INSERT INTO "shortUrls" ("shortUrl", "urlId") VALUES ($1, $2);
        `, [ID, filterUrlId[0]]);

        const findShortUrl = await connection.query(`
            SELECT * FROM "shortUrls" WHERE "urlId" = $1;
        `, [filterUrlId[0]]);
        
        const filterShortUrlId = findShortUrl.rows.reverse().map(item => item.shortUrl);
        
        res.status(201).send({shortUrl: filterShortUrlId[0]});
    
    } catch (error) {
        console.log(error)
        res.sendStatus(500);
    }
}

export async function SendShortUrl (req, res) {
    const { id } = req.params;

    try {
        const findShortUrl = await connection.query(`
            SELECT "shortUrls".id, "shortUrl", url FROM "shortUrls" 
            JOIN urls ON "shortUrls"."urlId"=urls.id 
            WHERE "shortUrls".id = $1;
        `, [id]);

        const filterId = findShortUrl.rows.map(item => item.shortUrl);

        if (!filterId[0]) {
            return res.status(404).send('Link encurtado não existe.');
        }

        res.status(200).send(findShortUrl.rows);
    } catch (error) {
        res.sendStatus(500);
    }
}

export async function AccessShortUrl (req, res) {
    const { shortUrl } = req.params;

    try {
        const findShortUrl = await connection.query(`
            SELECT "shortUrl", url FROM "shortUrls" 
            JOIN urls ON "shortUrls"."urlId"=urls.id 
            WHERE "shortUrl" = $1;
        `, [shortUrl]);

        const filterId = findShortUrl.rows.map(item => item.shortUrl);

        if (!filterId[0]) {
            return res.status(404).send('Link encurtado não existe.');
        }

        const link = findShortUrl.rows.map(item => item.url);

        const getLine = await connection.query(`
            SELECT * FROM "shortUrls" WHERE "shortUrl" = $1;
        `, [shortUrl]);

        const getId = getLine.rows.map(item => item.id);
        
        await connection.query(`
            UPDATE "shortUrls" SET "visitCount" = "visitCount" + 1 WHERE id = $1;
        `, [getId[0]]);

        res.redirect(link[0]);
        
    } catch (error) {
        res.sendStatus(500);
    }
}

export async function DeleteUrl (req, res) {
    const findUser = res.locals.user;
    const filterEmail = res.locals.userEmail;

    const { id } = req.params;

    try {
       const findShortUrl = await connection.query(`
            SELECT * FROM "shortUrls" WHERE id = $1;
        `, [id]);

        const filterShortUrlId = findShortUrl.rows.map(item => item.id);

        if (!filterShortUrlId[0]) {
            return res.status(404).send('Url encurtada não encontrada.');
        }

        const filterId = findUser.rows.map(item => item.id);

        const matchId = await connection.query(`
            SELECT urls."userId", urls.id, "shortUrls"."urlId" FROM urls 
            JOIN "shortUrls" ON urls.id="shortUrls"."urlId" 
            WHERE "shortUrls".id = $1 AND urls."userId" = $2;
        `, [id, filterId[0]]);

        const filterUserId = matchId.rows.map(item => item.userId);
       
        if (!filterUserId[0]) {
            return res.status(401).send('Url encurtada não pertence ao usuário.');
        }

        const urlInfo = findShortUrl.rows.map(item => item.urlId);
        
        const getUrl = await connection.query(`
            SELECT * FROM urls WHERE id = $1;
        `, [urlInfo[0]]);
        
        const getUrlId = getUrl.rows.map(item => item.id);
       
        await connection.query(`
            DELETE FROM "shortUrls" WHERE id = $1;
        `, [id]);
        
        await connection.query(`
            DELETE FROM urls WHERE id = $1;
        `, [getUrlId[0]]);

        res.sendStatus(204);

    } catch (error) {
        res.sendStatus(500);
    }
}