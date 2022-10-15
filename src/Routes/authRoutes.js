import { SingUp, SingIn } from "../controllers/authController.js";
import { Router } from 'express';

const router = Router();

router.post('/signup', SingUp);
router.post('/signin', SingIn);

export default router;