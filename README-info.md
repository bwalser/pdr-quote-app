# PDR Quote Tool — Hendrick Collision
## Deployment & Setup Guide

---

## What This App Does

- Service advisors create PDR, rim repair, and bumper repair quotes on their phone
- Quotes go to a tech queue for approval
- Advisors mark customer acceptance and add the RO number
- Reports show sales per advisor with CSV export
- Works as a PWA — advisors add it to their phone home screen like a native app

---

## Fastest Deployment Option: Netlify (Free, 5 minutes)

1. Go to **netlify.com** → Sign up free
2. Drag and drop the entire `pdr-quote-app/` folder onto the Netlify dashboard
3. Netlify gives you a URL like `https://your-app.netlify.app`
4. Share that URL with your team
5. On their phones: open the URL in Safari (iOS) or Chrome (Android) → tap Share → "Add to Home Screen"

**That's it.** The app is live and works offline.

---

## Optional: Enable Cloud Sync with Supabase

By default the app stores all data in the phone's local browser storage.
This means each device has its own data — fine for one phone, but for a team you want cloud sync.

### Supabase Setup (free, ~10 minutes)

1. Go to **supabase.com** → Create free account → New Project
2. Wait for project to provision (~2 min)
3. Go to **SQL Editor** → paste contents of `supabase-schema.sql` → Run
4. Go to **Project Settings → API**
5. Copy:
   - **Project URL** (e.g. `https://abcxyz.supabase.co`)
   - **anon/public** key (starts with `eyJ...`)
6. Open the app → Login as admin → Admin tab → "Configure Cloud Sync" → paste both values → Save

All devices now sync in real time.

---

## User Roles

| Role    | Can Do |
|---------|--------|
| Advisor | Create quotes, view own quotes, mark customer accepted, add RO number, run reports |
| Tech    | View tech queue, approve or deny quotes |
| Admin   | Everything — all quotes, user management, reports |

---

## Default Login Credentials

Change these immediately in Admin → User Management after setup.

| Username  | Password  | Role    |
|-----------|-----------|---------|
| admin     | admin123  | Admin   |
| advisor1  | pass123   | Advisor |
| tech1     | pass123   | Tech    |

---

## PDR Pricing Matrix

|            | Shallow | Medium | Deep |
|------------|---------|--------|------|
| Dime       | $65     | $95    | $130 |
| Quarter    | $95     | $130   | $175 |
| Half Dollar| $130    | $175   | $225 |
| Dollar     | $175    | $225   | $295 |
| Hand Size  | $225    | $295   | $395 |
| Larger     | $295    | $395   | $495 |

Advisors can override any price at quote time.

---

## Files in This Package

| File | Purpose |
|------|---------|
| `index.html` | The entire application |
| `manifest.json` | Makes it installable as a PWA |
| `sw.js` | Service worker (offline support) |
| `supabase-schema.sql` | Run this in Supabase to set up the database |
| `README.md` | This file |

---

## Next Steps / Future Enhancements (Version 2)

- Push notifications when new quotes enter the tech queue
- Customer-facing PDF quote output
- In-app editable pricing matrix
- Completed/invoiced status stage
- Multi-location support
