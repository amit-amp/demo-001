/*
------------------------------------------------------------------------------ 
This code was generated by Amplication. 
 
Changes to this file will be lost if the code is regenerated. 

There are other ways to to customize your code, see this doc to learn more
https://docs.amplication.com/how-to/custom-code

------------------------------------------------------------------------------
  */
import * as common from "@nestjs/common";
import * as swagger from "@nestjs/swagger";
import { isRecordNotFoundError } from "../../prisma.util";
import * as errors from "../../errors";
import { Request } from "express";
import { plainToClass } from "class-transformer";
import { ApiNestedQuery } from "../../decorators/api-nested-query.decorator";
import { ApplicationService } from "../application.service";
import { ApplicationCreateInput } from "./ApplicationCreateInput";
import { Application } from "./Application";
import { ApplicationFindManyArgs } from "./ApplicationFindManyArgs";
import { ApplicationWhereUniqueInput } from "./ApplicationWhereUniqueInput";
import { ApplicationUpdateInput } from "./ApplicationUpdateInput";
import { ApiKeyFindManyArgs } from "../../apiKey/base/ApiKeyFindManyArgs";
import { ApiKey } from "../../apiKey/base/ApiKey";
import { ApiKeyWhereUniqueInput } from "../../apiKey/base/ApiKeyWhereUniqueInput";
import { CredentialFindManyArgs } from "../../credential/base/CredentialFindManyArgs";
import { Credential } from "../../credential/base/Credential";
import { CredentialWhereUniqueInput } from "../../credential/base/CredentialWhereUniqueInput";
import { WebhookFindManyArgs } from "../../webhook/base/WebhookFindManyArgs";
import { Webhook } from "../../webhook/base/Webhook";
import { WebhookWhereUniqueInput } from "../../webhook/base/WebhookWhereUniqueInput";

export class ApplicationControllerBase {
  constructor(protected readonly service: ApplicationService) {}
  @common.Post()
  @swagger.ApiCreatedResponse({ type: Application })
  async createApplication(
    @common.Body() data: ApplicationCreateInput
  ): Promise<Application> {
    return await this.service.createApplication({
      data: data,
      select: {
        categories: true,
        createdAt: true,
        dirName: true,
        id: true,
        keys: true,
        updatedAt: true,
      },
    });
  }

  @common.Get()
  @swagger.ApiOkResponse({ type: [Application] })
  @ApiNestedQuery(ApplicationFindManyArgs)
  async applications(@common.Req() request: Request): Promise<Application[]> {
    const args = plainToClass(ApplicationFindManyArgs, request.query);
    return this.service.applications({
      ...args,
      select: {
        categories: true,
        createdAt: true,
        dirName: true,
        id: true,
        keys: true,
        updatedAt: true,
      },
    });
  }

  @common.Get("/:id")
  @swagger.ApiOkResponse({ type: Application })
  @swagger.ApiNotFoundResponse({ type: errors.NotFoundException })
  async application(
    @common.Param() params: ApplicationWhereUniqueInput
  ): Promise<Application | null> {
    const result = await this.service.application({
      where: params,
      select: {
        categories: true,
        createdAt: true,
        dirName: true,
        id: true,
        keys: true,
        updatedAt: true,
      },
    });
    if (result === null) {
      throw new errors.NotFoundException(
        `No resource was found for ${JSON.stringify(params)}`
      );
    }
    return result;
  }

  @common.Patch("/:id")
  @swagger.ApiOkResponse({ type: Application })
  @swagger.ApiNotFoundResponse({ type: errors.NotFoundException })
  async updateApplication(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() data: ApplicationUpdateInput
  ): Promise<Application | null> {
    try {
      return await this.service.updateApplication({
        where: params,
        data: data,
        select: {
          categories: true,
          createdAt: true,
          dirName: true,
          id: true,
          keys: true,
          updatedAt: true,
        },
      });
    } catch (error) {
      if (isRecordNotFoundError(error)) {
        throw new errors.NotFoundException(
          `No resource was found for ${JSON.stringify(params)}`
        );
      }
      throw error;
    }
  }

