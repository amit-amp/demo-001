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
import { AppWhereInput } from "./AppWhereInput";
import { ValidateNested, IsOptional } from "class-validator";
import { Type } from "class-transformer";

@InputType()
class AppListRelationFilter {
  @ApiProperty({
    required: false,
    type: () => AppWhereInput,
  })
  @ValidateNested()
  @Type(() => AppWhereInput)
  @IsOptional()
  @Field(() => AppWhereInput, {
    nullable: true,
  })
  every?: AppWhereInput;

  @ApiProperty({
    required: false,
    type: () => AppWhereInput,
  })
  @ValidateNested()
  @Type(() => AppWhereInput)
  @IsOptional()
  @Field(() => AppWhereInput, {
    nullable: true,
  })
  some?: AppWhereInput;

  @ApiProperty({
    required: false,
    type: () => AppWhereInput,
  })
  @ValidateNested()
  @Type(() => AppWhereInput)
  @IsOptional()
  @Field(() => AppWhereInput, {
    nullable: true,
  })
  none?: AppWhereInput;
}
export { AppListRelationFilter as AppListRelationFilter };
