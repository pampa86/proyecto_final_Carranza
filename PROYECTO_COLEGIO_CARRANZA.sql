CREATE DATABASE PROYECTO_COLEGIO;
USE PROYECTO_COLEGIO;

CREATE TABLE Materias(
    Id_Curricula INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nombre_Materia VARCHAR(45) UNIQUE
);
CREATE TABLE Profesor (
    Id_Profesor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email VARCHAR(45) NOT NULL,
    Nombre VARCHAR(45) NOT NULL,
    Apellido VARCHAR(45) NOT NULL,
    Edad INT NOT NULL,
    Direccion_Residencia VARCHAR(50) NOT NULL,
    Id_Curricula INT,
    Id_Alumno INT , 
    FOREIGN KEY (Id_Curricula) REFERENCES Materias(Id_Curricula)
    
);

CREATE TABLE Alumnos (
    Id_Alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(45) NOT NULL,
    Apellido VARCHAR(45) NOT NULL,
    Edad INT NOT NULL,
    Direccion_Residencia VARCHAR(50) NOT NULL,
    id_profesor INT,
     FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
    
);


CREATE TABLE Curso (
    id_curso INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    descripcion VARCHAR(45) NOT NULL,
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES Profesor(Id_Profesor)
);



CREATE TABLE inscripciones (
    id_inscripcion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fecha_inscripcion DATE,
    Id_Alumno INT,
    id_curso INT,
    FOREIGN KEY (Id_Alumno) REFERENCES Alumnos(Id_Alumno),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Calificaciones (
    Id_calificacion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Id_Alumno INT,
    Id_Curricula INT,
    FOREIGN KEY (Id_Alumno) REFERENCES Alumnos(Id_Alumno),
    FOREIGN KEY (Id_Curricula) REFERENCES Materias(Id_Curricula)
);

---Tabla de Apoyo de materias: en MATERIAS se pone UNIQUE a nombre de materias para poder hacer ref en Tutoria
CREATE TABLE Tutoria (
id_tutoria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Id_Curricula INT,
Id_Profesor INT,
Nombre_Materia varchar(45),
FOREIGN KEY (Id_Curricula) REFERENCES Materias(Id_Curricula),
FOREIGN KEY (Nombre_Materia) REFERENCES Materias(Nombre_Materia),
FOREIGN KEY (id_profesor) REFERENCES Profesor(Id_Profesor)
);

CREATE TABLE Notas (
    Id_nota INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Id_Curricula INT,
    Id_Alumno INT ,
    FOREIGN KEY (Id_Curricula) REFERENCES Materias(Id_Curricula),
    FOREIGN KEY (Id_Alumno) REFERENCES Alumnos(Id_Alumno)
  
);
--------
--insert MATERIAS
INSERT MATERIAS (Id_Curricula,Nombre_Materia)
VALUES ( 1,'LENGUA');
INSERT MATERIAS (Id_Curricula,Nombre_Materia)
VALUES ( 2,'CIENCIAS');
INSERT MATERIAS (Id_Curricula,Nombre_Materia)
VALUES ( 3,'MATEMATICAS');

--INSERT PROFESORES
INSERT PROFESOR (Id_Profesor, email, Nombre, Apellido,Edad,Direccion_Residencia,Id_Curricula,Id_Alumno)
VALUES (10,'lengua@gmail.com','Tomas','Perez',42,'Rivera 150',1,1);

INSERT PROFESOR (Id_Profesor, email, Nombre, Apellido,Edad,Direccion_Residencia,Id_Curricula,Id_Alumno)
VALUES (11,'ciencias@gmail.com','Jose','Lopez',38,'Viso 500',2,2);

INSERT PROFESOR (Id_Profesor, email, Nombre, Apellido,Edad,Direccion_Residencia,Id_Curricula,Id_Alumno)
VALUES (44,'matematicas@gmail.com','Maria','Asuncion',50,'Cabrera 10',3,3);


--INSERT ALUMNOS
INSERT alumnos(Id_Alumno,Nombre,Apellido,Edad,Direccion_Residencia,id_profesor)
VALUES (1,'Romina', 'Carranza', 38, 'J.A.Sarachaga' , 10);

INSERT alumnos(Nombre,Apellido,Edad,Direccion_Residencia,id_profesor)
VALUES ('Ana', 'Santamarina',10 ,'J.A.Sarachaga 1166' ,11 );

INSERT alumnos(Nombre,Apellido,Edad,Direccion_Residencia,id_profesor)
VALUES ('Carolina', 'Sanz',10 ,'Gral Paz 6' ,44 );

--select
select * from alumnos;
select * from profesor;

-----------------------------------------
---Procedimiento Almacenado Ver Materias actuales dictandose en dicha INSTITUCIÓN.

use proyecto_colegio;
DELIMITER $$

create procedure VerMaterias()

BEGIN
	SELECT * FROM MATERIAS;
END$$    
DELIMITER ;

--llamada
call VerMaterias ();

----Procedimiento Almacenado Obtener datos de Alumnos ingresando su ID.

DELIMITER $$

create procedure GetAlumnos( IN Id_Alum INT)

BEGIN
	SELECT * FROM alumnos where Id_Alumno= Id_Alum ;
END$$    
DELIMITER ;

--LLAMADA A PROCEDURE GetAlumnos

CALL GetAlumnos(3);


---Insertar un NUEVO ALUMNO y LUEGO VALIDAR EL NUEVO ALUMNO CREADO.
DELIMITER $$

create procedure GuardarAlumno( IN 
Id_Alum INT,
name varchar(50),
Apel varchar(50),
Ed int,
dire varchar(50),
id_prof int)

BEGIN
	INSERT INTO alumnos( Id_Alumno,Nombre,Apellido ,Edad  ,Direccion_Residencia ,id_profesor)
    VALUES(Id_Alum ,name ,Apel ,Ed ,dire ,id_prof );
	SELECT * FROM alumnos where Id_Alumno= Id_Alum ;
END$$    
DELIMITER ;

----llamada 
call GuardarAlumno(null,'Patricio','Martinez', 14 , 'Rivadavía' ,44 );

--Validación de ALUMNO CREADO.
select * from alumnos

--------------FUNCIONES--------
--Función ObtenerNombreDeAlumno  -- Concatenar el nombre y el apellido
--READS SQL DATA lee datos de la base de datos, pero no los modifica

DELIMITER $$

CREATE FUNCTION ObtenerNombreDeAlumno(alu INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE Nom VARCHAR(100);
    DECLARE Apel VARCHAR(100);
    DECLARE NombreCompleto VARCHAR(200);
    
    SELECT Nombre,Apellido INTO Nom, Apel FROM alumnos WHERE Id_Alumno = alu;
    
   
	SET NombreCompleto = CONCAT(Nom, ' ', Apel);
    RETURN NombreCompleto;
    
END $$

DELIMITER ;

---llamada
 select * from alumnos
SELECT ObtenerNombreDeAlumno(3);


-----------
-------Función ObtenerProfesorMateria  -- Concatenar el nombre y el apellido del Profesor
--Función OBTNER que profesor da determinada MATERIA--

DELIMITER $$
CREATE FUNCTION ObtenerProfesorMateria(Mat int)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE Nom VARCHAR(100);
    DECLARE Apel VARCHAR(100);
    DECLARE NombreCompleto VARCHAR(200);
    
    SELECT Nombre,Apellido INTO Nom, Apel FROM profesor WHERE Id_Curricula = Mat ;
    
	SET NombreCompleto = CONCAT(Nom, ' ', Apel);
    RETURN NombreCompleto;
    
END $$
DELIMITER ;


    select ObtenerProfesorMateria(2);
    


-----FUNCION ObtenerProfesorDeAlumno----
   DELIMITER $$

CREATE FUNCTION ObtenerProfesorDeAlumno(alu INT)
RETURNS VARCHAR(300)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE respuesta VARCHAR(300) DEFAULT '';
    DECLARE profesor_nombre VARCHAR(45);
    DECLARE profesor_apellido VARCHAR(45);
    
    -- Manejar la situación en la que no se encuentra un profesor
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    SET respuesta = 'No se encontró el profesor para el alumno especificado';

    -- Seleccionar el nombre y apellido del profesor
    SELECT p.Nombre, p.Apellido
    INTO profesor_nombre, profesor_apellido
    FROM Alumnos a
    JOIN Profesor p ON a.id_profesor = p.Id_Profesor
    WHERE a.Id_Alumno = alu;

    -- Concatenar la respuesta si se encuentra el profesor
    IF respuesta = '' THEN
        SET respuesta = CONCAT('El profesor es ', profesor_nombre, ' ', profesor_apellido);
    END IF;

    RETURN respuesta;
END $$

DELIMITER ;


---llamada 
    SELECT ObtenerProfesorDeAlumno(1);
    
 
---
--------VISTAS
------
-- Vista 1--vista_alumnos_profesor


    
CREATE VIEW vista_alumnos_profesor AS
    SELECT a.Id_Alumno,a.Nombre,a.Apellido ,a.Edad,a.Direccion_Residencia,a.id_profesor,m.Nombre_Materia
    From alumnos a
   inner join 
   profesor p ON a.id_profesor= p.Id_Profesor
   inner join 
   materias m ON p.Id_Curricula= m.Id_Curricula;
   
--LLAMADA a La Vista:
Select * from vista_alumnos_profesor; 
   

-- Vista 2--vista_alumnos_tutoria


CREATE VIEW vista_alumnos_tutoria AS
    SELECT a.Id_Alumno,a.Nombre,a.Apellido ,a.Edad,a.Direccion_Residencia,m.Nombre_Materia
    From alumnos a
   inner join 
   calificaciones c ON a.Id_Alumno= c.Id_Alumno
   inner join 
   materias m ON c.Id_Curricula= m.Id_Curricula;
   
 --- - Vista 3 --LLAMADA a La Vista:---
select * from  vista_alumnos_tutoria


    ---VISTA view_administracion
    
USE PROYECTO_COLEGIO;
create or replace view
proyecto_colegio.view_administracion
AS (
SELECT
    Id_Alumno
,    Nombre
, Apellido
,id_profesor
FROM proyecto_colegio.alumnos
LIMIT 10
);
---------
---------TRIGGERS----
---se debió aplicar  Eliminar en cascada (ON DELETE CASCADE) para poder ejecutar el trigger de eliminar el ID_Alumno
--ya que impedía eliminar por la relación de FK.en tablas  (calificaciones e inscripciones)

ALTER TABLE calificaciones
DROP FOREIGN KEY calificaciones_ibfk_1;

ALTER TABLE calificaciones
ADD CONSTRAINT calificaciones_ibfk_1 
FOREIGN KEY (Id_Alumno) REFERENCES alumnos(Id_Alumno)
ON DELETE CASCADE;


ALTER TABLE inscripciones
DROP FOREIGN KEY inscripciones_ibfk_1;

ALTER TABLE inscripciones
ADD CONSTRAINT inscripciones_ibfk_1 
FOREIGN KEY (Id_Alumno) REFERENCES alumnos(Id_Alumno)
ON DELETE CASCADE;
-----------------

USE PROYECTO_COLEGIO;
--importante
--BEFORE INSERT (ANTES)   --BEFORE DELETE 	--BEFORE UPDATE 
--AFTER INSERT( DESP ) 	   --AFTER DELETE	    --AFTER UPDATE
--INFORMACIÓN : TRIGGER GUARDAR_ALUMNOS_ELIMINADOS
--BEFORE DELETE se ejecutará antes de que se elimine un registro en la tabla alumnos.
--FOR EACH ROW:- Significa que el trigger se ejecutará una vez por cada fila que se elimine.
-- INSERT INTO alumnos_aud_eliminados-Inserta los valores del registro que se va a eliminar en la tabla de auditoría alumnos_aud_eliminados.

---TRIGGER  1: 
DELIMITER //

CREATE TRIGGER GUARDAR_ALUMNOS_ELIMINADOS
BEFORE DELETE ON alumnos
FOR EACH ROW
BEGIN
    INSERT INTO alumnos_aud_eliminados (Id_Alumno, Nombre, Apellido, Edad, Direccion_Residencia, id_profesor)
    VALUES (OLD.Id_Alumno, OLD.Nombre, OLD.Apellido, OLD.Edad, OLD.Direccion_Residencia, OLD.id_profesor);
END;
//

DELIMITER ;

---VALIDACIÓN ---TRIGGER  1:: GUARDAR_ALUMNOS_ELIMINADOS
--1° Eliminar  un Id_alumno válido (1	Romina	Carranza	38	J.A.Sarachaga	10)
DELETE FROM alumnos WHERE Id_Alumno = 1;
	
    
    
--2° verificar que el dato fue llevado a la tabla de auditoria  alumnos_aud_eliminados
SELECT * FROM alumnos_aud_eliminados WHERE Id_Alumno = 1;



---TRIGGER  2: trigger q diga recuerde ingresar ID de Alumno y Apellido
--utilizar una excepción para forzar un error 
DELIMITER //

CREATE TRIGGER validar_id_apellido_alumno
BEFORE INSERT ON alumnos
FOR EACH ROW
BEGIN
    IF NEW.Id_Alumno IS NULL OR NEW.Id_Alumno = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Recuerde ingresar el ID del alumno.';
    END IF;

    IF NEW.Apellido IS NULL OR NEW.Apellido = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Recuerde ingresar el teléfono del alumno.';
    END IF;
END;
//

DELIMITER ;

---VALIDACIÓN ---TRIGGER  2::validar_id_apellido_alumno  Error Code:

--Inserción correcta 
INSERT INTO alumnos (Id_Alumno, Nombre, Apellido, Edad, Direccion_Residencia, id_profesor)
VALUES (50, 'Maria', 'Toreal', 20, 'Calle 9', 10);

--ejecución para validar error -->Error Code: 1644. Error: Recuerde ingresar el ID del alumno.
INSERT INTO alumnos (Id_Alumno, Nombre, Apellido, Edad, Direccion_Residencia, id_profesor)
VALUES (null, 'Juana', 'Toreal', 20, 'Calle 9', 10);


----VERIFICACIÓN -----------
--Datos--
select * from profesor (10-11-44)

select * from alumnos (2,3,4,6,50)
---------------------------

CREATE TABLE ALUMNOS_AUD_ELIMINADOS(
    Id_Alumno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nombre VARCHAR(45) NOT NULL,
    Apellido VARCHAR(45) NOT NULL,
    Edad INT NOT NULL,
    Direccion_Residencia VARCHAR(50) NOT NULL,
    id_profesor INT,
     FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)    
);

----VERIFICACIÓN --------
select * from ALUMNOS_AUD_ELIMINADOS

---------------------------
----------------------------------------------------
 -------------INFORMACIÓN-------------------
 ---------------------------------------------
 --Para Borrar el usaurio
 DROP USER 'romina'@'%'
 
 --rename user (renombrar) rename  'romina'@'%' TO 'juana'@'%';
 
 
 ----------------CREACIÓN DE ROLES
 --CREATE ROLE 'ADMINISTRADOR'
 
 -----------PERMISOS DE ROLES
 GRANT SELECT, INSERT, UPDATE, DELETE ON escuela.alumno TO ' administrador';
 
 --------asignar roles
 GRANT ' administrador' TO ' romina@'localhost';
 
 --------------revoke todos los PERMISOS
 REVOKE ALL RIVILEGIES ON *.* FROM  'romina'@'%';
 
 ---------actualización de privilegios
 FLUSH PRIVILEGES;
 
 ----------------PARA VER TODOS LOS USUARIO CONECTADOS A LA BASE
 SHOW PROCESSLIST
 
 -------ACTIVIDAD 
 --1° CREACIÓN DE -USUARIOS--
  CREATE USER  'romina'@'%' IDENTIFIED BY '1234';  
  GRANT ALL PRIVILEGES ON *.* TO 'romina'@'%' with grant option; -- --permisos de super usuario/absolutos
  
  CREATE USER  'maria'@'%' IDENTIFIED BY '2024'; 
  GRANT SELECT ON proyecto_colegio.alumnos TO 'maria'@'%';
  
  CREATE USER  'Paula'@'%' IDENTIFIED BY '2024';
  GRANT SELECT ON proyecto_colegio.notas TO 'Paula'@'%';
  
   CREATE USER  'cecilia'@'%' IDENTIFIED BY '56789';  
GRANT ALL PRIVILEGES ON  coderhouse_gamers.* TO 'cecilia'@'%' ;  

  --2°----CREACIÓN  -ROLES-PERMISOS
 CREATE ROLE 'ADMINISTRADOR'
 --PERMISOS DE ROLES
 GRANT SELECT, INSERT, UPDATE, DELETE ON proyecto_colegio.alumnos TO ' ADMINISTRADOR';
 ----------------PERMISOS--------
   CREATE ROLE 'PRECEPETOR'
   GRANT SELECT, INSERT, UPDATE , DELETE ON proyecto_colegio.NOTAS TO ' PRECEPETOR';---
   
 -----asignar roles
 GRANT ' ADMINISTRADOR' TO  'romina'@'%';
 GRANT ' ADMINISTRADOR' TO  'maria'@'%';

-------------------------------------------------------------------
 --Verifico su creación
 ----- select * From mysql.user -------
 ------------------------------------------
 --3° -PERMISO A UNA SOLA BASE DE DATOS
 CREATE USER  'cecilia'@'%' IDENTIFIED BY '56789';  
GRANT ALL PRIVILEGES ON  coderhouse_gamers.* TO 'cecilia'@'%' ;  
-------------------

  --4°-PERMISO A TABLAS/ VISTAS/ 
 
  GRANT SELECT ON proyecto_colegio.alumnos TO 'maria'@'%';
  
  GRANT SELECT ON proyecto_colegio.vista_alumnos_profesor TO 'maria'@'%';

  ---5--PERMISOS DE INSERCIÓN / DELETE/ UPDATE
   
 
--PERMISOS DE INSERCIÓN A 2 USUARIOS
GRANT INSERT ON proyecto_colegio.alumnos TO 'maria'@'%';
GRANT INSERT ON proyecto_colegio.alumnos TO 'romina'@'%';

--PERMISOS DE DELETE A 2 USUARIOS
GRANT DELETE ON proyecto_colegio.alumnos TO 'maria'@'%';
GRANT DELETE ON proyecto_colegio.alumnos TO 'romina'@'%';

--PERMISOS DE INSERSIÓN A la tabla NOTAS a 1 USUARIO

GRANT INSERT ON proyecto_colegio.NOTAS TO 'romina'@'%';
GRANT DELETE ON proyecto_colegio.NOTAS TO 'romina'@'%';
GRANT UPDATE ON proyecto_colegio.NOTAS TO 'romina'@'%';


----------





















------------------------------------------
 -------------INFORMACIÓN-------------------
 ---------------------------------------------
 --Para Borrar el usaurio
 DROP USER 'romina'@'%'
 
 --rename user (renombrar) rename  'romina'@'%' TO 'juana'@'%';
 
 
 ----------------CREACIÓN DE ROLES
 --CREATE ROLE 'ADMINISTRADOR'
 
 -----------PERMISOS DE ROLES
 GRANT SELECT, INSERT, UPDATE, DELETE ON escuela.alumno TO ' administrador';
 
 --------asignar roles
 GRANT ' administrador' TO ' romina@'localhost';
 
 --------------revoke todos los PERMISOS
 REVOKE ALL RIVILEGIES ON *.* FROM  'romina'@'%';
 
 ---------actualización de privilegios
 FLUSH PRIVILEGES;
 
 ----------------PARA VER TODOS LOS USUARIO CONECTADOS A LA BASE
 SHOW PROCESSLIST
 
 -------ACTIVIDAD 
 --1° CREACIÓN DE -USUARIOS--
  CREATE USER  'romina'@'%' IDENTIFIED BY '1234';  
  GRANT ALL PRIVILEGES ON *.* TO 'romina'@'%' with grant option; -- --permisos de super usuario/absolutos
  
  CREATE USER  'maria'@'%' IDENTIFIED BY '2024'; 
  GRANT SELECT ON proyecto_colegio.alumnos TO 'maria'@'%';
  
  CREATE USER  'Paula'@'%' IDENTIFIED BY '2024';
  GRANT SELECT ON proyecto_colegio.notas TO 'Paula'@'%';
  
   CREATE USER  'cecilia'@'%' IDENTIFIED BY '56789';  
GRANT ALL PRIVILEGES ON  coderhouse_gamers.* TO 'cecilia'@'%' ;  

  --2°----CREACIÓN  -ROLES-PERMISOS
 CREATE ROLE 'ADMINISTRADOR'
 --PERMISOS DE ROLES
 GRANT SELECT, INSERT, UPDATE, DELETE ON proyecto_colegio.alumnos TO ' ADMINISTRADOR';
 ----------------PERMISOS--------
   CREATE ROLE 'PRECEPETOR'
   GRANT SELECT, INSERT, UPDATE , DELETE ON proyecto_colegio.NOTAS TO ' PRECEPETOR';---
   
 -----asignar roles
 GRANT ' ADMINISTRADOR' TO  'romina'@'%';
 GRANT ' ADMINISTRADOR' TO  'maria'@'%';

-------------------------------------------------------------------
 --Verifico su creación
 ----- select * From mysql.user -------
 ------------------------------------------
 --3° -PERMISO A UNA SOLA BASE DE DATOS
 CREATE USER  'cecilia'@'%' IDENTIFIED BY '56789';  
GRANT ALL PRIVILEGES ON  coderhouse_gamers.* TO 'cecilia'@'%' ;  
-------------------

  --4°-PERMISO A TABLAS/ VISTAS/ 
 
  GRANT SELECT ON proyecto_colegio.alumnos TO 'maria'@'%';
  
  GRANT SELECT ON proyecto_colegio.vista_alumnos_profesor TO 'maria'@'%';

  ---5--PERMISOS DE INSERCIÓN / DELETE/ UPDATE
   
 
--PERMISOS DE INSERCIÓN A 2 USUARIOS
GRANT INSERT ON proyecto_colegio.alumnos TO 'maria'@'%';
GRANT INSERT ON proyecto_colegio.alumnos TO 'romina'@'%';

--PERMISOS DE DELETE A 2 USUARIOS
GRANT DELETE ON proyecto_colegio.alumnos TO 'maria'@'%';
GRANT DELETE ON proyecto_colegio.alumnos TO 'romina'@'%';

--PERMISOS DE INSERSIÓN A la tabla NOTAS a 1 USUARIO

GRANT INSERT ON proyecto_colegio.NOTAS TO 'romina'@'%';
GRANT DELETE ON proyecto_colegio.NOTAS TO 'romina'@'%';
GRANT UPDATE ON proyecto_colegio.NOTAS TO 'romina'@'%';

