DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS question CASCADE;
DROP TABLE IF EXISTS answer CASCADE;

CREATE TABLE player(
    player_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    skill_level SMALLINT NOT NULL,
    score INT NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    theme VARCHAR(20) NOT NULL
);

CREATE TABLE question(
    question_id SERIAL PRIMARY KEY,
    skill_level SMALLINT NOT NULL,
    question VARCHAR(200) NOT NULL
);

CREATE TABLE answer(
    answer_id SERIAL PRIMARY KEY,
    question_id INT REFERENCES question (question_id),
    answer VARCHAR(200) NOT NULL,
    is_correct BOOLEAN NOT NULL
);