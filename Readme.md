# FrameLabs

**Collaborative Engineering Diagram Workspace Platform**

FrameLabs is a collaborative engineering diagramming platform that enables developers and technical teams to design, document, and communicate software systems visually. The platform provides specialised diagram workspaces where engineers can create system architectures, database designs, application flows, and software structures using both visual interactions and syntax-based definitions.

> **Positioning:** FrameLabs is NOT a generic whiteboard application. It is a dedicated engineering workspace where diagrams represent actual technical systems, relationships, and architectural decisions.

---

## Product Vision

Before software systems are implemented, they are designed. Engineering teams regularly create diagrams to understand system architecture, database relationships, application flows, service communication, and code structure. However, engineering diagrams are often scattered across different tools, outdated images, or manually maintained files.

**FrameLabs creates a single workspace where technical diagrams become living engineering documents.**

Engineers can:

- Design systems visually
- Represent technical relationships accurately
- Collaborate with teammates in real time
- Maintain architecture history over time
- Document evolving software systems

> The goal is not drawing. The goal is helping engineers think, design, and communicate better.

---

## Target Users

### Software Engineers

Developers designing and documenting technical systems — creating architecture and system diagrams, representing code structure and component relationships, documenting architectural decisions, and sharing designs with teammates.

### Engineering Teams

Groups collaborating on system design and documentation — shared diagram workspaces, real-time architecture discussions, version tracking across contributors, and concurrent collaborative editing.

### Technical Leads & Architects

Users responsible for high-level system planning and communication — large-scale system representation, maintaining architecture evolution over time, and communicating technical decisions to teams.

---

## Core Features

### 1. Specialised Diagram Workspaces

FrameLabs provides purpose-built workspaces for different engineering diagram types:

| Workspace               | Purpose                                                   |
| ----------------------- | --------------------------------------------------------- |
| **Database Diagram**    | Schema definition, tables, relationships, constraints     |
| **System Architecture** | Services, APIs, infrastructure, data flow, dependencies   |
| **Sequence Diagram**    | Component interactions, request-response flows, timelines |
| **Class Diagram**       | OOP structure, inheritance, associations, interfaces      |
| **Flow Diagram**        | Process logic, conditional paths, decision trees          |

Each workspace provides relevant components, diagram-specific tools, correct relationship types, and an appropriate editing experience for its domain.

### 2. Dual Editing System

Support both visual and syntax-based diagram creation:

- **Visual Editing** — Drag-and-drop components, draw connections interactively, edit properties through visual panels
- **Syntax-Based Editing** — Text definitions generate corresponding diagrams, changes propagate bidirectionally, switch between modes freely

**Example:** An engineer defines a database schema in DBML or SQL DDL. FrameLabs automatically generates the visual ERD. Editing either the visual diagram or the text keeps both in sync.

### 3. Database Design Workspace

- Define tables, columns, data types, primary keys, foreign keys, constraints, indices, and default values
- Model one-to-one, one-to-many, and many-to-many relationships with junction table support

### 4. System Architecture Workspace

- Supported components: frontend apps, backend services, APIs/gateways, databases, caches, message queues, external systems, cloud infrastructure
- Model communication flows, system dependencies/boundaries, and data movement paths

### 5. Sequence Diagram Workspace

- Define users/actors, services/components, communication sequences, request-response pairs, and async flows
- Example scenarios: authentication flows, payment pipelines, API request-response workflows

### 6. Class Diagram Workspace

- Create classes, abstract classes, interfaces, traits with typed attributes and method signatures
- Represent inheritance, implementation, associations, aggregations, dependencies, and compositions

### 7. Intelligent Component System

Diagram objects carry meaning beyond their visual shape:

- **Database component** — Understands tables, fields, relationships, and constraints
- **Service component** — Understands APIs, ports, dependencies, and protocols
- **Class component** — Understands methods, properties, visibility, and relationships
- **Sequence participant** — Understands message ordering, lifelines, and activation bars

### 8. Smart Connection System

- Typed connections (foreign key, dependency, API call, inheritance, etc.)
- Connections maintain integrity when components are repositioned
- Labels with names, multiplicity, and direction
- Directional arrows and dependency type visualisation
- Semantic validation prevents invalid connections per workspace type

### 9. Real-Time Collaboration

- Multiple active editors on the same diagram
- Real-time diagram state synchronisation
- Live user presence indicators and cursor tracking
- Simultaneous editing without conflicts
- Changes remain consistent across all clients — work is never unexpectedly lost

### 10. Version History

- Automatic tracking of all diagram changes
- Browse and restore previous diagram versions
- Diff between versions to understand what changed
- Attribute changes to specific collaborators

### 11. Organisation System

- Workspaces for isolating team or project diagrams
- Projects for grouping related diagrams
- Tags and categories for classification
- Search across diagrams, components, and metadata

### 12. Export & Sharing

**Export formats:** PNG, SVG, PDF, Markdown-embeddable formats

**Sharing options:** Public read-only links, team-scoped access controls, permission-controlled sharing

---

## Scale Requirements

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
| Diagram revisions             | Millions              |
| History retention             | Long-term (no expiry) |

---

## Tech Stack

