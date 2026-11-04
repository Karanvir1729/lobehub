ALTER TABLE "workspace_invitations" ALTER COLUMN "expires_at" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "workspace_invitations" ADD COLUMN IF NOT EXISTS "reusable" boolean DEFAULT false NOT NULL;--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "workspace_invitations_active_link_uidx" ON "workspace_invitations" USING btree ("workspace_id") WHERE "workspace_invitations"."reusable" = true AND "workspace_invitations"."status" = 'pending';
