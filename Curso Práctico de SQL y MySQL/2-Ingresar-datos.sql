-- Esquema de como ingresar datos a las tablas
INSERT INTO tablas(columnas*) VALUES (valores*);


INSERT INTO authors(author_id, name, nationality) 
VALUES ('', 'Juan Rulfo', 'MEX');
-- Si el campo es autoincrementable no es necesario ingresar el valor, se puede dejar vacío
-- MARÍA DB no permite dejar el campo vacío, se puede ingresar NULL

INSERT INTO authors(name, nationality) VALUES 
-- author_id es autoincrementable, no es necesario colocarlo
('Juan Rulfo', 'MEX'),
('Gabriel García Márquez', 'COl'),
('Juan Gabriel Vasquez', 'COL');

INSERT INTO authors VALUES 
('', 'Juan Gabriel Vasquez', 'COL');
-- MARÍA DB no permite dejar el campo vacío, se puede ingresar NULL

ALTER TABLE `authors`
MODIFY `nationality` VARCHAR(3) NOT NULL DEFAULT 'NUL' COMMENT 'ISO 3166-1 Country Code';


INSERT INTO authors(name, nationality) VALUES 
('Julio Cortázar', 'ARG'),
('Isabel Allende', 'CHL'),
('Octavio Paz', 'MEX');
INSERT INTO authors(name, nationality) VALUES 
('Hernan Rivera Leterier', 'CHL'),
('Juan Carlos Onetti', 'URY');


INSERT INTO authors(author_id, name) VALUES
(16, 'Pablo Neruda'),
(17, 'Mario Vargas Llosa');


INSERT INTO `clients`(client_id, name, email, birthdate, gender, active, created_at) VALUES 
(1,'Maria Dolores Gomez','Maria Dolores.95983222J@random.names','1971-06-06','F',1,'2018-04-09 16:51:30'),
(2,'Adrian Fernandez','Adrian.55818851J@random.names','1970-04-09','M',1,'2018-04-09 16:51:30'),
(3,'Maria Luisa Marin','Maria Luisa.83726282A@random.names','1957-07-30','F',1,'2018-04-09 16:51:30'),
(4,'Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',1,'2018-04-09 16:51:30'),

-- DUPLICADOS
INSERT INTO `clients`(client_id, name, email, birthdate, gender, active, created_at) VALUES 
(4,'Pedro Sanchez','Pedro.78522059J@random.names','1992-01-31','M',0,'2018-04-09 16:51:30')
ON DUPLICATE KEY UPDATE active = VALUES(active);


-- Books
INSERT INTO `books`(title, author_id) VALUES
('El Laberinto de la soledad', 6);

INSERT INTO `books`(title, author_id, `year`) VALUES
('Vuelta al laberinto de la soledad',
    (SELECT author_id FROM `authors` 
    WHERE name = 'Octavio Paz'
    LIMIT 1
    ), 1960
);