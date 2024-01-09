-- CreateEnum
CREATE TYPE "EnumEventTypePeriodType" AS ENUM ('UNLIMITED', 'ROLLING', 'RANGE');

-- CreateEnum
CREATE TYPE "EnumEventTypeSchedulingType" AS ENUM ('ROUND_ROBIN', 'COLLECTIVE');

-- CreateEnum
CREATE TYPE "EnumUserIdentityProvider" AS ENUM ('CAL', 'GOOGLE', 'SAML');

-- CreateEnum
CREATE TYPE "EnumUserPlan" AS ENUM ('FREE', 'TRIAL', 'PRO');

-- CreateEnum
CREATE TYPE "EnumUserRole" AS ENUM ('USER', 'ADMIN');

-- CreateEnum
CREATE TYPE "EnumMembershipRole" AS ENUM ('MEMBER', 'ADMIN', 'OWNER');

-- CreateEnum
CREATE TYPE "EnumBookingStatus" AS ENUM ('CANCELLED', 'ACCEPTED', 'REJECTED', 'PENDING');

-- CreateEnum
CREATE TYPE "EnumEventTypeCustomInputType" AS ENUM ('TEXT', 'TEXTLONG', 'NUMBER', 'BOOL');

-- CreateEnum
CREATE TYPE "EnumReminderMailReminderType" AS ENUM ('PENDING_BOOKING_CONFIRMATION');

-- CreateEnum
CREATE TYPE "EnumPaymentType" AS ENUM ('STRIPE');

-- CreateEnum
CREATE TYPE "EnumWebhookEventTriggers" AS ENUM ('BOOKING_CREATED', 'BOOKING_RESCHEDULED', 'BOOKING_CANCELLED');

-- CreateEnum
CREATE TYPE "EnumAppCategories" AS ENUM ('calendar', 'messaging', 'other', 'payment', 'video', 'web3');

-- CreateEnum
CREATE TYPE "EnumWorkflowStepAction" AS ENUM ('EMAIL_HOST', 'EMAIL_ATTENDEE', 'SMS_ATTENDEE', 'SMS_NUMBER');

-- CreateEnum
CREATE TYPE "EnumWorkflowStepTemplate" AS ENUM ('REMINDER', 'CUSTOM');

-- CreateEnum
CREATE TYPE "EnumWorkflowTimeUnit" AS ENUM ('DAY', 'HOUR', 'MINUTE');

-- CreateEnum
CREATE TYPE "EnumWorkflowTrigger" AS ENUM ('BEFORE_EVENT', 'EVENT_CANCELLED', 'NEW_EVENT');

-- CreateEnum
CREATE TYPE "EnumWorkflowReminderMethod" AS ENUM ('EMAIL', 'SMS');

