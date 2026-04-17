# Schema 1: `users`

| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `email` | TEXT UNIQUE |  |
| `display_name` | TEXT |  |
| `created_at` | TIMESTAMPTZ |  |
| `last_active_at` | TIMESTAMPTZ |  |
