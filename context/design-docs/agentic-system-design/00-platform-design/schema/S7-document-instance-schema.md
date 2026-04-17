# Schema 7: `document_instance`

*A specific template being completed for a specific system. One per document type per system, except agent_spec which has one per agent.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `system_id` | UUID FK → design_system |  |
| `template_id` | UUID FK → template_definition |  |
| `instance_label` | TEXT | for agent specs: the agent's name; for others: template title |
| `status` | ENUM | `not_started` / `in_progress` / `complete` / `locked` |
| `completion_percentage` | INTEGER | computed field, 0–100 |
| `readiness_checklist_passed` | BOOLEAN | all checklist items resolved |
| `open_decisions_count` | INTEGER | computed — unresolved open decisions |
| `template_version_at_creation` | TEXT | snapshot of template version when instance was created |
| `created_at` | TIMESTAMPTZ |  |
| `created_by` | UUID FK → users |  |
| `completed_at` | TIMESTAMPTZ |  |
| `locked_at` | TIMESTAMPTZ | locked when downstream documents begin |
