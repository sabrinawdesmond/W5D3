PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS questions_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);


CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id)
);



CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    questions_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);



CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    parent_reply_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    body TEXT,
    questions_title TEXT NOT NULL,
    questions_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);



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
    ('Why AA?', 'adfadfaefkj', 1),
    ('Why todya?', 'adfafdafdaf', 2);

