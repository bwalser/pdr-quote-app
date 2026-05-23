-- PDR Quote Tool — Supabase Schema
-- Run this in your Supabase SQL Editor

-- Users table
create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  username text unique not null,
  password_hash text not null,
  name text not null,
  role text not null check (role in ('admin','advisor','tech')),
  created_at timestamptz default now()
);

-- Quotes table
create table if not exists quotes (
  id uuid primary key default gen_random_uuid(),
  customer_name text not null,
  vehicle text not null,
  notes text default '',
  line_items jsonb not null default '[]',
  photos jsonb not null default '[]',
  total numeric(10,2) not null default 0,
  status text not null default 'pending' check (status in ('pending','approved','denied','accepted','completed')),
  advisor_id uuid references users(id),
  advisor_name text not null,
  ro_number text default '',
  created_at timestamptz default now(),
  approved_at timestamptz,
  accepted_at timestamptz
);

-- Enable Row Level Security
alter table users enable row level security;
alter table quotes enable row level security;

-- Policies: allow all authenticated operations (simple setup)
-- You can tighten these per role later
create policy "Allow all on users" on users for all using (true) with check (true);
create policy "Allow all on quotes" on quotes for all using (true) with check (true);

-- Sample admin user (change password after setup!)
insert into users (username, password_hash, name, role)
values ('admin', 'admin123', 'Admin', 'admin')
on conflict (username) do nothing;

-- Index for performance
create index if not exists quotes_advisor_id_idx on quotes(advisor_id);
create index if not exists quotes_status_idx on quotes(status);
create index if not exists quotes_created_at_idx on quotes(created_at desc);