  @common.Delete("/:id")
  @swagger.ApiOkResponse({ type: Application })
  @swagger.ApiNotFoundResponse({ type: errors.NotFoundException })
  async deleteApplication(
    @common.Param() params: ApplicationWhereUniqueInput
  ): Promise<Application | null> {
    try {
      return await this.service.deleteApplication({
        where: params,
        select: {
          categories: true,
          createdAt: true,
          dirName: true,
          id: true,
          keys: true,
          updatedAt: true,
        },
      });
    } catch (error) {
      if (isRecordNotFoundError(error)) {
        throw new errors.NotFoundException(
          `No resource was found for ${JSON.stringify(params)}`
        );
      }
      throw error;
    }
  }

  @common.Get("/:id/apiKey")
  @ApiNestedQuery(ApiKeyFindManyArgs)
  async findApiKey(
    @common.Req() request: Request,
    @common.Param() params: ApplicationWhereUniqueInput
  ): Promise<ApiKey[]> {
    const query = plainToClass(ApiKeyFindManyArgs, request.query);
    const results = await this.service.findApiKey(params.id, {
      ...query,
      select: {
        app: {
          select: {
            id: true,
          },
        },

        createdAt: true,
        expiresAt: true,
        hashedKey: true,
        id: true,
        lastUsedAt: true,
        note: true,

        user: {
          select: {
            id: true,
          },
        },
      },
    });
    if (results === null) {
      throw new errors.NotFoundException(
        `No resource was found for ${JSON.stringify(params)}`
      );
    }
    return results;
  }

  @common.Post("/:id/apiKey")
  async connectApiKey(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: ApiKeyWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      apiKey: {
        connect: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Patch("/:id/apiKey")
  async updateApiKey(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: ApiKeyWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      apiKey: {
        set: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Delete("/:id/apiKey")
  async disconnectApiKey(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: ApiKeyWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      apiKey: {
        disconnect: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Get("/:id/credentials")
  @ApiNestedQuery(CredentialFindManyArgs)
  async findCredentials(
    @common.Req() request: Request,
    @common.Param() params: ApplicationWhereUniqueInput
  ): Promise<Credential[]> {
    const query = plainToClass(CredentialFindManyArgs, request.query);
    const results = await this.service.findCredentials(params.id, {
      ...query,
      select: {
        app: {
          select: {
            id: true,
          },
        },

        id: true,
        key: true,
        typeField: true,

        user: {
          select: {
            id: true,
          },
        },
      },
    });
    if (results === null) {
      throw new errors.NotFoundException(
        `No resource was found for ${JSON.stringify(params)}`
      );
    }
    return results;
  }

  @common.Post("/:id/credentials")
  async connectCredentials(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: CredentialWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      credentials: {
        connect: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Patch("/:id/credentials")
  async updateCredentials(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: CredentialWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      credentials: {
        set: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Delete("/:id/credentials")
  async disconnectCredentials(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: CredentialWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      credentials: {
        disconnect: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Get("/:id/webhook")
  @ApiNestedQuery(WebhookFindManyArgs)
  async findWebhook(
    @common.Req() request: Request,
    @common.Param() params: ApplicationWhereUniqueInput
  ): Promise<Webhook[]> {
    const query = plainToClass(WebhookFindManyArgs, request.query);
    const results = await this.service.findWebhook(params.id, {
      ...query,
      select: {
        active: true,

        app: {
          select: {
            id: true,
          },
        },

        createdAt: true,
        eventTriggers: true,

        eventType: {
          select: {
            id: true,
          },
        },

        id: true,
        payloadTemplate: true,
        secret: true,
        subscriberUrl: true,

        user: {
          select: {
            id: true,
          },
        },
      },
    });
    if (results === null) {
      throw new errors.NotFoundException(
        `No resource was found for ${JSON.stringify(params)}`
      );
    }
    return results;
  }

  @common.Post("/:id/webhook")
  async connectWebhook(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: WebhookWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      webhook: {
        connect: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Patch("/:id/webhook")
  async updateWebhook(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: WebhookWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      webhook: {
        set: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }

  @common.Delete("/:id/webhook")
  async disconnectWebhook(
    @common.Param() params: ApplicationWhereUniqueInput,
    @common.Body() body: WebhookWhereUniqueInput[]
  ): Promise<void> {
    const data = {
      webhook: {
        disconnect: body,
      },
    };
    await this.service.updateApplication({
      where: params,
      data,
      select: { id: true },
    });
  }
}
