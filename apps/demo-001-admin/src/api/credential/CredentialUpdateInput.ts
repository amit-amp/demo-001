import { ApplicationWhereUniqueInput } from "../application/ApplicationWhereUniqueInput";
import { DestinationCalendarUpdateManyWithoutCredentialsInput } from "./DestinationCalendarUpdateManyWithoutCredentialsInput";
import { InputJsonValue } from "../../types";
import { UserWhereUniqueInput } from "../user/UserWhereUniqueInput";

export type CredentialUpdateInput = {
  app?: ApplicationWhereUniqueInput | null;
  destinationCalendars?: DestinationCalendarUpdateManyWithoutCredentialsInput;
  key?: InputJsonValue;
  typeField?: string;
  user?: UserWhereUniqueInput | null;
};
