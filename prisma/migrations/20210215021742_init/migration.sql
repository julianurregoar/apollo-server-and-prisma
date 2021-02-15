/*
  Warnings:

  - You are about to drop the column `userId` on the `Pet` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "Pet_userId_unique";

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Pet" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);
INSERT INTO "new_Pet" ("id", "name") SELECT "id", "name" FROM "Pet";
DROP TABLE "Pet";
ALTER TABLE "new_Pet" RENAME TO "Pet";
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "updateAt" DATETIME,
    "email" TEXT,
    "token" TEXT,
    "petId" INTEGER,
    FOREIGN KEY ("petId") REFERENCES "Pet" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("id", "createdAt", "updateAt", "email", "token") SELECT "id", "createdAt", "updateAt", "email", "token" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
CREATE UNIQUE INDEX "User.petId_unique" ON "User"("petId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
