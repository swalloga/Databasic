DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS houses;


CREATE TABLE pets (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE people (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  house_id INTEGER,

  FOREIGN KEY(house_id) REFERENCES human(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO
  houses (id, address)
VALUES
  (1, "26th and Guerrero"), (2, "Dolores and Market");

INSERT INTO
  people (id, fname, lname, house_id)
VALUES
  (1, "Sarah", "Walloga", 1),
  (2, "Esther", "Pong", 1),
  (3, "Emily", "Turner", 2),
  (4, "Petless", "Person", NULL);

INSERT INTO
  pets (id, name, owner_id)
VALUES
  (1, "Drake", 1),
  (2, "Justin Bieber", 2),
  (3, "Alvin", 3),
  (4, "Shadow", 3),
  (5, "Mufasa", NULL);
