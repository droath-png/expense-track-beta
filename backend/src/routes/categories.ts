import { FastifyPluginAsync } from 'fastify';
import prisma from '../db';
import { authenticate, AuthenticatedRequest } from '../middleware/auth';
import { z } from 'zod';

const createCategorySchema = z.object({
  name: z.string(),
  type: z.enum(['Income', 'Expense']),
  iconCodePoint: z.number(),
  iconFontFamily: z.string(),
  color: z.string().optional(),
});

export const categoryRoutes: FastifyPluginAsync = async (fastify) => {
  // Get all categories for user
  fastify.get('/', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const categories = await prisma.category.findMany({
      where: { userId: request.user.userId },
      orderBy: { name: 'asc' },
    });

    return { categories };
  });

  // Create category
  fastify.post('/', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const body = request.body as any;
    const validated = createCategorySchema.safeParse(body);

    if (!validated.success) {
      return reply.code(400).send({ error: 'Invalid input', details: validated.error.errors });
    }

    try {
      const category = await prisma.category.create({
        data: {
          ...validated.data,
          userId: request.user.userId,
        },
      });
      return { category };
    } catch (error: any) {
      if (error.code === 'P2002') {
        return reply.code(409).send({ error: 'Category already exists' });
      }
      throw error;
    }
  });

  // Update category
  fastify.put('/:id', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const body = request.body as any;
    const validated = createCategorySchema.partial().safeParse(body);

    if (!validated.success) {
      return reply.code(400).send({ error: 'Invalid input', details: validated.error.errors });
    }

    const existing = await prisma.category.findFirst({
      where: { id: request.params.id, userId: request.user.userId },
    });

    if (!existing) {
      return reply.code(404).send({ error: 'Category not found' });
    }

    const category = await prisma.category.update({
      where: { id: request.params.id },
      data: validated.data,
    });

    return { category };
  });

  // Delete category
  fastify.delete('/:id', { preHandler: [authenticate] }, async (request: AuthenticatedRequest, reply) => {
    if (!request.user) {
      return reply.code(401).send({ error: 'Unauthorized' });
    }

    const existing = await prisma.category.findFirst({
      where: { id: request.params.id, userId: request.user.userId },
    });

    if (!existing) {
      return reply.code(404).send({ error: 'Category not found' });
    }

    await prisma.category.delete({
      where: { id: request.params.id },
    });

    return { success: true };
  });
};
