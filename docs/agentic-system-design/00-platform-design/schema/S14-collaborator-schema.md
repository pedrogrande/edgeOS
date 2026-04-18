# Schema 14: `collaborator`

*Access control for a design system — who can read or write.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `system_id` | UUID FK → design_system |  |
| `user_id` | UUID FK → users |  |
| `role` | ENUM | `owner` / `editor` / `reviewer` / `viewer` |
| `granted_by` | UUID FK → users |  |
| `granted_at` | TIMESTAMPTZ |  |
| `revoked_at` | TIMESTAMPTZ | null if active |
