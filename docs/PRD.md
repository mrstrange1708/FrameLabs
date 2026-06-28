# FrameLabs — Product Requirements Document

**Version:** 1.0
**Program:** DevClub Product Builders Program
**Duration:** 8 Weeks
**Team:** 4-5 Engineers
**Status:** Draft

---

## 1. Product Overview

FrameLabs is a collaborative engineering diagramming platform that enables developers and technical teams to design, document, and communicate software systems visually. The platform provides specialised diagram workspaces where engineers can create system architectures, database designs, application flows, and software structures using both visual interactions and syntax-based definitions.

**Positioning Constraint:** FrameLabs should NOT behave like a generic whiteboard application. The objective is a dedicated engineering workspace where diagrams represent actual technical systems, relationships, and architectural decisions.

---

## 2. Product Vision

Before software systems are implemented, they are designed. Engineering teams regularly create diagrams to understand system architecture, database relationships, application flows, service communication, and code structure. However, engineering diagrams are often scattered across different tools, outdated images, or manually maintained files.

**Vision:** Create a single workspace where technical diagrams become living engineering documents.

The platform should allow engineers to:

- Design systems visually
- Represent technical relationships accurately
- Collaborate with teammates in real time
- Maintain architecture history over time
- Document evolving software systems

> The goal is not drawing. The goal is helping engineers think, design, and communicate better.

---

## 3. Target Users

### Software Engineers

- Create architecture and system diagrams
- Represent code structure and component relationships
- Document architectural decisions
- Share designs with teammates

### Engineering Teams

- Shared diagram workspaces
- Real-time architecture discussions
- Version tracking across contributors
- Concurrent collaborative editing

### Technical Leads & Architects

- Large-scale system representation
- Maintaining architecture evolution over time
- Communicating technical decisions to teams

---

## 4. Core Technical Requirements

### 4.1 Diagram Workspace System

Users create specialised workspaces based on the type of system they want to design.

**Supported Workspace Types:**

| Type                | Components                                  | Technical Implementation                                         |
| ------------------- | ------------------------------------------- | ---------------------------------------------------------------- |
| Database Diagram    | Tables, columns, relationships, constraints | DBML/SQL DDL parser, ERD renderer, FK constraint validation      |
| System Architecture | Services, APIs, infrastructure, data flow   | Custom node types, directed graph layout, boundary grouping      |
| Sequence Diagram    | Actors, lifelines, messages, activations    | Timeline-based vertical layout, message ordering engine          |
| Class Diagram       | Classes, interfaces, attributes, methods    | UML-compliant renderer, visibility modifiers, relationship types |
| Flow Diagram        | Process nodes, decisions, conditions, paths | Flowchart layout algorithm, conditional branching validation     |

**Technical Requirements:**

- Each workspace type must have its own component registry
- Workspace-specific validation rules prevent invalid diagrams
- Component schemas are defined in `packages/diagram-core/src/workspaces/`
- New workspace types can be added without modifying core architecture

### 4.2 Dual Editing System

**Visual Editor:**

- React Flow / Konva.js canvas with drag-and-drop
- Property panels for component editing (Radix UI forms)
- Interactive connection drawing with snap-to-port
- Undo/redo stack per editing session

**Syntax Editor:**

- Monaco Editor with custom language support per workspace type
- Real-time syntax validation and error highlighting
- Auto-completion for workspace-specific keywords
- Bidirectional sync between visual and text representations

**Sync Engine Technical Design:**

- Internal representation: normalised graph model (`packages/diagram-core/`)
- Visual editor reads/writes to graph model
- Syntax parser converts text to graph model (`packages/diagram-core/src/parser/`)
- Renderer converts graph model to visual layout (`packages/diagram-core/src/renderer/`)
- Change events propagate bidirectionally with debouncing

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Visual Editor   │────▶│   Graph Model    │◀────│  Syntax Editor  │
│  (React Flow)    │◀────│  (Normalised)    │────▶│  (Monaco)       │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                               │
                    ┌──────────┴──────────┐
                    │   Validation Layer   │
                    │   (per workspace)    │
                    └─────────────────────┘
