import * as React from "react";

import {
  Create,
  SimpleForm,
  CreateProps,
  ReferenceInput,
  SelectInput,
  ReferenceArrayInput,
  SelectArrayInput,
  TextInput,
} from "react-admin";

import { ApplicationTitle } from "../application/ApplicationTitle";
import { DestinationCalendarTitle } from "../destinationCalendar/DestinationCalendarTitle";
import { UserTitle } from "../user/UserTitle";

export const CredentialCreate = (props: CreateProps): React.ReactElement => {
  return (
    <Create {...props}>
      <SimpleForm>
        <ReferenceInput source="app.id" reference="Application" label="App">
          <SelectInput optionText={ApplicationTitle} />
        </ReferenceInput>
        <ReferenceArrayInput
          source="destinationCalendars"
          reference="DestinationCalendar"
          parse={(value: any) => value && value.map((v: any) => ({ id: v }))}
          format={(value: any) => value && value.map((v: any) => v.id)}
        >
          <SelectArrayInput optionText={DestinationCalendarTitle} />
        </ReferenceArrayInput>
        <div />
        <TextInput label="Type Field" source="typeField" />
        <ReferenceInput source="user.id" reference="User" label="User">
          <SelectInput optionText={UserTitle} />
        </ReferenceInput>
      </SimpleForm>
    </Create>
  );
};
