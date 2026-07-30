-- CreateEnum
CREATE TYPE "DiagramType" AS ENUM ('DATABASE', 'ARCHITECTURE', 'SEQUENCE', 'CLASS', 'FLOW');

-- CreateEnum
CREATE TYPE "WorkspaceRole" AS ENUM ('OWNER', 'ADMIN', 'EDITOR', 'VIEWER');

-- CreateEnum
CREATE TYPE "SharePermission" AS ENUM ('VIEW', 'COMMENT');

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "avatar_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "organisations" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "organisations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workspaces" (
    "id" UUID NOT NULL,
    "org_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "workspaces_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workspace_members" (
    "workspace_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "role" "WorkspaceRole" NOT NULL,
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "workspace_members_pkey" PRIMARY KEY ("workspace_id","user_id")
);

-- CreateTable
CREATE TABLE "diagrams" (
    "id" UUID NOT NULL,
    "workspace_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "type" "DiagramType" NOT NULL,
    "content" JSONB NOT NULL,
    "syntax" TEXT,
    "created_by" UUID NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "diagrams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diagram_versions" (
    "id" UUID NOT NULL,
    "diagram_id" UUID NOT NULL,
    "version" INTEGER NOT NULL,
    "snapshot" JSONB NOT NULL,
    "author_id" UUID NOT NULL,
    "message" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "diagram_versions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "share_links" (
    "id" UUID NOT NULL,
    "diagram_id" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "permission" "SharePermission" NOT NULL,
    "password_hash" TEXT,
    "expires_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "share_links_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diagram_components" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "position_x" DOUBLE PRECISION NOT NULL,
    "position_y" DOUBLE PRECISION NOT NULL,
    "width" DOUBLE PRECISION NOT NULL,
    "height" DOUBLE PRECISION NOT NULL,
    "data" JSONB NOT NULL,
    "ports" JSONB NOT NULL,

    CONSTRAINT "diagram_components_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "database_table_components" (
    "id" TEXT NOT NULL,
    "table_name" TEXT NOT NULL,
    "columns" JSONB NOT NULL,
    "indices" JSONB NOT NULL,
    "constraints" JSONB NOT NULL,

    CONSTRAINT "database_table_components_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "service_components" (
    "id" TEXT NOT NULL,
    "service_name" TEXT NOT NULL,
    "framework" TEXT NOT NULL,
    "port" INTEGER NOT NULL,
    "endpoints" JSONB NOT NULL,
    "dependencies" JSONB NOT NULL,

    CONSTRAINT "service_components_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "connections" (
    "id" TEXT NOT NULL,
    "connection_type" TEXT NOT NULL,
    "source_component_id" TEXT NOT NULL,
    "source_port_id" TEXT NOT NULL,
    "target_component_id" TEXT NOT NULL,
    "target_port_id" TEXT NOT NULL,
    "label" TEXT,
    "multiplicity" JSONB,
    "direction" TEXT,
    "style" TEXT,

    CONSTRAINT "connections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "collaboration_rooms" (
    "diagram_id" UUID NOT NULL,
    "y_doc" JSONB NOT NULL,
    "user_presence" JSONB NOT NULL,
    "sync_state" TEXT NOT NULL,

    CONSTRAINT "collaboration_rooms_pkey" PRIMARY KEY ("diagram_id")
);

-- CreateTable
CREATE TABLE "websocket_events" (
    "id" TEXT NOT NULL,
    "room_id" UUID NOT NULL,
    "event_type" TEXT NOT NULL,
    "payload" JSONB NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "websocket_events_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "organisations_slug_key" ON "organisations"("slug");

-- CreateIndex
CREATE INDEX "workspaces_org_id_idx" ON "workspaces"("org_id");

-- CreateIndex
CREATE INDEX "workspace_members_user_id_idx" ON "workspace_members"("user_id");

-- CreateIndex
CREATE INDEX "diagrams_workspace_id_idx" ON "diagrams"("workspace_id");

-- CreateIndex
CREATE INDEX "diagrams_created_by_idx" ON "diagrams"("created_by");

-- CreateIndex
CREATE INDEX "diagram_versions_diagram_id_idx" ON "diagram_versions"("diagram_id");

-- CreateIndex
CREATE INDEX "diagram_versions_author_id_idx" ON "diagram_versions"("author_id");

-- CreateIndex
CREATE UNIQUE INDEX "diagram_versions_diagram_id_version_key" ON "diagram_versions"("diagram_id", "version");

-- CreateIndex
CREATE UNIQUE INDEX "share_links_token_key" ON "share_links"("token");

-- CreateIndex
CREATE INDEX "share_links_diagram_id_idx" ON "share_links"("diagram_id");

-- CreateIndex
CREATE INDEX "connections_source_component_id_idx" ON "connections"("source_component_id");

-- CreateIndex
CREATE INDEX "connections_target_component_id_idx" ON "connections"("target_component_id");

-- CreateIndex
CREATE INDEX "websocket_events_room_id_idx" ON "websocket_events"("room_id");

-- AddForeignKey
ALTER TABLE "workspaces" ADD CONSTRAINT "workspaces_org_id_fkey" FOREIGN KEY ("org_id") REFERENCES "organisations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workspace_members" ADD CONSTRAINT "workspace_members_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspaces"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workspace_members" ADD CONSTRAINT "workspace_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diagrams" ADD CONSTRAINT "diagrams_workspace_id_fkey" FOREIGN KEY ("workspace_id") REFERENCES "workspaces"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diagrams" ADD CONSTRAINT "diagrams_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diagram_versions" ADD CONSTRAINT "diagram_versions_diagram_id_fkey" FOREIGN KEY ("diagram_id") REFERENCES "diagrams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diagram_versions" ADD CONSTRAINT "diagram_versions_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "share_links" ADD CONSTRAINT "share_links_diagram_id_fkey" FOREIGN KEY ("diagram_id") REFERENCES "diagrams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "database_table_components" ADD CONSTRAINT "database_table_components_id_fkey" FOREIGN KEY ("id") REFERENCES "diagram_components"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_components" ADD CONSTRAINT "service_components_id_fkey" FOREIGN KEY ("id") REFERENCES "diagram_components"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_source_component_id_fkey" FOREIGN KEY ("source_component_id") REFERENCES "diagram_components"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "connections" ADD CONSTRAINT "connections_target_component_id_fkey" FOREIGN KEY ("target_component_id") REFERENCES "diagram_components"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "collaboration_rooms" ADD CONSTRAINT "collaboration_rooms_diagram_id_fkey" FOREIGN KEY ("diagram_id") REFERENCES "diagrams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "websocket_events" ADD CONSTRAINT "websocket_events_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "collaboration_rooms"("diagram_id") ON DELETE RESTRICT ON UPDATE CASCADE;