-- CreateTable
CREATE TABLE "EventType" (
    "afterEventBuffer" INTEGER NOT NULL DEFAULT 0,
    "beforeEventBuffer" INTEGER NOT NULL DEFAULT 0,
    "currency" TEXT NOT NULL DEFAULT 'usd',
    "description" TEXT,
    "disableGuests" BOOLEAN NOT NULL DEFAULT false,
    "eventName" TEXT,
    "hidden" BOOLEAN NOT NULL DEFAULT false,
    "hideCalendarNotes" BOOLEAN NOT NULL DEFAULT false,
    "id" SERIAL NOT NULL,
    "length" INTEGER NOT NULL,
    "locations" JSONB,
    "metadata" JSONB,
    "minimumBookingNotice" INTEGER NOT NULL DEFAULT 120,
    "periodCountCalendarDays" BOOLEAN,
    "periodDays" INTEGER,
    "periodEndDate" TIMESTAMP(3),
    "periodStartDate" TIMESTAMP(3),
    "periodType" "EnumEventTypePeriodType" NOT NULL DEFAULT 'UNLIMITED',
    "position" INTEGER NOT NULL DEFAULT 0,
    "price" INTEGER NOT NULL DEFAULT 0,
    "recurringEvent" JSONB,
    "requiresConfirmation" BOOLEAN NOT NULL DEFAULT false,
    "scheduleId" INTEGER,
    "schedulingType" "EnumEventTypeSchedulingType",
    "seatsPerTimeSlot" INTEGER,
    "slotInterval" INTEGER,
    "slug" TEXT NOT NULL,
    "successRedirectUrl" TEXT,
    "teamId" INTEGER,
    "timeZone" TEXT,
    "title" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "EventType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Credential" (
    "appId" TEXT,
    "id" SERIAL NOT NULL,
    "key" JSONB NOT NULL,
    "type" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Credential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DestinationCalendar" (
    "bookingId" INTEGER,
    "credentialId" INTEGER,
    "eventTypeId" INTEGER,
    "externalId" TEXT NOT NULL,
    "id" SERIAL NOT NULL,
    "integration" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "DestinationCalendar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "allowDynamicBooking" BOOLEAN DEFAULT true,
    "avatar" TEXT,
    "away" BOOLEAN NOT NULL DEFAULT false,
    "bio" TEXT,
    "brandColor" TEXT NOT NULL DEFAULT '#292929',
    "bufferTime" INTEGER NOT NULL DEFAULT 0,
    "completedOnboarding" BOOLEAN NOT NULL DEFAULT false,
    "created" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "darkBrandColor" TEXT NOT NULL DEFAULT '#fafafa',
    "defaultScheduleId" INTEGER,
    "disableImpersonation" BOOLEAN NOT NULL DEFAULT false,
    "email" TEXT NOT NULL,
    "emailVerified" TIMESTAMP(3),
    "endTime" INTEGER NOT NULL DEFAULT 1440,
    "hideBranding" BOOLEAN NOT NULL DEFAULT false,
    "id" SERIAL NOT NULL,
    "identityProvider" "EnumUserIdentityProvider" NOT NULL DEFAULT 'CAL',
    "identityProviderId" TEXT,
    "invitedTo" INTEGER,
    "locale" TEXT,
    "metadata" JSONB,
    "name" TEXT,
    "password" TEXT,
    "plan" "EnumUserPlan" NOT NULL DEFAULT 'TRIAL',
    "role" "EnumUserRole" NOT NULL DEFAULT 'USER',
    "startTime" INTEGER NOT NULL DEFAULT 0,
    "theme" TEXT,
    "timeFormat" INTEGER DEFAULT 12,
    "timeZone" TEXT NOT NULL DEFAULT 'Europe/London',
    "trialEndsAt" TIMESTAMP(3),
    "twoFactorEnabled" BOOLEAN NOT NULL DEFAULT false,
    "twoFactorSecret" TEXT,
    "username" TEXT,
    "verified" BOOLEAN DEFAULT false,
    "weekStart" TEXT NOT NULL DEFAULT 'Sunday',

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Team" (
    "bio" TEXT,
    "hideBranding" BOOLEAN NOT NULL DEFAULT false,
    "id" SERIAL NOT NULL,
    "logo" TEXT,
    "name" TEXT,
    "slug" TEXT,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Membership" (
    "accepted" BOOLEAN NOT NULL DEFAULT false,
    "id" SERIAL NOT NULL,
    "role" "EnumMembershipRole" NOT NULL,
    "teamId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Membership_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires" TIMESTAMP(3) NOT NULL,
    "id" SERIAL NOT NULL,
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VerificationToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BookingReference" (
    "bookingId" INTEGER,
    "deleted" BOOLEAN,
    "externalCalendarId" TEXT,
    "id" SERIAL NOT NULL,
    "meetingId" TEXT,
    "meetingPassword" TEXT,
    "meetingUrl" TEXT,
    "type" TEXT NOT NULL,
    "uid" TEXT NOT NULL,

    CONSTRAINT "BookingReference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attendee" (
    "bookingId" INTEGER,
    "email" TEXT NOT NULL,
    "id" SERIAL NOT NULL,
    "locale" TEXT DEFAULT 'en',
    "name" TEXT NOT NULL,
    "timeZone" TEXT NOT NULL,

    CONSTRAINT "Attendee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DailyEventReference" (
    "bookingId" INTEGER,
    "dailytoken" TEXT NOT NULL DEFAULT 'dailytoken',
    "dailyurl" TEXT NOT NULL DEFAULT 'dailycallurl',
    "id" SERIAL NOT NULL,

    CONSTRAINT "DailyEventReference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Booking" (
    "cancellationReason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "customInputs" JSONB,
    "description" TEXT,
    "dynamicEventSlugRef" TEXT,
    "dynamicGroupSlugRef" TEXT,
    "endTime" TIMESTAMP(3) NOT NULL,
    "eventTypeId" INTEGER,
    "fromReschedule" TEXT,
    "id" SERIAL NOT NULL,
    "location" TEXT,
    "paid" BOOLEAN NOT NULL DEFAULT false,
    "recurringEventId" TEXT,
    "rejectionReason" TEXT,
    "rescheduled" BOOLEAN,
    "smsReminderNumber" TEXT,
    "startTime" TIMESTAMP(3) NOT NULL,
    "status" "EnumBookingStatus" NOT NULL DEFAULT 'ACCEPTED',
    "title" TEXT NOT NULL,
    "uid" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3),
    "userId" INTEGER,

    CONSTRAINT "Booking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Schedule" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "timeZone" TEXT,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Schedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Availability" (
    "date" DATE,
    "days" INTEGER NOT NULL,
    "endTime" TIME NOT NULL,
    "eventTypeId" INTEGER,
    "id" SERIAL NOT NULL,
    "scheduleId" INTEGER,
    "startTime" TIME NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Availability_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SelectedCalendar" (
    "externalId" TEXT NOT NULL,
    "id" SERIAL NOT NULL,
    "integration" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "SelectedCalendar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EventTypeCustomInput" (
    "eventTypeId" INTEGER NOT NULL,
    "id" SERIAL NOT NULL,
    "label" TEXT NOT NULL,
    "placeholder" TEXT NOT NULL DEFAULT '',
    "required" BOOLEAN NOT NULL,
    "type" "EnumEventTypeCustomInputType" NOT NULL,

    CONSTRAINT "EventTypeCustomInput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ResetPasswordRequest" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,
    "id" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ResetPasswordRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReminderMail" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "elapsedMinutes" INTEGER NOT NULL,
    "id" SERIAL NOT NULL,
    "referenceId" INTEGER NOT NULL,
    "reminderType" "EnumReminderMailReminderType" NOT NULL,

    CONSTRAINT "ReminderMail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "amount" INTEGER NOT NULL,
    "bookingId" INTEGER,
    "currency" TEXT NOT NULL,
    "data" JSONB NOT NULL,
    "externalId" TEXT NOT NULL,
    "fee" INTEGER NOT NULL,
    "id" SERIAL NOT NULL,
    "refunded" BOOLEAN NOT NULL,
    "success" BOOLEAN NOT NULL,
    "type" "EnumPaymentType" NOT NULL,
    "uid" TEXT NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Webhook" (
    "active" BOOLEAN NOT NULL DEFAULT true,
    "appId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "eventTriggers" "EnumWebhookEventTriggers"[],
    "eventTypeId" INTEGER,
    "id" TEXT NOT NULL,
    "payloadTemplate" TEXT,
    "secret" TEXT,
    "subscriberUrl" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Webhook_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Impersonations" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "id" SERIAL NOT NULL,
    "impersonatedById" INTEGER NOT NULL,
    "impersonatedUserId" INTEGER NOT NULL,

    CONSTRAINT "Impersonations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApiKey" (
    "appId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "hashedKey" TEXT NOT NULL,
    "id" TEXT NOT NULL,
    "lastUsedAt" TIMESTAMP(3),
    "note" TEXT,
    "userId" INTEGER,

    CONSTRAINT "ApiKey_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HashedLink" (
    "eventTypeId" INTEGER NOT NULL,
    "id" SERIAL NOT NULL,
    "link" TEXT NOT NULL,

    CONSTRAINT "HashedLink_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "access_token" TEXT,
    "expires_at" INTEGER,
    "id" TEXT NOT NULL,
    "id_token" TEXT,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "scope" TEXT,
    "session_state" TEXT,
    "token_type" TEXT,
    "type" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "expires" TIMESTAMP(3) NOT NULL,
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "App" (
    "categories" "EnumAppCategories"[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dirName" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "keys" JSONB,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "App_pkey" PRIMARY KEY ("slug")
);

-- CreateTable
CREATE TABLE "Feedback" (
    "comment" TEXT,
    "date" TIMESTAMP(3) NOT NULL,
    "id" SERIAL NOT NULL,
    "rating" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Feedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkflowStep" (
    "action" "EnumWorkflowStepAction" NOT NULL,
    "emailSubject" TEXT,
    "id" SERIAL NOT NULL,
    "reminderBody" TEXT,
    "sendTo" TEXT,
    "stepNumber" INTEGER NOT NULL,
    "template" "EnumWorkflowStepTemplate" NOT NULL DEFAULT 'REMINDER',
    "workflowId" INTEGER NOT NULL,

    CONSTRAINT "WorkflowStep_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Workflow" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "time" INTEGER,
    "timeUnit" "EnumWorkflowTimeUnit",
    "trigger" "EnumWorkflowTrigger" NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Workflow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkflowsOnEventTypes" (
    "eventTypeId" INTEGER NOT NULL,
    "id" SERIAL NOT NULL,
    "workflowId" INTEGER NOT NULL,

    CONSTRAINT "WorkflowsOnEventTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WorkflowReminder" (
    "bookingUid" INTEGER,
    "id" SERIAL NOT NULL,
    "method" "EnumWorkflowReminderMethod" NOT NULL,
    "referenceId" TEXT,
    "scheduled" BOOLEAN NOT NULL,
    "scheduledDate" TIMESTAMP(3) NOT NULL,
    "workflowStepId" INTEGER NOT NULL,

    CONSTRAINT "WorkflowReminder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_EventTypeToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "EventType_userId_slug_key" ON "EventType"("userId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "EventType_teamId_slug_key" ON "EventType"("teamId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "DestinationCalendar_bookingId_key" ON "DestinationCalendar"("bookingId");

-- CreateIndex
CREATE UNIQUE INDEX "DestinationCalendar_eventTypeId_key" ON "DestinationCalendar"("eventTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "DestinationCalendar_userId_key" ON "DestinationCalendar"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Team_slug_key" ON "Team"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Membership_userId_teamId_key" ON "Membership"("userId", "teamId");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "VerificationToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON "VerificationToken"("identifier", "token");

-- CreateIndex
CREATE UNIQUE INDEX "DailyEventReference_bookingId_key" ON "DailyEventReference"("bookingId");

-- CreateIndex
CREATE UNIQUE INDEX "Booking_uid_key" ON "Booking"("uid");

-- CreateIndex
CREATE UNIQUE INDEX "SelectedCalendar_userId_integration_externalId_key" ON "SelectedCalendar"("userId", "integration", "externalId");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_externalId_key" ON "Payment"("externalId");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_uid_key" ON "Payment"("uid");

-- CreateIndex
CREATE UNIQUE INDEX "Webhook_id_key" ON "Webhook"("id");

-- CreateIndex
CREATE UNIQUE INDEX "ApiKey_hashedKey_key" ON "ApiKey"("hashedKey");

-- CreateIndex
CREATE UNIQUE INDEX "ApiKey_id_key" ON "ApiKey"("id");

-- CreateIndex
CREATE UNIQUE INDEX "HashedLink_eventTypeId_key" ON "HashedLink"("eventTypeId");

-- CreateIndex
CREATE UNIQUE INDEX "HashedLink_link_key" ON "HashedLink"("link");

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "App_dirName_key" ON "App"("dirName");

-- CreateIndex
CREATE UNIQUE INDEX "App_slug_key" ON "App"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "WorkflowReminder_referenceId_key" ON "WorkflowReminder"("referenceId");

-- CreateIndex
CREATE UNIQUE INDEX "_EventTypeToUser_AB_unique" ON "_EventTypeToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_EventTypeToUser_B_index" ON "_EventTypeToUser"("B");

-- AddForeignKey
ALTER TABLE "EventType" ADD CONSTRAINT "EventType_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "Schedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventType" ADD CONSTRAINT "EventType_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Credential" ADD CONSTRAINT "Credential_appId_fkey" FOREIGN KEY ("appId") REFERENCES "App"("slug") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Credential" ADD CONSTRAINT "Credential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "Credential"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DestinationCalendar" ADD CONSTRAINT "DestinationCalendar_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Membership" ADD CONSTRAINT "Membership_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Membership" ADD CONSTRAINT "Membership_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BookingReference" ADD CONSTRAINT "BookingReference_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attendee" ADD CONSTRAINT "Attendee_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DailyEventReference" ADD CONSTRAINT "DailyEventReference_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Schedule" ADD CONSTRAINT "Schedule_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "Schedule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Availability" ADD CONSTRAINT "Availability_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SelectedCalendar" ADD CONSTRAINT "SelectedCalendar_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EventTypeCustomInput" ADD CONSTRAINT "EventTypeCustomInput_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES "Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Webhook" ADD CONSTRAINT "Webhook_appId_fkey" FOREIGN KEY ("appId") REFERENCES "App"("slug") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Webhook" ADD CONSTRAINT "Webhook_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Webhook" ADD CONSTRAINT "Webhook_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Impersonations" ADD CONSTRAINT "Impersonations_impersonatedById_fkey" FOREIGN KEY ("impersonatedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Impersonations" ADD CONSTRAINT "Impersonations_impersonatedUserId_fkey" FOREIGN KEY ("impersonatedUserId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApiKey" ADD CONSTRAINT "ApiKey_appId_fkey" FOREIGN KEY ("appId") REFERENCES "App"("slug") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApiKey" ADD CONSTRAINT "ApiKey_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HashedLink" ADD CONSTRAINT "HashedLink_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkflowStep" ADD CONSTRAINT "WorkflowStep_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES "Workflow"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Workflow" ADD CONSTRAINT "Workflow_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkflowsOnEventTypes" ADD CONSTRAINT "WorkflowsOnEventTypes_eventTypeId_fkey" FOREIGN KEY ("eventTypeId") REFERENCES "EventType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkflowsOnEventTypes" ADD CONSTRAINT "WorkflowsOnEventTypes_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES "Workflow"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkflowReminder" ADD CONSTRAINT "WorkflowReminder_bookingUid_fkey" FOREIGN KEY ("bookingUid") REFERENCES "Booking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WorkflowReminder" ADD CONSTRAINT "WorkflowReminder_workflowStepId_fkey" FOREIGN KEY ("workflowStepId") REFERENCES "WorkflowStep"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventTypeToUser" ADD CONSTRAINT "_EventTypeToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "EventType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventTypeToUser" ADD CONSTRAINT "_EventTypeToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
