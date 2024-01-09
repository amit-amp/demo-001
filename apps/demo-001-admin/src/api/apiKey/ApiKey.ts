import { Application } from "../application/Application";
import { User } from "../user/User";

export type ApiKey = {
  app?: Application | null;
  createdAt: Date;
  expiresAt: Date | null;
  hashedKey: string;
  id: string;
  lastUsedAt: Date | null;
  note: string | null;
  user?: User | null;
};
