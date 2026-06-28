# FrameLabs — User Flows & Views

## What is a User Flow?

A user flow is the path a user takes through the application to complete a specific task. It maps every screen and decision point from start to finish — showing how a user moves through the product, what they see at each step, and where they end up. Good user flows expose gaps in the design before any code is written.

---

## Core User Flows

### 1. Authentication

```
Landing Page → Click "Sign Up" → Register (email/password or OAuth) → Email Verification → Dashboard
```

```
Landing Page → Click "Login" → Enter Credentials → Dashboard
```

```
Landing Page → Click "Login" → "Forgot Password" → Enter Email → Reset Link Sent → New Password → Login → Dashboard
```

### 2. First-Time User Experience

```
Register → Dashboard (empty state) → "Create Your First Diagram" prompt → Select Diagram Type → Name the Diagram → Editor (with onboarding hints)
```

### 3. Create a New Diagram

```
Dashboard → Click "New Diagram" → Select Workspace Type (Database / Architecture / Sequence / Class / Flow) → Name the Diagram → Choose Workspace → Editor Canvas
```

### 4. Database Diagram Workspace

```
Editor Canvas → Open Component Library → Drag "Table" onto Canvas → Click Table → Property Panel Opens → Add Columns (name, type, constraints) → Drag Another Table → Draw Relationship (FK) Between Tables → Label the Relationship → Save
```

```
Editor Canvas → Toggle to Syntax View → Write DBML Code → Canvas Auto-Updates with Visual ERD → Edit Either Side (stays in sync) → Save
```

```
Editor Canvas → Select Table → Right Click → "Add Index" / "Set Primary Key" / "Delete Table" → Confirm → Canvas Updates
```

### 5. System Architecture Workspace

```
Editor Canvas → Open Component Library → Drag "Service" Node → Set Properties (name, framework, port) → Drag "Database" Node → Draw Connection → Set Connection Type (HTTP / gRPC / WebSocket) → Add Label → Save
```

```
Editor Canvas → Select Multiple Nodes → "Group into Boundary" → Name Boundary (e.g. "VPC", "K8s Cluster") → Boundary Box Wraps Selected Nodes → Save
```

### 6. Sequence Diagram Workspace

```
Editor Canvas → Add Participant (Actor / Service / Database) → Add Another Participant → Draw Message Arrow Between Them → Set Message Label ("POST /login") → Set Arrow Type (sync / async / return) → Add More Messages → Save
```

```
Editor Canvas → Toggle Syntax View → Write Mermaid-style Sequence Code → Canvas Updates with Lifelines and Messages → Save
```

### 7. Class Diagram Workspace

```
Editor Canvas → Drag "Class" Component → Add Class Name → Add Attributes (name, type, visibility +/-/#) → Add Methods (signature, return type) → Drag Another Class → Draw Relationship (inheritance / association / composition) → Set Multiplicity Labels → Save
```

### 8. Flow Diagram Workspace

```
Editor Canvas → Drag "Start" Node → Drag "Process" Node → Connect Start → Process → Drag "Decision" Node → Connect Process → Decision → Add "Yes" Branch → Add "No" Branch → Connect to End Nodes → Save
```

### 9. Dual Editing (Visual ↔ Syntax)

```
Editor Canvas (Visual Mode) → Click "Split View" → Syntax Editor Opens Side-by-Side → Edit in Syntax → Canvas Updates Live → Edit on Canvas → Syntax Updates Live → Save
```

```
Editor Canvas → Click "Syntax Only" → Full-Screen Syntax Editor → Write/Edit Code → Click "Visual Only" → Full-Screen Canvas with Updated Diagram
```

### 10. Real-Time Collaboration

```
Editor Canvas → Click "Share" → Share Dialog Opens → Copy Link / Invite by Email → Set Permission (Editor / Viewer) → Send → Collaborator Opens Link → Joins Same Canvas → Both See Live Cursors → Both Edit Simultaneously → Changes Sync in Real-Time
```

```
Editor Canvas → See Collaborator's Cursor Moving → See Their Avatar in Presence Bar → They Add a Component → It Appears on Your Canvas Instantly → You Move It → They See It Move
```

### 11. Version History

```
Editor Canvas → Click "History" → Version Panel Opens → Browse Versions (timestamped, author tagged) → Click a Version → Preview the Snapshot → Click "Restore" → Diagram Reverts to That Version → New Version Created
```

```
Editor Canvas → Click "History" → Select Two Versions → Click "Compare" → Diff View Shows Added / Removed / Modified Components
```

### 12. Organisation & Workspace Management

```
Dashboard → Click "Create Workspace" → Name Workspace → Set Description → Invite Members (email) → Set Roles (Owner / Admin / Editor / Viewer) → Workspace Created → Redirected to Workspace View
```

