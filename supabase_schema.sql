-- 1. Create UserAccounts table
CREATE TABLE public.user_accounts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  email text UNIQUE NOT NULL,
  name text NOT NULL,
  role text DEFAULT 'User',
  department text,
  status text DEFAULT 'Active',
  created_at timestamptz DEFAULT now(),
  last_login timestamptz,
  photo_url text,
  is_google_account boolean DEFAULT false,
  assigned_by text,
  activated_at timestamptz,
  updated_at timestamptz DEFAULT now(),
  emp_no text,
  gid text
);

-- 2. Create Departments table
CREATE TABLE public.departments (
  code text PRIMARY KEY,
  name text NOT NULL,
  updated_at timestamptz DEFAULT now()
);

-- 3. Create Employees table
CREATE TABLE public.employees (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  emp_no text UNIQUE NOT NULL,
  emp_code text,
  gid text UNIQUE NOT NULL,
  first_name text NOT NULL,
  family_name text NOT NULL,
  department text,
  division text,
  function_title text,
  cost_center text,
  is_shift_worker boolean DEFAULT false,
  is_active boolean DEFAULT true,
  updated_at timestamptz DEFAULT now()
);

-- 4. Create ShiftCodes table
CREATE TABLE public.shift_codes (
  code text PRIMARY KEY,
  department text NOT NULL,
  name text NOT NULL,
  start_time text,
  end_time text,
  break_minutes integer DEFAULT 0,
  working_hours numeric DEFAULT 8,
  is_working_day boolean DEFAULT true,
  color text,
  description text,
  updated_at timestamptz DEFAULT now()
);

-- 5. Create DailyShiftPlans table
CREATE TABLE public.daily_shift_plans (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  emp_no text NOT NULL,
  gid text,
  date date NOT NULL,
  shift_code text NOT NULL,
  department text,
  updated_by text,
  updated_at timestamptz DEFAULT now(),
  UNIQUE(emp_no, date)
);

-- 6. Create BiometricRawPunches table
CREATE TABLE public.biometric_raw_punches (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  emp_identifier text NOT NULL,
  type text NOT NULL CHECK (type IN ('I', 'O')),
  timestamp timestamp NOT NULL,
  date date NOT NULL,
  time text NOT NULL,
  device_id text,
  raw_line text,
  UNIQUE(emp_identifier, timestamp, type)
);

-- 7. Create OTRecords table
CREATE TABLE public.ot_records (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  emp_no text NOT NULL,
  gid text,
  date date NOT NULL,
  original_date date,
  start_time text NOT NULL,
  end_time text NOT NULL,
  hours numeric NOT NULL,
  rate numeric NOT NULL,
  reason text,
  approved_by text,
  is_retroactive boolean DEFAULT false,
  retroactive_target_date date,
  status text DEFAULT 'Pending_Admin_Review'
);

-- 8. Create OtherAllowances table
CREATE TABLE public.other_allowances (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  emp_no text NOT NULL,
  gid text,
  month_year text NOT NULL,
  date date,
  team_emergency numeric DEFAULT 0,
  shift_allowance numeric DEFAULT 0,
  standby_allowance numeric DEFAULT 0,
  remark text
);

-- Enable RLS (Row Level Security) and allow public access for easy migration initially
ALTER TABLE public.user_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.departments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.employees ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shift_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_shift_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.biometric_raw_punches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ot_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.other_allowances ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow all public read user_accounts" ON public.user_accounts FOR SELECT USING (true);
CREATE POLICY "Allow all public insert user_accounts" ON public.user_accounts FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update user_accounts" ON public.user_accounts FOR UPDATE USING (true);

CREATE POLICY "Allow all public read departments" ON public.departments FOR SELECT USING (true);
CREATE POLICY "Allow all public insert departments" ON public.departments FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update departments" ON public.departments FOR UPDATE USING (true);

CREATE POLICY "Allow all public read employees" ON public.employees FOR SELECT USING (true);
CREATE POLICY "Allow all public insert employees" ON public.employees FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update employees" ON public.employees FOR UPDATE USING (true);

CREATE POLICY "Allow all public read shift_codes" ON public.shift_codes FOR SELECT USING (true);
CREATE POLICY "Allow all public insert shift_codes" ON public.shift_codes FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update shift_codes" ON public.shift_codes FOR UPDATE USING (true);

CREATE POLICY "Allow all public read daily_shift_plans" ON public.daily_shift_plans FOR SELECT USING (true);
CREATE POLICY "Allow all public insert daily_shift_plans" ON public.daily_shift_plans FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update daily_shift_plans" ON public.daily_shift_plans FOR UPDATE USING (true);

CREATE POLICY "Allow all public read biometric_raw_punches" ON public.biometric_raw_punches FOR SELECT USING (true);
CREATE POLICY "Allow all public insert biometric_raw_punches" ON public.biometric_raw_punches FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update biometric_raw_punches" ON public.biometric_raw_punches FOR UPDATE USING (true);

CREATE POLICY "Allow all public read ot_records" ON public.ot_records FOR SELECT USING (true);
CREATE POLICY "Allow all public insert ot_records" ON public.ot_records FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update ot_records" ON public.ot_records FOR UPDATE USING (true);

CREATE POLICY "Allow all public read other_allowances" ON public.other_allowances FOR SELECT USING (true);
CREATE POLICY "Allow all public insert other_allowances" ON public.other_allowances FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow all public update other_allowances" ON public.other_allowances FOR UPDATE USING (true);
