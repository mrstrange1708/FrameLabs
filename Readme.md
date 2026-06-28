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

### 3. Real-Time Collaboration

- Multiple active editors on the same diagram
- Real-time diagram state synchronisation
- Live user presence indicators and cursor tracking
- Simultaneous editing without conflicts

### 4. Version History

- Automatic tracking of all diagram changes
- Browse and restore previous diagram versions
- Diff between versions to understand what changed

### 5. Export & Sharing

**Export formats:** PNG, SVG, PDF, Markdown-embeddable formats

**Sharing options:** Public read-only links, team-scoped access controls, permission-controlled sharing

---

## Tech Stack

| Layer                | Technology                                    |
| -------------------- | --------------------------------------------- |
| **Frontend**         | Next.js (App Router), React, TypeScript       |
| **Styling**          | Tailwind CSS, Radix UI                        |
| **Canvas/Diagrams**  | React Flow, Konva.js                          |
| **Code Editor**      | Monaco Editor                                 |
| **State Management** | Zustand                                       |
| **Backend**          | Node.js, Fastify, TypeScript                  |
| **Database**         | PostgreSQL                                    |
| **ORM**              | Prisma                                        |
| **Cache & Pub/Sub**  | Redis                                         |
| **Real-Time**        | Socket.IO, Y.js (CRDT)                        |
| **Auth**             | Auth.js                                       |
| **Monorepo**         | Turborepo, pnpm                               |
| **CI/CD**            | GitHub Actions                                |
| **Containerisation** | Docker, Docker Compose                        |
| **Testing**          | Vitest, Playwright                            |

---

## Repository Structure

```
FrameLabs/
├── .github/
│   ├── workflows/
│   │   ├── pr-guard.yml            # PR safety checks (no secrets, no conflict markers)
│   │   ├── security.yml            # CodeQL analysis, secret leak detection
│   │   └── branch-protection.yml   # Main branch protection enforcement
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── CODEOWNERS
├── docs/
│   └── PRD.md                      # Product Requirements Document
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
└── Readme.md
```

> The codebase (apps, packages, configs) will be added as development begins. See [docs/PRD.md](docs/PRD.md) for the full technical specification.

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

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our development process and the [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for community guidelines.

---

## License

This project is proprietary software. All rights reserved.

---

**Built with purpose — for engineers who think in systems.**
