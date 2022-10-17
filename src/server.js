import express from 'express';
import dotenv from 'dotenv';
import authRoutes from '../src/Routes/authRoutes.js';
import urlsRoutes from '../src/Routes/urlsRoutes.js';

dotenv.config();

const server = express();

server.use(express.json());

server.use(authRoutes);
server.use(urlsRoutes);

server.listen(process.env.PORT, () => console.log('The server is current listening.'));