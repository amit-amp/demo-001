import { ApplicationWhereUniqueInput } from "../application/ApplicationWhereUniqueInput";
import { DestinationCalendarCreateNestedManyWithoutCredentialsInput } from "./DestinationCalendarCreateNestedManyWithoutCredentialsInput";
import { InputJsonValue } from "../../types";
import { UserWhereUniqueInput } from "../user/UserWhereUniqueInput";

export type CredentialCreateInput = {
  app?: ApplicationWhereUniqueInput | null;
  destinationCalendars?: DestinationCalendarCreateNestedManyWithoutCredentialsInput;
  key: InputJsonValue;
  typeField: string;
  user?: UserWhereUniqueInput | null;
};
