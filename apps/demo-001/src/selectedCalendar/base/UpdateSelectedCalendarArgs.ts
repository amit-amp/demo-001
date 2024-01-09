/*
------------------------------------------------------------------------------ 
This code was generated by Amplication. 
 
Changes to this file will be lost if the code is regenerated. 

There are other ways to to customize your code, see this doc to learn more
https://docs.amplication.com/how-to/custom-code

------------------------------------------------------------------------------
  */
import { ArgsType, Field } from "@nestjs/graphql";
import { ApiProperty } from "@nestjs/swagger";
import { SelectedCalendarWhereUniqueInput } from "./SelectedCalendarWhereUniqueInput";
import { ValidateNested } from "class-validator";
import { Type } from "class-transformer";
import { SelectedCalendarUpdateInput } from "./SelectedCalendarUpdateInput";

@ArgsType()
class UpdateSelectedCalendarArgs {
  @ApiProperty({
    required: true,
    type: () => SelectedCalendarWhereUniqueInput,
  })
  @ValidateNested()
  @Type(() => SelectedCalendarWhereUniqueInput)
  @Field(() => SelectedCalendarWhereUniqueInput, { nullable: false })
  where!: SelectedCalendarWhereUniqueInput;

  @ApiProperty({
    required: true,
    type: () => SelectedCalendarUpdateInput,
  })
  @ValidateNested()
  @Type(() => SelectedCalendarUpdateInput)
  @Field(() => SelectedCalendarUpdateInput, { nullable: false })
  data!: SelectedCalendarUpdateInput;
}

export { UpdateSelectedCalendarArgs as UpdateSelectedCalendarArgs };
