import { Application as TApplication } from "../api/application/Application";

export const APPLICATION_TITLE_FIELD = "dirName";

export const ApplicationTitle = (record: TApplication): string => {
  return record.dirName?.toString() || String(record.id);
};
