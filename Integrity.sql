-- Step 2: Add Integrity Constraints

-- Add NOT NULL constraint to the email column
ALTER TABLE members
ADD CONSTRAINT email_not_null CHECK (email IS NOT NULL);

-- Add CHECK constraint to membership_type
ALTER TABLE members
ADD CONSTRAINT membership_type_check CHECK (membership_type IN ('VIP', 'Standard'));

-- Verify changes
PRAGMA table_info(members);