```

### 4.3 Database Design Workspace

**Schema Definition:**

- Define tables with columns, data types (`VARCHAR`, `INT`, `UUID`, `TIMESTAMP`, etc.)
- Primary keys (single and composite)
- Foreign keys with ON DELETE/UPDATE actions
- Unique constraints, NOT NULL, CHECK constraints
- Indices (B-tree, Hash, GIN, GiST)
- Default values and auto-increment

**Relationship Management:**

- One-to-one (FK with UNIQUE constraint)
- One-to-many (FK without UNIQUE)
- Many-to-many (auto-generate junction tables)
- Self-referencing relationships

**Syntax Format:** DBML-compatible with extensions

```dbml
Table users {
  id uuid [pk, default: `gen_random_uuid()`]
  email varchar(255) [unique, not null]
  name varchar(100) [not null]
  created_at timestamp [default: `now()`]
}

Table posts {
  id uuid [pk]
  title varchar(255) [not null]
  author_id uuid [ref: > users.id]
}
```

**Export:** SQL DDL (PostgreSQL, MySQL), Prisma schema

### 4.4 System Architecture Workspace

**Component Types:**
| Component | Properties |
|---|---|
| Frontend App | framework, port, protocol |
| Backend Service | language, framework, port, health endpoint |
| API Gateway | routes, rate limits, auth method |
| Database | engine, version, port, connection pool |
| Cache | engine (Redis/Memcached), eviction policy |
| Message Queue | engine (Kafka/RabbitMQ), topics/queues |
| External Service | URL, auth type, SLA |
| Cloud Resource | provider, region, service type |

**Connection Types:**

- HTTP/HTTPS (with method + path)
- gRPC
- WebSocket
- TCP/UDP
- Pub/Sub (topic-based)
- Database connection (connection string)

**Layout:** Automatic layout with manual override. Components can be grouped into boundaries (VPC, Kubernetes cluster, service mesh).

### 4.5 Sequence Diagram Workspace

**Elements:**

- Participants (actors, services, databases)
- Lifelines with activation bars
- Synchronous messages (solid arrow)
- Asynchronous messages (open arrow)
- Return messages (dashed arrow)
- Self-calls (loop-back)
- Combined fragments: `alt`, `opt`, `loop`, `par`, `break`
- Notes on lifelines

**Syntax Format:** Mermaid-compatible

```
sequenceDiagram
  Actor User
  participant AuthService
  participant DB

  User->>AuthService: POST /login
  AuthService->>DB: SELECT user WHERE email=?
  DB-->>AuthService: user record
  AuthService-->>User: JWT token
```

### 4.6 Class Diagram Workspace

**Element Types:**

- Classes: name, attributes (type + visibility), methods (signature + visibility)
- Abstract classes: italic name, abstract methods
- Interfaces: `<<interface>>` stereotype
- Enums: `<<enumeration>>` stereotype

**Visibility Modifiers:** `+` public, `-` private, `#` protected, `~` package

**Relationship Types:**
| Relationship | Arrow | Meaning |
|---|---|---|
| Inheritance | Solid + hollow triangle | `extends` |
| Implementation | Dashed + hollow triangle | `implements` |
| Association | Solid line | Has reference to |
| Aggregation | Solid + hollow diamond | Has (weak ownership) |
| Composition | Solid + filled diamond | Owns (strong ownership) |
| Dependency | Dashed arrow | Uses |

**Multiplicity Labels:** `1`, `0..1`, `*`, `1..*`, `n..m`

### 4.7 Intelligent Component System

Each diagram component type has a typed schema:

```typescript
// packages/diagram-core/src/components/
interface DiagramComponent {
  id: string;
  type: WorkspaceType;
  position: { x: number; y: number };
  dimensions: { width: number; height: number };
  data: ComponentData; // Workspace-specific typed data
  ports: Port[]; // Connection anchor points
}

interface DatabaseTableComponent extends DiagramComponent {
  data: {
    tableName: string;
    columns: Column[];
    indices: Index[];
    constraints: Constraint[];
  };
}

interface ServiceComponent extends DiagramComponent {
  data: {
    serviceName: string;
    framework: string;
    port: number;
    endpoints: Endpoint[];
    dependencies: string[];
  };
}
```

### 4.8 Smart Connection System