| Layer                | Technology                                    |
| -------------------- | --------------------------------------------- |
| **Frontend**         | Next.js 14 (App Router), React 18, TypeScript |
| **Styling**          | Tailwind CSS, Radix UI                        |
| **Canvas/Diagrams**  | React Flow, Konva.js                          |
| **Code Editor**      | Monaco Editor                                 |
| **State Management** | Zustand                                       |
| **Backend**          | Node.js, Fastify, TypeScript                  |
| **Database**         | PostgreSQL                                    |
| **ORM**              | Prisma                                        |
| **Cache & Pub/Sub**  | Redis                                         |
| **Real-Time**        | Socket.IO, Y.js (CRDT)                        |
| **Auth**             | NextAuth.js / Auth.js                         |
| **Monorepo**         | Turborepo, pnpm                               |
| **CI/CD**            | GitHub Actions                                |
| **Containerisation** | Docker, Docker Compose                        |
| **Testing**          | Vitest, Playwright                            |

---

## Project Structure

```
FrameLabs/
├── .github/
│   ├── workflows/           # CI/CD pipelines
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── CODEOWNERS
├── apps/
│   ├── web/                 # Next.js frontend
│   │   ├── src/
│   │   │   ├── app/         # App Router (pages, API routes)
│   │   │   ├── components/  # UI & diagram components
│   │   │   ├── hooks/       # Custom React hooks
│   │   │   ├── lib/         # Utilities, API clients
│   │   │   ├── stores/      # Zustand state stores
│   │   │   ├── types/       # TypeScript type definitions
│   │   │   └── styles/      # Global styles
│   │   └── public/          # Static assets
│   └── server/              # Fastify backend API
│       ├── src/
│       │   ├── api/         # Routes, controllers, middleware
│       │   ├── services/    # Business logic
│       │   ├── models/      # Data models
│       │   ├── ws/          # WebSocket handlers
│       │   ├── lib/         # Shared utilities
│       │   └── config/      # Server configuration
│       ├── prisma/          # Database schema & migrations
│       └── tests/           # Unit, integration, e2e tests
├── packages/
│   ├── shared/              # Shared types, utils, constants
│   ├── diagram-core/        # Core diagram engine
│   │   └── src/
│   │       ├── workspaces/  # Database, architecture, sequence, class, flow
│   │       ├── components/  # Diagram component definitions
│   │       ├── connections/ # Connection logic & validation
│   │       ├── parser/      # Syntax-to-diagram parser
│   │       ├── renderer/    # Diagram rendering engine
│   │       └── validators/  # Semantic validation rules
│   ├── collaboration/       # CRDT, sync, presence engine
│   └── eslint-config/       # Shared ESLint configuration
├── docs/                    # Architecture & PRD documentation
├── docker/                  # Docker & Compose files
├── scripts/                 # Build, deploy, utility scripts
├── .env.example             # Environment variable template
├── turbo.json               # Turborepo pipeline config
├── tsconfig.base.json       # Base TypeScript config
├── package.json             # Root workspace config
├── CODE_OF_CONDUCT.md       # Community guidelines
└── CONTRIBUTING.md          # Contribution guidelines
```

---

## Getting Started

### Prerequisites

- **Node.js** >= 20.x
- **pnpm** >= 9.x
- **Docker** & **Docker Compose**
- **PostgreSQL** 16+
- **Redis** 7+

### Installation

```bash
# Clone the repository
git clone https://github.com/mrstrange1708/FrameLabs.git
cd FrameLabs

# Switch to the correct Node.js version (reads .nvmrc)
nvm use

# Install dependencies
pnpm install

# Copy environment variables
cp .env.example .env

# Start infrastructure (PostgreSQL, Redis)
docker compose up -d

# Run database migrations
pnpm --filter server db:migrate

# Start development servers
pnpm dev
```

### Development Commands

```bash
pnpm dev           # Start all apps in development mode
pnpm build         # Build all apps and packages
pnpm lint          # Lint all packages
pnpm typecheck     # Run TypeScript type checking
pnpm test          # Run all tests
pnpm test:e2e      # Run end-to-end tests
pnpm format        # Format code with Prettier
```

---

## Product Scope

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

## Non-Functional Requirements

| Quality             | Expectation                                                                   |
| ------------------- | ----------------------------------------------------------------------------- |
| **Reliability**     | Technical diagrams remain safe, consistent, and never silently corrupted      |
| **Performance**     | Large diagrams (50k+ objects) remain responsive; collaboration is low-latency |
| **Maintainability** | New diagram workspace types can be introduced without architectural rewrites  |
| **Scalability**     | Platform supports growing teams and millions of versioned diagram revisions   |

---

## Success Metrics

### Product Success

- Engineers can design real software systems, not toy diagrams
- Each diagram type feels purpose-built for its domain
- Visual and syntax workflows operate seamlessly together
- Teams can collaborate on diagrams in real time
- Architecture history is preserved and browsable

### Engineering Success

- Clean, maintainable architecture decisions
- Stable, repeatable deployments
- Well-structured source repository
- Comprehensive documentation

---

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our development process and the [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for community guidelines.

---

## License

This project is proprietary software. All rights reserved.

---

**Built with purpose — for engineers who think in systems.**
