/*
------------------------------------------------------------------------------ 
This code was generated by Amplication. 
 
Changes to this file will be lost if the code is regenerated. 

There are other ways to to customize your code, see this doc to learn more
https://docs.amplication.com/how-to/custom-code

------------------------------------------------------------------------------
  */
import { InputType, Field } from "@nestjs/graphql";
import { ApiProperty } from "@nestjs/swagger";
import { AppWhereUniqueInput } from "../../app/base/AppWhereUniqueInput";
import { ValidateNested, IsOptional, IsString } from "class-validator";
import { Type } from "class-transformer";
import { DestinationCalendarUpdateManyWithoutCredentialsInput } from "./DestinationCalendarUpdateManyWithoutCredentialsInput";
import { IsJSONValue } from "../../validators";
import { GraphQLJSON } from "graphql-type-json";
import { InputJsonValue } from "../../types";
import { UserWhereUniqueInput } from "../../user/base/UserWhereUniqueInput";

@InputType()
class CredentialUpdateInput {
  @ApiProperty({
    required: false,
    type: () => AppWhereUniqueInput,
  })
  @ValidateNested()
  @Type(() => AppWhereUniqueInput)
  @IsOptional()
  @Field(() => AppWhereUniqueInput, {
    nullable: true,
  })
  app?: AppWhereUniqueInput | null;

  @ApiProperty({
    required: false,
    type: () => DestinationCalendarUpdateManyWithoutCredentialsInput,
  })
  @ValidateNested()
  @Type(() => DestinationCalendarUpdateManyWithoutCredentialsInput)
  @IsOptional()
  @Field(() => DestinationCalendarUpdateManyWithoutCredentialsInput, {
    nullable: true,
  })
  destinationCalendars?: DestinationCalendarUpdateManyWithoutCredentialsInput;

  @ApiProperty({
    required: false,
  })
  @IsJSONValue()
  @IsOptional()
  @Field(() => GraphQLJSON, {
    nullable: true,
  })
  key?: InputJsonValue;

  @ApiProperty({
    required: false,
    type: String,
  })
  @IsString()
  @IsOptional()
  @Field(() => String, {
    nullable: true,
  })
  typeField?: string;

  @ApiProperty({
    required: false,
    type: () => UserWhereUniqueInput,
  })
  @ValidateNested()
  @Type(() => UserWhereUniqueInput)
  @IsOptional()
  @Field(() => UserWhereUniqueInput, {
    nullable: true,
  })
  user?: UserWhereUniqueInput | null;
}

export { CredentialUpdateInput as CredentialUpdateInput };
