import connection from '../dataBase/database.js';

export async function UserRanking (req, res) {
    const findUser = res.locals.user;
    const filterEmail = res.locals.userEmail;

    try {
        const getUserInfo = await connection.query(`
            SELECT users.id, users.name FROM urls 
            JOIN users ON users.id = urls."userId"
            JOIN "shortUrls" ON "shortUrls"."urlId" = urls.id
            WHERE users.email = $1; 
        `, [filterEmail[0]]);

        const getUrlsSum = await connection.query(`
            SELECT SUM("shortUrls"."visitCount") AS "visitCount" FROM urls 
            JOIN users ON users.id = urls."userId"
            JOIN "shortUrls" ON "shortUrls"."urlId" = urls.id
            WHERE users.email = $1;
        `, [filterEmail[0]]);

        const findShortUrl = await connection.query(`
            SELECT "shortUrls".id, "shortUrl", url, "visitCount" FROM urls 
            JOIN "shortUrls" ON "shortUrls"."urlId"=urls.id
            JOIN users ON users.id = urls."userId" 
            WHERE users.email = $1;
        `, [filterEmail[0]]);

        res.status(200).send({
            ...getUserInfo.rows[0],
                ...getUrlsSum.rows[0],
                shortenedUrls: [
                    ...findShortUrl.rows
                ]
            });

    } catch (error) {
        res.sendStatus(500);
    }
}

export async function PublicRanking (req, res) {
    try {
        const getRanking =  await connection.query(`
            SELECT "userId" AS id, users.name, 
            COUNT(url) AS "linksCount", 
            SUM(COALESCE("shortUrls"."visitCount", 0)) AS "visitCount" FROM urls 
            JOIN users ON users.id=urls."userId" 
            LEFT JOIN "shortUrls" ON "shortUrls"."urlId"=urls.id 
            GROUP BY urls."userId", users.name
            ORDER BY "visitCount" DESC NULLS LAST
            LIMIT 10;
        `);

        res.status(200).send(getRanking.rows);
        
    } catch (error) {
        res.sendStatus(500);
        console.log(error.message);
    }
}