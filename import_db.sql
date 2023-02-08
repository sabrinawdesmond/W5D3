PRAGMA foreign_keys = ON
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);
DROP TABLE IF EXISTS questions;

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    questions_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    parent_reply_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    body TEXT,
    questions_title TEXT NOT NULL,
    questions_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (questions_title) REFERENCES questions(title),
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS questions_likes;

CREATE TABLE questions_likes(
    likes INTEGER,
    questions_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

INSERT INTO
    users(fname, lname)
VALUES
    ('John', 'Smith'),
    ('Jane', 'Doe');

INSERT INTO
    questions(title, body, users_id)
VALUES
    ('Why AA?', 'adfadfaefkj', SELECT id FROM users WHERE fname = 'John' AND lname = 'Smith'),
    ('Why todya?', 'adfafdafdaf', SELECT id FROM useres WHERE fname = 'Jane' AND lname = 'Doe');