```typescript
interface Connection {
  id: string;
  type: ConnectionType; // 'fk', 'dependency', 'http', 'inheritance', etc.
  source: { componentId: string; portId: string };
  target: { componentId: string; portId: string };
  label?: string;
  multiplicity?: { source: string; target: string };
  direction: 'unidirectional' | 'bidirectional';
  style: ConnectionStyle;
}
```

**Validation Rules:**

- Database workspace: only FK/reference connections between tables
- Architecture workspace: typed protocol connections between services
- Class workspace: UML relationship types only
- Sequence workspace: message connections between participants on timeline

**Routing:** Automatic edge routing with orthogonal paths, avoiding component overlap. Connections maintain endpoints when components are moved.

### 4.9 Collaboration System

**Technology Stack:**

- **Transport:** Socket.IO for WebSocket connections
- **CRDT Engine:** Y.js for conflict-free replicated data types
- **Awareness Protocol:** Y.js awareness for cursor/presence tracking
- **Server:** Fastify WebSocket handler for room management

**Architecture:**

```
┌──────────┐     ┌──────────┐     ┌──────────┐
│ Client A  │────▶│  Socket  │◀────│ Client B  │
│ (Y.Doc)   │     │  Server  │     │ (Y.Doc)   │
└──────────┘     │ (Y.js    │     └──────────┘
                  │  sync)   │
                  └────┬─────┘
                       │
                  ┌────▼─────┐
                  │ PostgreSQL│
                  │ (persist) │
                  └──────────┘
```

**Capabilities:**

- Y.Doc per diagram for conflict-free concurrent editing
- Operational transforms handled by Y.js CRDT
- Cursor position broadcast via awareness protocol
- User presence (online/idle/offline) via heartbeat
- Reconnection with automatic state sync
- Periodic persistence to PostgreSQL

**Concurrency Guarantee:** All operations are commutative via CRDT. No locks, no OT conflicts.

### 4.10 Version History System

**Implementation:**

- Every diagram save creates an immutable snapshot in PostgreSQL
- Snapshots stored as compressed JSON (diagram graph model)
- Diff engine compares two snapshots to show added/removed/modified components
- Restore creates a new version from a historical snapshot (never overwrites history)

**Schema:**

```sql
CREATE TABLE diagram_versions (
  id          UUID PRIMARY KEY,
  diagram_id  UUID REFERENCES diagrams(id),
  version     INTEGER NOT NULL,
  snapshot    JSONB NOT NULL,
  author_id   UUID REFERENCES users(id),
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  message     TEXT
);
```

**Retention:** No expiry. All versions are retained indefinitely.

### 4.11 Organisation System

**Hierarchy:**

```
Organisation
  └── Workspace (team/project scope)
       └── Project (diagram grouping)
            └── Diagram (individual diagram)
```

**Features:**

- RBAC: Owner, Admin, Editor, Viewer per workspace
- Tag-based classification and filtering
- Full-text search across diagram names, component labels, and metadata
- Recent/starred/shared views

### 4.12 Export & Sharing System

**Export Pipeline:**
| Format | Method |
|---|---|
| PNG | Canvas-to-image via `html-to-image` or Konva export |
| SVG | Direct SVG serialisation from render tree |
| PDF | Server-side PDF generation via Puppeteer or `@react-pdf/renderer` |
| Markdown | Embeddable image + metadata block |
| JSON | Raw diagram graph model for programmatic consumption |

**Sharing:**

- Public links with optional password protection
- Expiring share links (configurable TTL)
- Workspace-level access control (invite by email)
- Embed mode (iframe-ready read-only view)

---

## 5. API Design

### RESTful Endpoints

```
# Auth
POST   /api/auth/register
POST   /api/auth/login
POST   /api/auth/refresh
DELETE /api/auth/logout

# Workspaces
GET    /api/workspaces
POST   /api/workspaces
GET    /api/workspaces/:id
PUT    /api/workspaces/:id
DELETE /api/workspaces/:id

# Diagrams
GET    /api/workspaces/:id/diagrams
POST   /api/workspaces/:id/diagrams
GET    /api/diagrams/:id
PUT    /api/diagrams/:id
DELETE /api/diagrams/:id

# Versions
GET    /api/diagrams/:id/versions
GET    /api/diagrams/:id/versions/:versionId
POST   /api/diagrams/:id/versions/:versionId/restore

# Collaboration
GET    /api/diagrams/:id/collaborators
POST   /api/diagrams/:id/collaborators
DELETE /api/diagrams/:id/collaborators/:userId

# Export
POST   /api/diagrams/:id/export
GET    /api/share/:shareToken
```

