import express from 'express';
import dotenv from 'dotenv';
import authRoutes from '../src/Routes/authRoutes.js';

dotenv.config();

const server = express();

server.use(express.json());

server.use(authRoutes);

server.listen(process.env.PORT, () => console.log('The server is current listening.'));