import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()
async function main() {
  const email = "julian"
  const user = await prisma.user.upsert({
    where: { email },
    create: { email },
    update: { email },
  })
}
main()
  .catch(e => {
    throw e
  })
  .finally(async () => {
    await prisma.$disconnect()
  })