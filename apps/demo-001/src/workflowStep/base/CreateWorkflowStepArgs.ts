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
import { WorkflowStepCreateInput } from "./WorkflowStepCreateInput";
import { ValidateNested } from "class-validator";
import { Type } from "class-transformer";

@ArgsType()
class CreateWorkflowStepArgs {
  @ApiProperty({
    required: true,
    type: () => WorkflowStepCreateInput,
  })
  @ValidateNested()
  @Type(() => WorkflowStepCreateInput)
  @Field(() => WorkflowStepCreateInput, { nullable: false })
  data!: WorkflowStepCreateInput;
}

export { CreateWorkflowStepArgs as CreateWorkflowStepArgs };
