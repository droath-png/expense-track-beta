import { FastifyPluginAsync } from 'fastify';
import prisma from '../db';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { z } from 'zod';

const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret';

const registerSchema = z.object({
  email: z.string().email(),
  password: z.string().min(6),
});

const loginSchema = z.object({
  email: z.string().email(),
  password: z.string(),
});

export const authRoutes: FastifyPluginAsync = async (fastify) => {
  // Register
  fastify.post('/register', async (request, reply) => {
    const body = request.body as any;
    const validated = registerSchema.safeParse(body);

    if (!validated.success) {
      return reply.code(400).send({ error: 'Invalid input', details: validated.error.errors });
    }

    const existingUser = await prisma.user.findUnique({
      where: { email: validated.data.email },
    });

    if (existingUser) {
      return reply.code(409).send({ error: 'User already exists' });
    }

    const hashedPassword = await bcrypt.hash(validated.data.password, 10);

    const user = await prisma.user.create({
      data: {
        email: validated.data.email,
        password: hashedPassword,
      },
    });

    const token = jwt.sign(
      { userId: user.id, email: user.email },
      JWT_SECRET,
      { expiresIn: '7d' }
    );

    return { user: { id: user.id, email: user.email }, token };
  });

  // Login
  fastify.post('/login', async (request, reply) => {
    const body = request.body as any;
    const validated = loginSchema.safeParse(body);

    if (!validated.success) {
      return reply.code(400).send({ error: 'Invalid input', details: validated.error.errors });
    }

    const user = await prisma.user.findUnique({
      where: { email: validated.data.email },
    });

    if (!user) {
      return reply.code(401).send({ error: 'Invalid credentials' });
    }

    const validPassword = await bcrypt.compare(validated.data.password, user.password);

    if (!validPassword) {
      return reply.code(401).send({ error: 'Invalid credentials' });
    }

    const token = jwt.sign(
      { userId: user.id, email: user.email },
      JWT_SECRET,
      { expiresIn: '7d' }
    );

    return { user: { id: user.id, email: user.email }, token };
  });
};
