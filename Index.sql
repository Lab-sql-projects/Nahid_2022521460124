-- Step 3: Create Index on Email Column

-- Create an index on the email column
CREATE INDEX idx_email ON members(email);

-- Verify the index
PRAGMA index_list('members');
