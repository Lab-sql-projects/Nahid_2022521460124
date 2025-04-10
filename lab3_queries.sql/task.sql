-- Add CHECK constraint to ensure valid join_date (not in the future)
ALTER TABLE members
ADD CONSTRAINT chk_join_date CHECK (join_date <= DATE('now'));

-- Add UNIQUE constraint to make sure emails are not duplicated
ALTER TABLE members
ADD CONSTRAINT unique_email UNIQUE (email);
