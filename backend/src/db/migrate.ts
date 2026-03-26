import { exec } from 'child_process';
import { promisify } from 'util';
import path from 'path';

const execAsync = promisify(exec);
const rootDir = path.resolve(__dirname, '../..');

async function migrate() {
  try {
    console.log('🔄 Running database migrations...');
    await execAsync('npx prisma migrate dev --name init', {
      cwd: rootDir,
    });
    console.log('✅ Migrations complete!');
    
    console.log('📦 Generating Prisma client...');
    await execAsync('npx prisma generate', {
      cwd: rootDir,
    });
    console.log('✅ Prisma client generated!');
  } catch (error: any) {
    console.error('❌ Migration failed:', error.message);
    process.exit(1);
  }
}

migrate();
