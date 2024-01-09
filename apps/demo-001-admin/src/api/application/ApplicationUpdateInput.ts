import { ApiKeyUpdateManyWithoutApplicationsInput } from "./ApiKeyUpdateManyWithoutApplicationsInput";
import { CredentialUpdateManyWithoutApplicationsInput } from "./CredentialUpdateManyWithoutApplicationsInput";
import { InputJsonValue } from "../../types";
import { WebhookUpdateManyWithoutApplicationsInput } from "./WebhookUpdateManyWithoutApplicationsInput";

export type ApplicationUpdateInput = {
  apiKey?: ApiKeyUpdateManyWithoutApplicationsInput;
  categories?: Array<
    "calendar" | "messaging" | "other" | "payment" | "video" | "web3"
  >;
  credentials?: CredentialUpdateManyWithoutApplicationsInput;
  dirName?: string;
  keys?: InputJsonValue;
  webhook?: WebhookUpdateManyWithoutApplicationsInput;
};
