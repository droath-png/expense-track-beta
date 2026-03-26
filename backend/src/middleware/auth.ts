import { FastifyRequest, FastifyReply } from 'fastify';
import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret';

export interface AuthenticatedRequest extends FastifyRequest {
  user?: {
    userId: string;
    email: string;
  };
}

export async function authenticate(
  request: AuthenticatedRequest,
  reply: FastifyReply
) {
  try {
    const authHeader = request.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      reply.code(401).send({ error: 'Missing or invalid authorization header' });
      return;
    }

    const token = authHeader.substring(7);
    const decoded = jwt.verify(token, JWT_SECRET) as { userId: string; email: string };
    
    request.user = decoded;
  } catch (error) {
    reply.code(401).send({ error: 'Invalid or expired token' });
  }
}
