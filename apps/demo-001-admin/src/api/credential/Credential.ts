import { Application } from "../application/Application";
import { DestinationCalendar } from "../destinationCalendar/DestinationCalendar";
import { JsonValue } from "type-fest";
import { User } from "../user/User";

export type Credential = {
  app?: Application | null;
  destinationCalendars?: Array<DestinationCalendar>;
  id: number;
  key: JsonValue;
  typeField: string;
  user?: User | null;
};
