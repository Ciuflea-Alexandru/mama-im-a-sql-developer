-- Create a table called test that contains id, test_name and the date it was created at

CREATE TABLE test (
    id SERIAL PRIMARY KEY,
    test_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
