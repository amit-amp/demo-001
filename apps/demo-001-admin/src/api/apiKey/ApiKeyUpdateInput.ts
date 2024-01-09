import { ApplicationWhereUniqueInput } from "../application/ApplicationWhereUniqueInput";
import { UserWhereUniqueInput } from "../user/UserWhereUniqueInput";

export type ApiKeyUpdateInput = {
  app?: ApplicationWhereUniqueInput | null;
  expiresAt?: Date | null;
  hashedKey?: string;
  lastUsedAt?: Date | null;
  note?: string | null;
  user?: UserWhereUniqueInput | null;
};
