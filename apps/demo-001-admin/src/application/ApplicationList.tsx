import * as React from "react";
import { List, Datagrid, ListProps, TextField, DateField } from "react-admin";
import Pagination from "../Components/Pagination";

export const ApplicationList = (props: ListProps): React.ReactElement => {
  return (
    <List
      {...props}
      bulkActionButtons={false}
      title={"Applications"}
      perPage={50}
      pagination={<Pagination />}
    >
      <Datagrid rowClick="show">
        <TextField label="Categories" source="categories" />
        <DateField source="createdAt" label="Created At" />
        <TextField label="Dir Name" source="dirName" />
        <TextField label="ID" source="id" />
        <TextField label="Keys" source="keys" />
        <DateField source="updatedAt" label="Updated At" />
      </Datagrid>
    </List>
  );
};
