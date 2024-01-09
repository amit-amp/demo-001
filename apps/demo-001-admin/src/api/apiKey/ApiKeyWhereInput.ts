import { ApplicationWhereUniqueInput } from "../application/ApplicationWhereUniqueInput";
import { DateTimeFilter } from "../../util/DateTimeFilter";
import { DateTimeNullableFilter } from "../../util/DateTimeNullableFilter";
import { StringFilter } from "../../util/StringFilter";
import { StringNullableFilter } from "../../util/StringNullableFilter";
import { UserWhereUniqueInput } from "../user/UserWhereUniqueInput";

export type ApiKeyWhereInput = {
  app?: ApplicationWhereUniqueInput;
  createdAt?: DateTimeFilter;
  expiresAt?: DateTimeNullableFilter;
  hashedKey?: StringFilter;
  id?: StringFilter;
  lastUsedAt?: DateTimeNullableFilter;
  note?: StringNullableFilter;
  user?: UserWhereUniqueInput;
};