### WebSocket Events

```
# Client -> Server
ws:join-diagram        { diagramId }
ws:leave-diagram       { diagramId }
ws:diagram-update      { operations: Y.js update }
ws:cursor-move         { position, selection }

# Server -> Client
ws:user-joined         { userId, cursor }
ws:user-left           { userId }
ws:diagram-sync        { Y.js state vector }
ws:presence-update     { users: UserPresence[] }
```

---

## 6. Data Models

### Core Entities

```
User
  - id: UUID
  - email: string (unique)
  - name: string
  - avatar_url: string?
  - created_at: timestamp

Organisation
  - id: UUID
  - name: string
  - slug: string (unique)
  - created_at: timestamp

Workspace
  - id: UUID
  - org_id: UUID (FK -> Organisation)
  - name: string
  - description: string?
  - created_at: timestamp

Diagram
  - id: UUID
  - workspace_id: UUID (FK -> Workspace)
  - name: string
  - type: enum (database, architecture, sequence, class, flow)
  - content: JSONB (graph model)
  - syntax: text? (text editor content)
  - created_by: UUID (FK -> User)
  - updated_at: timestamp
  - created_at: timestamp

DiagramVersion
  - id: UUID
  - diagram_id: UUID (FK -> Diagram)
  - version: integer
  - snapshot: JSONB
  - author_id: UUID (FK -> User)
  - message: text?
  - created_at: timestamp

WorkspaceMember
  - workspace_id: UUID (FK -> Workspace)
  - user_id: UUID (FK -> User)
  - role: enum (owner, admin, editor, viewer)
  - joined_at: timestamp

ShareLink
  - id: UUID
  - diagram_id: UUID (FK -> Diagram)
  - token: string (unique)
  - permission: enum (view, comment)
  - password_hash: string?
  - expires_at: timestamp?
  - created_at: timestamp
```

---

## 7. Scale Requirements

| Dimension                     | Target                |
| ----------------------------- | --------------------- |
| Registered users              | 100,000+              |
| Monthly active users          | 10,000+               |
| Concurrent users              | 500+                  |
| Engineering workspaces        | 50,000+               |
| Total diagrams                | 500,000+              |
| Objects per large diagram     | 50,000+               |
| Object relationships          | Millions              |
| Active collaborative diagrams | 100+                  |
| Users editing one workspace   | 50+                   |
| Diagram operations per minute | Thousands             |
| Diagram revisions             | Millions              |
| History retention             | Long-term (no expiry) |

---

## 8. Scope

### In Scope (v1.0)

- Web application (browser-based)
- Dedicated diagram workspaces per type
- Visual drag-and-drop editing
- Syntax-based diagram creation
- Real-time collaboration
- Version history
- Export and sharing

### Out of Scope (v1.0)

- General-purpose design or whiteboard tool
- Image editing features
- Presentation builder
- Native mobile application
- Marketplace or plugin system

---

## 9. Non-Functional Requirements

| Quality             | Expectation                                                             |
| ------------------- | ----------------------------------------------------------------------- |
| **Reliability**     | Diagrams remain safe, consistent, and never silently corrupted          |
| **Performance**     | 50k+ object diagrams remain responsive; sub-100ms collaboration latency |
| **Maintainability** | New workspace types addable without architectural rewrites              |
| **Scalability**     | Supports growing teams and millions of versioned revisions              |

---

## 10. Success Metrics

### Product

- Engineers can design real software systems, not toy diagrams
- Each diagram type feels purpose-built for its domain
- Visual and syntax workflows operate seamlessly together
- Teams can collaborate on diagrams in real time
- Architecture history is preserved and browsable

### Engineering

- Clean, maintainable architecture decisions
- Stable, repeatable deployments
- Well-structured source repository
- Comprehensive documentation

---

## 11. Deliverables

### Product

- Deployed and accessible engineering diagramming platform
- Multiple specialised diagram workspaces
- Real-time collaboration experience
- Export and sharing functionality

### Engineering

- Source code repository
- System architecture documentation
- API documentation
- System design documentation
- Setup and deployment instructions
