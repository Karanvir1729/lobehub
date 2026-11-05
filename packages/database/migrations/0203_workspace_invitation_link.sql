ALTER TABLE "workspace_invitations" ALTER COLUMN "expires_at" DROP NOT NULL;--> statement-breakpoint
ALTER TABLE "workspace_invitations" ADD COLUMN IF NOT EXISTS "reusable" boolean DEFAULT false NOT NULL;--> statement-breakpoint
CREATE UNIQUE INDEX IF NOT EXISTS "workspace_invitations_active_link_uidx" ON "workspace_invitations" USING btree ("workspace_id") WHERE "workspace_invitations"."reusable" = true AND "workspace_invitations"."status" = 'pending';--> statement-breakpoint
DO $$ BEGIN
  ALTER TABLE "workspace_invitations" ADD CONSTRAINT "workspace_invitations_expiry_required" CHECK ("workspace_invitations"."reusable" OR "workspace_invitations"."expires_at" IS NOT NULL);
EXCEPTION WHEN duplicate_object THEN NULL; END $$;
