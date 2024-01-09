import * as React from "react";

import {
  Edit,
  SimpleForm,
  EditProps,
  ReferenceInput,
  SelectInput,
  DateTimeInput,
  TextInput,
} from "react-admin";

import { ApplicationTitle } from "../application/ApplicationTitle";
import { UserTitle } from "../user/UserTitle";

export const ApiKeyEdit = (props: EditProps): React.ReactElement => {
  return (
    <Edit {...props}>
      <SimpleForm>
        <ReferenceInput source="app.id" reference="Application" label="App">
          <SelectInput optionText={ApplicationTitle} />
        </ReferenceInput>
        <DateTimeInput label="Expires At" source="expiresAt" />
        <TextInput label="Hashed Key" source="hashedKey" />
        <DateTimeInput label="Last Used At" source="lastUsedAt" />
        <TextInput label="Note" source="note" />
        <ReferenceInput source="user.id" reference="User" label="User">
          <SelectInput optionText={UserTitle} />
        </ReferenceInput>
      </SimpleForm>
    </Edit>
  );
};
