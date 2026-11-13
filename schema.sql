-- ParlayLab (se puede ejecutar varias veces sin error)

create table if not exists public.profiles (
  id uuid primary key references auth.users on delete cascade,
  created_at timestamptz default now()
);
alter table public.profiles add column if not exists email text;
alter table public.profiles add column if not exists full_name text;
alter table public.profiles add column if not exists avatar_url text;
alter table public.profiles add column if not exists role text not null default 'user';
alter table public.profiles add column if not exists last_seen timestamptz default now();

alter table public.profiles enable row level security;
drop policy if exists "ver mi perfil" on public.profiles;
create policy "ver mi perfil" on public.profiles for select using (auth.uid() = id);
drop policy if exists "editar mi perfil" on public.profiles;
create policy "editar mi perfil" on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);
revoke update on public.profiles from authenticated;
grant update (full_name, avatar_url, last_seen) on public.profiles to authenticated;

create or replace function public.handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, email, full_name, avatar_url)
  values (new.id, new.email,
    coalesce(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name'),
    new.raw_user_meta_data->>'avatar_url')
  on conflict (id) do nothing;
  return new;
end $$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

create table if not exists public.parlays (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  kind text not null check (kind in ('history','bet')),
  data jsonb not null,
  created_at timestamptz default now()
);
create index if not exists parlays_user_created_idx on public.parlays (user_id, created_at desc);
alter table public.parlays enable row level security;
drop policy if exists "solo mis filas" on public.parlays;
create policy "solo mis filas" on public.parlays for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create or replace function public.is_admin() returns boolean
language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.profiles where id = auth.uid() and role = 'admin') $$;
drop policy if exists "admin ve perfiles" on public.profiles;
create policy "admin ve perfiles" on public.profiles for select using (public.is_admin());

create or replace function public.delete_my_account() returns void
language sql security definer set search_path = public as $$
  delete from auth.users where id = auth.uid() $$;
revoke all on function public.delete_my_account() from public, anon;
grant execute on function public.delete_my_account() to authenticated;

-- Hazte admin (cambia el correo y ejecuta DESPUÉS de iniciar sesión una vez):
-- update public.profiles set role = 'admin' where email = 'tucorreo@gmail.com';
