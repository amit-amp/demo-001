import { ApiKeyCreateNestedManyWithoutApplicationsInput } from "./ApiKeyCreateNestedManyWithoutApplicationsInput";
import { CredentialCreateNestedManyWithoutApplicationsInput } from "./CredentialCreateNestedManyWithoutApplicationsInput";
import { InputJsonValue } from "../../types";
import { WebhookCreateNestedManyWithoutApplicationsInput } from "./WebhookCreateNestedManyWithoutApplicationsInput";

export type ApplicationCreateInput = {
  apiKey?: ApiKeyCreateNestedManyWithoutApplicationsInput;
  categories?: Array<
    "calendar" | "messaging" | "other" | "payment" | "video" | "web3"
  >;
  credentials?: CredentialCreateNestedManyWithoutApplicationsInput;
  dirName: string;
  keys?: InputJsonValue;
  webhook?: WebhookCreateNestedManyWithoutApplicationsInput;
};
