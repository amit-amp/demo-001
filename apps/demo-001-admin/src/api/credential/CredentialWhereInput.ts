import { ApplicationWhereUniqueInput } from "../application/ApplicationWhereUniqueInput";
import { DestinationCalendarListRelationFilter } from "../destinationCalendar/DestinationCalendarListRelationFilter";
import { IntFilter } from "../../util/IntFilter";
import { JsonFilter } from "../../util/JsonFilter";
import { StringFilter } from "../../util/StringFilter";
import { UserWhereUniqueInput } from "../user/UserWhereUniqueInput";

export type CredentialWhereInput = {
  app?: ApplicationWhereUniqueInput;
  destinationCalendars?: DestinationCalendarListRelationFilter;
  id?: IntFilter;
  key?: JsonFilter;
  typeField?: StringFilter;
  user?: UserWhereUniqueInput;
};
