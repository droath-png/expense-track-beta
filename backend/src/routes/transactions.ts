import { FastifyPluginAsync } from 'fastify';
import prisma from '../db';
import { authenticate, AuthenticatedRequest } from '../middleware/auth';
import { z } from 'zod';

const createTransactionSchema = z.object({
  type: z.enum(['Income', 'Expense']),
  amount: z.number().positive(),
  category: z.string(),
  description: z.string().optional(),
  date: z.string(),
  time: z.string(),
});

export const transactionRoutes: FastifyPluginAsync = async (fastify) => {
  // Get all transactions for user
  fastify.get('/', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const transactions = await prisma.transaction.findMany({
      where: { userId: request.user.userId },
      orderBy: [{ date: 'desc' }, { time: 'desc' }],
    });

    return { transactions };
  });

  // Get single transaction
  fastify.get('/:id', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const transaction = await prisma.transaction.findFirst({
      where: {
        id: request.params.id,
        userId: request.user.userId,
      },
    });

    if (!transaction) {
      return reply.code(404).send({ error: 'Transaction not found' });
    }

    return { transaction };
  });

  // Create transaction
  fastify.post('/', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const body = request.body as any;
    const validated = createTransactionSchema.safeParse(body);

    if (!validated.success) {
      return reply.code(400).send({ error: 'Invalid input', details: validated.error.errors });
    }

    const transaction = await prisma.transaction.create({
      data: {
        ...validated.data,
        userId: request.user.userId,
      },
    });

    return { transaction };
  });

  // Update transaction
  fastify.put('/:id', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const body = request.body as any;
    const validated = createTransactionSchema.partial().safeParse(body);

    if (!validated.success) {
      return reply.code(400).send({ error: 'Invalid input', details: validated.error.errors });
    }

    const existing = await prisma.transaction.findFirst({
      where: { id: request.params.id, userId: request.user.userId },
    });

    if (!existing) {
      return reply.code(404).send({ error: 'Transaction not found' });
    }

    const transaction = await prisma.transaction.update({
      where: { id: request.params.id },
      data: validated.data,
    });

    return { transaction };
  });

  // Delete transaction
  fastify.delete('/:id', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const existing = await prisma.transaction.findFirst({
      where: { id: request.params.id, userId: request.user.userId },
    });

    if (!existing) {
      return reply.code(404).send({ error: 'Transaction not found' });
    }

    await prisma.transaction.delete({
      where: { id: request.params.id },
    });

    return { success: true };
  });

  // Delete all transactions
  fastify.delete('/', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    await prisma.transaction.deleteMany({
      where: { userId: request.user.userId },
    });

    return { success: true };
  });
};