```
Dashboard → Select Workspace → View Diagram List → Search / Filter by Tag → Click Diagram → Opens in Editor
```

```
Dashboard → Select Workspace → Click "New Project" → Name Project → Add Diagrams to Project → Project Groups Diagrams Together
```

### 13. Export a Diagram

```
Editor Canvas → Click "Export" → Select Format (PNG / SVG / PDF / Markdown) → Configure Options (resolution, background) → Click "Download" → File Saved
```

### 14. Share a Diagram (Public Link)

```
Editor Canvas → Click "Share" → Toggle "Public Link" On → Copy Link → Anyone with Link Can View (read-only) → Optionally Set Password / Expiry
```

### 15. Search Across Diagrams

```
Dashboard → Click Search Bar → Type Query (diagram name / component label / tag) → Results Show Matching Diagrams → Click Result → Opens in Editor
```

### 16. Settings & Profile

```
Dashboard → Click Avatar → "Settings" → Update Profile (name, avatar, email) → Change Password → Manage Connected OAuth Accounts → Save
```

```
Dashboard → Click Avatar → "Settings" → "Organisation" Tab → Manage Members → Change Roles → Remove Members
```

---

## View List (All Screens)

| # | View | Description |
|---|---|---|
| 1 | **Landing Page** | Product intro, features, CTA to sign up / login |
| 2 | **Register** | Sign up form (email/password + OAuth options) |
| 3 | **Login** | Sign in form + forgot password link |
| 4 | **Forgot Password** | Email input for password reset |
| 5 | **Dashboard** | All workspaces, recent diagrams, search, new diagram button |
| 6 | **Workspace View** | Diagrams within a workspace, project grouping, member list |
| 7 | **New Diagram Modal** | Select diagram type, name input, workspace selector |
| 8 | **Editor — Canvas** | Main diagram editing area (React Flow / Konva canvas) |
| 9 | **Editor — Split View** | Canvas + syntax editor side by side |
| 10 | **Editor — Syntax Only** | Full-screen Monaco editor |
| 11 | **Component Library Panel** | Draggable palette of workspace-specific components |
| 12 | **Property Panel** | Edit selected component's properties (name, type, attributes) |
| 13 | **Toolbar** | Zoom, pan, undo/redo, layout, workspace-specific tools |
| 14 | **Collaboration Presence Bar** | Online avatars, cursor colours, active user count |
| 15 | **Share Dialog** | Public link toggle, invite by email, permission control |
| 16 | **Version History Panel** | Timeline of versions, preview, restore, diff |
| 17 | **Export Modal** | Format picker (PNG/SVG/PDF), options, download |
| 18 | **Search Results** | Filtered list of diagrams matching the query |
| 19 | **Settings — Profile** | Name, avatar, email, password, OAuth connections |
| 20 | **Settings — Organisation** | Member management, roles, workspace settings |
| 21 | **404 / Error Page** | Lost page with redirect to dashboard |

---

## Flow Summary Diagram

```
                                    ┌─────────────┐
                                    │  Landing     │
                                    │  Page        │
                                    └──────┬───────┘
                                           │
                              ┌────────────┼────────────┐
                              ▼                         ▼
                        ┌──────────┐              ┌──────────┐
                        │ Register │              │  Login    │
                        └────┬─────┘              └────┬─────┘
                             │                         │
                             └────────────┬────────────┘
                                          ▼
                                   ┌─────────────┐
                                   │  Dashboard   │
                                   └──────┬───────┘
                                          │
                    ┌─────────┬───────────┼───────────┬──────────┐
                    ▼         ▼           ▼           ▼          ▼
              ┌──────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
              │ Workspace│ │ Search │ │Settings│ │  New   │ │ Recent │
              │  View    │ │        │ │        │ │Diagram │ │Diagrams│
              └────┬─────┘ └────────┘ └────────┘ └───┬────┘ └───┬────┘
                   │                                  │          │
                   └──────────────────┬───────────────┘          │
                                      ▼                          │
                               ┌─────────────┐                  │
                               │   Editor     │◀─────────────────┘
                               │   Canvas     │
                               └──────┬───────┘
                                      │
                    ┌────────┬────────┼────────┬────────┬────────┐
                    ▼        ▼        ▼        ▼        ▼        ▼
              ┌─────────┐┌──────┐┌───────┐┌───────┐┌───────┐┌───────┐
              │Component││Split ││Version││Share  ││Export ││Collab │
              │ Library ││ View ││History││Dialog ││Modal  ││ Bar   │
              └─────────┘└──────┘└───────┘└───────┘└───────┘└───────┘
```

---

## What's Next

Once these flows are validated by the team:

1. Create wireframes for each view (Excalidraw / Figma)
2. Map each flow to the API endpoints in [docs/PRD.md](../PRD.md)
3. Start implementing views from the top — Landing → Auth → Dashboard → Editor
