import Fastify from 'fastify';
import cors from '@fastify/cors';
import dotenv from 'dotenv';
import { transactionRoutes } from './routes/transactions';
import { categoryRoutes } from './routes/categories';
import { authRoutes } from './routes/auth';

dotenv.config();

const fastify = Fastify({
  logger: {
    level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
  },
});

// Register CORS
fastify.register(cors, {
  origin: true, // Allow all origins in dev
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
});

// Health check
fastify.get('/health', async () => {
  return { status: 'ok', timestamp: new Date().toISOString() };
});

// Register routes
fastify.register(authRoutes, { prefix: '/api/auth' });
fastify.register(transactionRoutes, { prefix: '/api/transactions' });
fastify.register(categoryRoutes, { prefix: '/api/categories' });

const PORT = parseInt(process.env.PORT || '3000', 10);
const HOST = process.env.HOST || '0.0.0.0';

fastify.listen({ port: PORT, host: HOST }, (err, address) => {
  if (err) {
    console.error(err);
    process.exit(1);
  }
  console.log(`🚀 Server running at ${address}`);
});
