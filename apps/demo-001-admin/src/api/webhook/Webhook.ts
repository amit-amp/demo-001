import { Application } from "../application/Application";
import { EventType } from "../eventType/EventType";
import { User } from "../user/User";

export type Webhook = {
  active: boolean;
  app?: Application | null;
  createdAt: Date;
  eventTriggers?: Array<
    "BOOKING_CREATED" | "BOOKING_RESCHEDULED" | "BOOKING_CANCELLED"
  >;
  eventType?: EventType | null;
  id: string;
  payloadTemplate: string | null;
  secret: string | null;
  subscriberUrl: string;
  user?: User | null;
};
