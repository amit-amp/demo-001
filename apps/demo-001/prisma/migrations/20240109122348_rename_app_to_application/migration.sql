/*
  Warnings:

  - The `categories` column on the `App` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "EnumApplicationCategories" AS ENUM ('calendar', 'messaging', 'other', 'payment', 'video', 'web3');

-- AlterTable
ALTER TABLE "App" DROP COLUMN "categories",
ADD COLUMN     "categories" "EnumApplicationCategories"[];

-- DropEnum
DROP TYPE "EnumAppCategories";
