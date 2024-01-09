import * as React from "react";

import {
  Edit,
  SimpleForm,
  EditProps,
  ReferenceInput,
  SelectInput,
  ReferenceArrayInput,
  SelectArrayInput,
  TextInput,
} from "react-admin";

import { AppTitle } from "../app/AppTitle";
import { DestinationCalendarTitle } from "../destinationCalendar/DestinationCalendarTitle";
import { UserTitle } from "../user/UserTitle";

export const CredentialEdit = (props: EditProps): React.ReactElement => {
  return (
    <Edit {...props}>
      <SimpleForm>
        <ReferenceInput source="app.id" reference="App" label="App">
          <SelectInput optionText={AppTitle} />
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
    </Edit>
  );
};
