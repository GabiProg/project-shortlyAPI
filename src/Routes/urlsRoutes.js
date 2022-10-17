import { shorten, SendShortUrl, AccessShortUrl, DeleteUrl } from "../controllers/urlsControllers.js";
import { AuthorizeUser } from "../middlewares/authorizeUser.js";
import { Router } from 'express';

const router = Router();

router.post('/urls/shorten', AuthorizeUser, shorten);
router.get('/urls/:id', SendShortUrl);
router.get('/urls/open/:shortUrl', AccessShortUrl);
router.delete('/urls/:id', AuthorizeUser, DeleteUrl)

export default router;