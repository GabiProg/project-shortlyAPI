import { UserRanking, PublicRanking } from "../controllers/rankingsControllers.js";
import { AuthorizeUser } from "../middlewares/authorizeUser.js";
import { Router } from 'express';

const router = Router();

router.get('/users/me', AuthorizeUser, UserRanking);
router.get('/ranking', PublicRanking);

export default router;