# proyecto_final_Carranza

# PROYECTO EDUCATIVO

### PRESENTACIÓN DE BASE DE DATOS PARA UN INSTITUTO EDUCATIVO - PRIMERA ENTREGA

### ALUMNA: CARRANZA ROMINA

### COMISIÓN:57190

### PROFESOR: ANDERSON OCAÑA


### Problemática del negocio

La Institución tiene el inconveniente de el registro de alumnos inscriptos al comienzo de cada año lectivo y su renovación así como también la visibilidad de materias y sus calificaciones.
### Descripción 
El proceso se hace manual a travez de planillas, las cuales se archivan en distintas carpetas con información de cada alumno como de profesores de cada materia.
### Objetivo
Desarrollar una base de datos , que permita el control eficiente de registros, facilitando así a los directivos brindas cupos así como también la visibilidad de materias aprobadas de cada alumno.





## TABLAS

- 1 Alumnos: Describe información personal-legal  del alumno registrado con atributos:
`Id_Alumno`,`Nombre`,`Apellido`,`Edad`,`Direccion_Residencia`,`id_profesor`

- 2 Calificaciones:Almacena información de Calificaciones obtenidas de examenes de cada una de las materias con atributos:`Id_calificacion`,`Id_Alumno`,`Id_Curricula`,`calificaciones`

- 3 Curso:Almacena información del curso al que pertenece con atributos:
`id_curso`,`descripcion`,`id_profesor`,`curso`

- 4 Inscripciones: Almacena información del registro-matriculación del  alumno/a con atributos: `id_inscripcion`,`fecha_inscripcion`,`Id_Alumno`,`id_curso`,`inscripciones`
- 5 Materias: con atributos:`Id_Curricula`, `Nombre_Materia`

- 6 Profesores Describe información personal-legal  del profesor registrado y de la materia en la que se encontrará asignado con atributos:`Id_Profesor`,`email`,`Nombre`,`Apellido`,`Edad`,`Direccion_Residencia`,`Id_Curricula`,`profesor`
  
  Cada tabla tiene una clave primaria (PRIMARY KEY) las cuales permiten la relación entre tablas mediante claves foreanas (FOREIGN KEY).
## Triggers
Validación ante un evento determinado,como es el de un Alumno eliminado el cual es guardado en la tabla Auditoria,y en insertar un nuevo alumno el mje de 
recordar datos importantes a ser cargados.

## CREACIÓN de USUARIOS -ROLES-PERMISOS
Se busca determinar a que usaurio dado un determinado rol, tiene ese acceso a la Base para realizar determinada acción.

  ## Adjunto Diagrama entidad relación.

  ![image](https://github.com/user-attachments/assets/39bf86e3-aa1c-4938-8c59-e9b0a1bd815b)

  
