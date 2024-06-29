CREATE TABLE asignacion (
    carnet  INTEGER NOT NULL,
    codigo  INTEGER NOT NULL,
    seccion VARCHAR2(2) NOT NULL,
    anio    VARCHAR2(4) NOT NULL,
    ciclo   VARCHAR2(50) NOT NULL,
    zona    INTEGER NOT NULL,
    nota    INTEGER NOT NULL
)
LOGGING;

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_pk PRIMARY KEY ( anio,
                                               ciclo,
                                               carnet,
                                               seccion,
                                               codigo );

CREATE TABLE carrera (
    carrera INTEGER NOT NULL,
    nombre  VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE carrera ADD CONSTRAINT carrera_pk PRIMARY KEY ( carrera );

CREATE TABLE catedratico (
    cat           INTEGER NOT NULL,
    nombre        VARCHAR2(50) NOT NULL,
    sueldomensual NUMBER NOT NULL
)
LOGGING;

ALTER TABLE catedratico ADD CONSTRAINT catedratico_pk PRIMARY KEY ( cat );

CREATE TABLE curso (
    codigo INTEGER NOT NULL,
    nombre VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( codigo );

CREATE TABLE dia (
    dia    INTEGER NOT NULL,
    nombre VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE dia ADD CONSTRAINT dia_pk PRIMARY KEY ( dia );

CREATE TABLE estudiante (
    carnet          INTEGER NOT NULL,
    nombre          VARCHAR2(50) NOT NULL,
    fechanacimiento DATE
)
LOGGING;

ALTER TABLE estudiante ADD CONSTRAINT estudiante_pk PRIMARY KEY ( carnet );

CREATE TABLE horario (
    seccion              VARCHAR2(2) NOT NULL,
    anio                 VARCHAR2(4) NOT NULL,
    ciclo                VARCHAR2(50) NOT NULL,
    periodo              INTEGER NOT NULL,
    dia                  INTEGER NOT NULL,
    edificio             VARCHAR2(10),
    salon                VARCHAR2(10),
    seccion_curso_codigo INTEGER NOT NULL
)
LOGGING;

ALTER TABLE horario
    ADD CONSTRAINT horario_pk PRIMARY KEY ( seccion,
                                            anio,
                                            ciclo,
                                            periodo,
                                            dia,
                                            seccion_curso_codigo );

CREATE TABLE inscrito (
    carrera          INTEGER NOT NULL,
    carnet           INTEGER NOT NULL,
    fechainscripcion DATE NOT NULL
)
LOGGING;

ALTER TABLE inscrito ADD CONSTRAINT inscrito_pk PRIMARY KEY ( carrera,
                                                              carnet );

CREATE TABLE pensum (
    curso_codigo    INTEGER NOT NULL,
    plan            VARCHAR2(10) NOT NULL,
    carrera         INTEGER NOT NULL,
    obligatiedad    CHAR(1) NOT NULL,
    numcreditos     INTEGER NOT NULL,
    notaaprobatoria INTEGER NOT NULL,
    zonaminima      INTEGER NOT NULL,
    credprerreq     INTEGER NOT NULL
)
LOGGING;

ALTER TABLE pensum
    ADD CONSTRAINT pensum_pk PRIMARY KEY ( plan,
                                           carrera,
                                           curso_codigo );

CREATE TABLE periodo (
    periodo    INTEGER NOT NULL,
    horainicio DATE NOT NULL,
    horafinal  DATE NOT NULL
)
LOGGING;

ALTER TABLE periodo ADD CONSTRAINT periodo_pk PRIMARY KEY ( periodo );

CREATE TABLE plan (
    plan              VARCHAR2(10) NOT NULL,
    carrera           INTEGER NOT NULL,
    nombre            VARCHAR2(50) NOT NULL,
    anioinicial       VARCHAR2(4) NOT NULL,
    aniofinal         VARCHAR2(4) NOT NULL,
    cicloinicial      VARCHAR2(50) NOT NULL,
    ciclofinal        VARCHAR2(50) NOT NULL,
    numcreditoscierre INTEGER NOT NULL
)
LOGGING;

ALTER TABLE plan ADD CONSTRAINT plan_pk PRIMARY KEY ( plan,
                                                      carrera );

CREATE TABLE prerreq (
    curso_codigo   INTEGER NOT NULL,
    pensum_plan    VARCHAR2(10) NOT NULL,
    pensum_carrera INTEGER NOT NULL,
    prerreq        INTEGER NOT NULL
)
LOGGING;

ALTER TABLE prerreq
    ADD CONSTRAINT prerreq_pk PRIMARY KEY ( curso_codigo,
                                            pensum_plan,
                                            pensum_carrera,
                                            prerreq );

CREATE TABLE salon (
    edificio  VARCHAR2(10) NOT NULL,
    salon     VARCHAR2(10) NOT NULL,
    capacidad INTEGER NOT NULL
)
LOGGING;

ALTER TABLE salon ADD CONSTRAINT salon_pk PRIMARY KEY ( edificio,
                                                        salon );

CREATE TABLE seccion (
    seccion      VARCHAR2(2) NOT NULL,
    anio         VARCHAR2(4) NOT NULL,
    ciclo        VARCHAR2(50) NOT NULL,
    curso_codigo INTEGER NOT NULL,
    cat          INTEGER
)
LOGGING;

ALTER TABLE seccion
    ADD CONSTRAINT seccion_pk PRIMARY KEY ( seccion,
                                            anio,
                                            ciclo,
                                            curso_codigo );

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_estudiante_fk FOREIGN KEY ( carnet )
        REFERENCES estudiante ( carnet )
    NOT DEFERRABLE;

ALTER TABLE asignacion
    ADD CONSTRAINT asignacion_seccion_fk FOREIGN KEY ( seccion,
                                                       anio,
                                                       ciclo,
                                                       codigo )
        REFERENCES seccion ( seccion,
                             anio,
                             ciclo,
                             curso_codigo )
    NOT DEFERRABLE;

ALTER TABLE horario
    ADD CONSTRAINT horario_dia_fk FOREIGN KEY ( dia )
        REFERENCES dia ( dia )
    NOT DEFERRABLE;

ALTER TABLE horario
    ADD CONSTRAINT horario_periodo_fk FOREIGN KEY ( periodo )
        REFERENCES periodo ( periodo )
    NOT DEFERRABLE;

ALTER TABLE horario
    ADD CONSTRAINT horario_salon_fk FOREIGN KEY ( edificio,
                                                  salon )
        REFERENCES salon ( edificio,
                           salon )
    NOT DEFERRABLE;

ALTER TABLE horario
    ADD CONSTRAINT horario_seccion_fk FOREIGN KEY ( seccion,
                                                    anio,
                                                    ciclo,
                                                    seccion_curso_codigo )
        REFERENCES seccion ( seccion,
                             anio,
                             ciclo,
                             curso_codigo )
    NOT DEFERRABLE;

ALTER TABLE inscrito
    ADD CONSTRAINT inscrito_carrera_fk FOREIGN KEY ( carrera )
        REFERENCES carrera ( carrera )
    NOT DEFERRABLE;

ALTER TABLE inscrito
    ADD CONSTRAINT inscrito_estudiante_fk FOREIGN KEY ( carnet )
        REFERENCES estudiante ( carnet )
    NOT DEFERRABLE;

ALTER TABLE pensum
    ADD CONSTRAINT pensum_curso_fk FOREIGN KEY ( curso_codigo )
        REFERENCES curso ( codigo )
    NOT DEFERRABLE;

ALTER TABLE pensum
    ADD CONSTRAINT pensum_plan_fk FOREIGN KEY ( plan,
                                                carrera )
        REFERENCES plan ( plan,
                          carrera )
    NOT DEFERRABLE;

ALTER TABLE plan
    ADD CONSTRAINT plan_carrera_fk FOREIGN KEY ( carrera )
        REFERENCES carrera ( carrera )
    NOT DEFERRABLE;

ALTER TABLE prerreq
    ADD CONSTRAINT prerreq_curso_fk FOREIGN KEY ( curso_codigo )
        REFERENCES curso ( codigo )
    NOT DEFERRABLE;

ALTER TABLE prerreq
    ADD CONSTRAINT prerreq_pensum_fk FOREIGN KEY ( pensum_plan,
                                                   pensum_carrera,
                                                   prerreq )
        REFERENCES pensum ( plan,
                            carrera,
                            curso_codigo )
    NOT DEFERRABLE;

ALTER TABLE seccion
    ADD CONSTRAINT seccion_catedratico_fk FOREIGN KEY ( cat )
        REFERENCES catedratico ( cat )
    NOT DEFERRABLE;

ALTER TABLE seccion
    ADD CONSTRAINT seccion_curso_fk FOREIGN KEY ( curso_codigo )
        REFERENCES curso ( codigo )
    NOT DEFERRABLE;

-- MODIFICACIONES adicionales
ALTER TABLE ESTUDIANTE
ADD (
apellido VARCHAR2(50),
correo   VARCHAR2(50),
telefono VARCHAR2(50),
direccion VARCHAR2(50),
dpi VARCHAR2(50),
carrera INTEGER,
plan VARCHAR2(10)
);

ALTER TABLE CATEDRATICO
ADD(
    apellido VARCHAR2(50),
    fecha_nacimiento DATE,
    correo   VARCHAR2(50),
    telefono INTEGER,
    direccion VARCHAR2(50),
    dpi INTEGER,
    fecha_registro DATE
);

ALTER TABLE SECCION
ADD ID_SECCION NUMBER;

ALTER TABLE ASIGNACION 
ADD APROBADO NUMBER;


-- INSERT DATA CURSO
-- cursos de sistemas
INSERT INTO CURSO ( codigo, nombre) VALUES (017, 'Social Humanistica');
INSERT INTO CURSO ( codigo, nombre) VALUES (101, 'Matematica 1');
INSERT INTO CURSO ( codigo, nombre) VALUES (348, 'Quimica general 1');
INSERT INTO CURSO ( codigo, nombre) VALUES (019, 'Socual humanistica 2');
INSERT INTO CURSO ( codigo, nombre) VALUES (103, 'Matematoca 2');
INSERT INTO CURSO ( codigo, nombre) VALUES (147, 'Fisica basica');
INSERT INTO CURSO ( codigo, nombre) VALUES (150, 'Fisica 1');
INSERT INTO CURSO ( codigo, nombre) VALUES (39, 'Deportes 1');
INSERT INTO CURSO ( codigo, nombre) VALUES (0006, 'Idioma tecnico 1');
INSERT INTO CURSO ( codigo, nombre) VALUES (0008, 'Idioma tecnico 2');
INSERT INTO CURSO ( codigo, nombre) VALUES (0772, 'Estructura Datos');
INSERT INTO CURSO ( codigo, nombre) VALUES (0964, 'Organizacion Compu.');
INSERT INTO CURSO ( codigo, nombre) VALUES (0777, 'Compiladores1');
INSERT INTO CURSO ( codigo, nombre) VALUES (0781, 'Compiladores2');
INSERT INTO CURSO ( codigo, nombre) VALUES (0970, 'Redes1');
INSERT INTO CURSO ( codigo, nombre) VALUES (2021, 'Practica');
INSERT INTO CURSO ( codigo, nombre) VALUES (40, 'Deportes 2');
-- curso de industriales
INSERT INTO CURSO ( codigo, nombre) VALUES (0637, 'Diseno Industrial');
INSERT INTO CURSO ( codigo, nombre) VALUES (0639, 'Control de calidad');
INSERT INTO CURSO ( codigo, nombre) VALUES (0634, 'Ingenieria de metodos');
INSERT INTO CURSO ( codigo, nombre) VALUES (0620, 'Gestion ambiental');
INSERT INTO CURSO ( codigo, nombre) VALUES (0640, 'Control de produccion');

-- INSERT DATA SALON
INSERT INTO SALON ( edificio, salon, capacidad) VALUES ('T3','311',30);
INSERT INTO SALON ( edificio, salon, capacidad) VALUES ('T3','110',30);
INSERT INTO SALON ( edificio, salon, capacidad) VALUES ('T1','T-II',36);
INSERT INTO SALON ( edificio, salon, capacidad) VALUES ('T3','404',30);
INSERT INTO SALON ( edificio, salon, capacidad) VALUES ('T3','303',30);
INSERT INTO SALON ( edificio, salon, capacidad) VALUES ('S12','110',46);

-- INSERT DATA DIA 
INSERT INTO DIA (dia, nombre) VALUES (1,'LUNES');
INSERT INTO DIA (dia, nombre) VALUES (2,'MARTES');
INSERT INTO DIA (dia, nombre) VALUES (3,'MIERCOLES');
INSERT INTO DIA (dia, nombre) VALUES (4,'JUEVES');
INSERT INTO DIA (dia, nombre) VALUES (5,'VIERNES');
INSERT INTO DIA (dia, nombre) VALUES (6,'SABADO');

-- INSERT DATA PERIODO
INSERT INTO PERIODO (periodo, horainicio, horafinal) VALUES (1, TO_DATE('07:10' , 'HH24:MI'), TO_DATE('09:00' , 'HH24:MI'));
INSERT INTO PERIODO (periodo, horainicio, horafinal) VALUES (2, TO_DATE('09:00' , 'HH24:MI'), TO_DATE('11:40' , 'HH24:MI'));
INSERT INTO PERIODO (periodo, horainicio, horafinal) VALUES (3, TO_DATE('11:40' , 'HH24:MI'), TO_DATE('12:20' , 'HH24:MI'));
INSERT INTO PERIODO (periodo, horainicio, horafinal) VALUES (4, TO_DATE('13:10' , 'HH24:MI'), TO_DATE('15:00' , 'HH24:MI'));
INSERT INTO PERIODO (periodo, horainicio, horafinal) VALUES (5, TO_DATE('15:10' , 'HH24:MI'), TO_DATE('17:00' , 'HH24:MI'));

-- INSERT DATA CARRERA
INSERT INTO CARRERA (carrera, nombre) VALUES (1, 'Ciencias y Sistemas');
INSERT INTO CARRERA (carrera, nombre) VALUES (2, 'Industrial');
INSERT INTO CARRERA (carrera, nombre) VALUES (3, 'MecanicaIndustrial');

-- INSERT DATA PLAN 
INSERT INTO PLAN (plan, carrera, nombre, anioinicial, aniofinal, cicloinicial, ciclofinal, numcreditoscierre) VALUES 
('M', 1, 'Ciencias y Sistemas CLAR', '2022', '2026', '1S', '2S', 250 );

INSERT INTO PLAN (plan, carrera, nombre, anioinicial, aniofinal, cicloinicial, ciclofinal, numcreditoscierre) VALUES 
('M', 2, 'Industrial CLAR', '2022', '2026', '1S', '2S', 250 );

INSERT INTO PLAN (plan, carrera, nombre, anioinicial, aniofinal, cicloinicial, ciclofinal, numcreditoscierre) VALUES 
('V', 1, 'Ciencias y Sistemas CLAR', '2022', '2026', '1S', '2S', 25 );

-- Creacion de secuencias
CREATE SEQUENCE STUDENT_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
CACHE 5;


CREATE SEQUENCE SECCION_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
CACHE 5;

CREATE SEQUENCE CARRERA_SEQ
INCREMENT BY 1
START WITH 4
NOMAXVALUE
CACHE 5;

CREATE SEQUENCE HISTORIAL_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
CACHE 5;

--FUNCIONES PARA VALIDACIONES
--Validacion de letras
create or replace NONEDITIONABLE FUNCTION validar_letras(p_cadena VARCHAR2)
  RETURN BOOLEAN
IS
  v_reg_expresion VARCHAR2(200) := '^[a-zA-Z]+$';
BEGIN
  IF REGEXP_LIKE(p_cadena, v_reg_expresion) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END validar_letras;

--Validacion de correo 
create or replace NONEDITIONABLE FUNCTION validar_correo_electronico(
  p_correo_electronico VARCHAR2
)
  RETURN BOOLEAN
IS
  v_reg_expresion VARCHAR2(200) := '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
BEGIN
  IF REGEXP_LIKE(p_correo_electronico, v_reg_expresion) THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END validar_correo_electronico;



--PROCEDIMIENTOS
-- procedimiento para registrar estudiante
create or replace NONEDITIONABLE PROCEDURE RegistroEstudiante (
    p_carnet INTEGER,
    p_First_Name VARCHAR2,
    p_Last_Name VARCHAR2,
    p_Birth_Date DATE,
    p_Email VARCHAR2,
    p_Phone_Number VARCHAR2,
    p_Address VARCHAR2,
    p_DPI_Number VARCHAR2,
    p_major_ID NUMBER,
    p_Plan_ID VARCHAR2
) IS
BEGIN
    --Validaciones campos 
    BEGIN 
        IF NOT VALIDAR_LETRAS(p_First_Name)THEN
            RAISE_APPLICATION_ERROR(-20000, 'El nombre solo debe contener letras');
        END IF;
        IF NOT VALIDAR_LETRAS(p_Last_Name) THEN
            RAISE_APPLICATION_ERROR(-20000, 'El Apellido solo debe contener letras');
        END IF; 
        IF NOT VALIDAR_CORREO_ELECTRONICO(p_Email) THEN
            RAISE_APPLICATION_ERROR(-20000, 'Formato de correo no valido');
        END IF; 
    END;
    
    DECLARE
    v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM PLAN a
        WHERE a.PLAN = p_Plan_ID AND a.CARRERA = p_major_ID;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Invalid Program ID or Plan ID');
        END IF;
    END;

    BEGIN
    -- Insert Student
        INSERT INTO ESTUDIANTE (
            CARNET, NOMBRE, APELLIDO, FECHANACIMIENTO, CORREO, TELEFONO, DIRECCION, DPI, CARRERA, PLAN
        ) VALUES (
            p_carnet, p_First_Name, p_Last_Name, p_Birth_Date, p_Email, p_Phone_Number, p_Address, p_DPI_Number, p_major_ID, p_Plan_ID
        );
    END;

    --Inscripcion estudiante
    BEGIN 
        INSERT INTO INSCRITO (CARRERA, CARNET, FECHAINSCRIPCION) VALUES
        (p_major_ID, p_carnet, SYSDATE);
    END;

END;

--REGISTRO DE CARRERAS
create or replace NONEDITIONABLE PROCEDURE RegistroCarrera(
    c_name VARCHAR2
) IS
   
BEGIN

    DECLARE c_carrera NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO c_carrera
        FROM CARRERA c 
        WHERE c.NOMBRE = c_name;

        IF c_carrera != 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La carrera ya existe');
        END IF;
    END;

    BEGIN
        -- INSERTAR CARRERA
        INSERT INTO CARRERA (CARRERA, NOMBRE) VALUES
        (CARRERA_SEQ.NEXTVAL, c_name);
    END;

END;


--REGISTRO CATEDRATICO 
create or replace NONEDITIONABLE PROCEDURE RegistrarCatedratico (
    p_Instructor_ID NUMBER,
    p_First_Name VARCHAR2,
    p_Last_Name VARCHAR2,
    p_Birth_Date DATE,
    p_Email VARCHAR2,
    p_Phone_Number NUMBER,
    p_Address VARCHAR2,
    p_DPI_Number NUMBER,
    p_Salary NUMBER
) IS
BEGIN
    -- Validaciones de campos
    BEGIN 
        --nombre
        IF NOT VALIDAR_LETRAS(p_First_Name)THEN
            RAISE_APPLICATION_ERROR(-20000, 'El nombre solo debe contener letras');
        END IF;
        --apellido
        IF NOT VALIDAR_LETRAS(p_Last_Name) THEN
            RAISE_APPLICATION_ERROR(-20000, 'El Apellido solo debe contener letras');
        END IF; 
        --Correo
        IF NOT VALIDAR_CORREO_ELECTRONICO(p_Email) THEN
            RAISE_APPLICATION_ERROR(-20000, 'Formato de correo no valido');
        END IF; 
        --Salario
        IF p_Salary < 0 OR p_Salary > 99000 THEN
            RAISE_APPLICATION_ERROR(-20000, 'Salario No valido');
        END IF; 
    END;


    -- Insert Instructor
    INSERT INTO catedratico (
        CAT, NOMBRE, SUELDOMENSUAL, APELLIDO, FECHA_NACIMIENTO, CORREO, TELEFONO, DIRECCION, DPI, FECHA_REGISTRO
    ) VALUES (
        p_Instructor_ID, p_First_Name,p_Salary, p_Last_Name, p_Birth_Date, p_Email, p_Phone_Number, p_Address, p_DPI_Number, SYSDATE
    );
END;


--REGISTRO CURSO PENSUM
create or replace NONEDITIONABLE PROCEDURE CreateCourseCurriculum (
    p_Course_Code NUMBER,
    p_Mandatory CHAR,
    p_Credits_Needed NUMBER,
    p_Passing_Grade NUMBER,
    p_Minimum_Midterm_Grade NUMBER,
    p_Prerequisite_Credits NUMBER,
    p_Plan_ID VARCHAR2,
    p_Program_ID NUMBER
) IS
BEGIN
    --Validar campos
    BEGIN
        IF p_Prerequisite_Credits < 0  OR p_Credits_Needed < 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'CREDITOS NO VALIDOS');
        END IF; 
    END;

    --Validar que curso exista
    DECLARE
    v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM CURSO c
        WHERE c.CODIGO = p_Course_Code;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Curso no existente');
        END IF;
    END;

    --vALIRDAR ue plan exista
    DECLARE
    v_count1 NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count1
        FROM PLAN p
        WHERE p.PLAN = p_Plan_ID;

        IF v_count1 = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Plan no existe ');
        END IF;
    END;

    -- Insert Course in Curriculum
    INSERT INTO PENSUM (
        CURSO_CODIGO, PLAN, CARRERA, OBLIGATIEDAD, NUMCREDITOS, NOTAAPROBATORIA, ZONAMINIMA, CREDPRERREQ
    ) VALUES (
        p_Course_Code, p_Plan_ID, p_Program_ID, p_Mandatory, p_Credits_Needed, p_Passing_Grade, p_Minimum_Midterm_Grade, p_Prerequisite_Credits
    );
END;


-- -- INSERTAR PRERREQUISIRO
create or replace NONEDITIONABLE PROCEDURE AddPrerequisite (
    p_Course_Code NUMBER,
    p_Prerequisite_Course_Code NUMBER,
    p_Program_ID NUMBER,
    p_Plan_ID VARCHAR2
) IS
BEGIN
    --vALIDAR QUE EXISTA CURSO
    DECLARE
    v_count_curso NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count_curso
        FROM CURSO c
        WHERE c.CODIGO = p_Course_Code;

        IF v_count_curso = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Curso no existente');
        END IF;
    END;

    --VALIDAR QUE EXISTA PRERREQUISITO
     DECLARE
    v_count_pre NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count_pre
        FROM CURSO c
        WHERE c.CODIGO = p_Prerequisite_Course_Code;

        IF v_count_pre = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Curso prerrequisito no existente');
        END IF;
    END;

    -- Insert Prerequisite
    INSERT INTO PRERREQ (
        PENSUM_CARRERA, PENSUM_PLAN, CURSO_CODIGO, PRERREQ
    ) VALUES (
        p_Program_ID, p_Plan_ID, p_Course_Code, p_Prerequisite_Course_Code
    );
END;



---- CREACION DE SECCCION 
create or replace NONEDITIONABLE PROCEDURE CreateSection (
    p_Course_Code NUMBER,
    p_Term VARCHAR2,
    p_Instructor_ID NUMBER,
    p_Section CHAR
) IS
BEGIN
    --Validar que exista curso 

    --valirdar que exista maestro 

    --validar ciclo  SD
    IF p_Term = 'S1' OR p_Term = 'S2' OR p_Term = 'VJ' OR p_Term = 'VD' THEN
        -- Insert Section
        INSERT INTO SECCION (   
            ID_SECCION, SECCION, ANIO, CICLO, CURSO_CODIGO, CAT
        ) VALUES (
            SECCION_SEQ.NEXTVAL, p_Section, TO_CHAR(SYSDATE, 'YYYY'), p_Term, p_Course_Code, p_Instructor_ID
        );
    ELSE
        RAISE_APPLICATION_ERROR(-20000, 'Ciclo no valido');
    END IF; 
END;



---- CREACION DE HORARIO 
create or replace NONEDITIONABLE PROCEDURE AddSchedule (
    p_Course_Code NUMBER,
    p_Section_ID VARCHAR2,
    p_Year VARCHAR2,
    p_Term VARCHAR2,
    p_Period_ID NUMBER,
    p_Day_ID NUMBER,
    p_Building VARCHAR2,
    p_Room VARCHAR2
) IS
BEGIN
    -- Insert Schedule
    INSERT INTO HORARIO (
        SECCION_CURSO_CODIGO, SECCION, ANIO, CICLO, PERIODO, DIA, EDIFICIO, SALON
    ) VALUES (
        p_Course_Code, p_Section_ID, p_Year, p_Term, p_Period_ID, p_Day_ID, p_Building, p_Room
    );
END;



---- CREACION DE ASIGNACIONES

--Vista para creditos acumulados
CREATE OR REPLACE VIEW vw_Creditos_Acumulados AS
SELECT
    ESTUDIANTE.CARNET,
    SUM(PENSUM.NUMCREDITOS) AS Creditos_Acumulados
FROM
    Asignacion
JOIN Estudiante ON Asignacion.Carnet = Estudiante.Carnet
JOIN INSCRITO ON Estudiante.Carnet = Inscrito.Carnet
JOIN Curso ON Asignacion.Codigo = Curso.Codigo
JOIN Pensum ON Curso.Codigo = Pensum.Curso_Codigo AND Inscrito.carrera = Pensum.Carrera
WHERE Asignacion.Nota + Asignacion.Zona >= 61
GROUP BY
    Estudiante.Carnet;

---FUncion para verificar prerrequisitos
create or replace NONEDITIONABLE FUNCTION verificar_prerrequisitos(
    p_codigo_curso IN NUMBER,
    p_carnet_estudiante IN NUMBER
) RETURN BOOLEAN IS
    v_total_prerrequisitos NUMBER;
    v_prerrequisitos_aprobados NUMBER;
BEGIN
    -- Verificar si el curso tiene prerrequisitos
    SELECT COUNT(*) INTO v_total_prerrequisitos
    FROM PRERREQ
    WHERE CURSO_CODIGO = p_codigo_curso;

    IF v_total_prerrequisitos = 0 THEN
        RETURN TRUE;
    ELSE
        -- Verificar si todos los prerrequisitos están aprobados
        SELECT COUNT(*) INTO v_prerrequisitos_aprobados
        FROM ASIGNACION
        WHERE CARNET = p_carnet_estudiante
          AND CODIGO IN (SELECT PRERREQ FROM PRERREQ WHERE CURSO_CODIGO = p_codigo_curso)
          AND APROBADO = 1;

        IF v_prerrequisitos_aprobados = v_total_prerrequisitos THEN
            -- Todos los prerrequisitos están aprobados, devolver verdadero
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END IF;
END;


--Procedimiento para asignar cursos 
create or replace NONEDITIONABLE PROCEDURE AssignCourse (
    p_Section_ID INTEGER,
    p_Student_ID INTEGER
) IS
    codigo_curso INTEGER;
    creditos_acomulados INTEGER;
BEGIN
    -- validar que no se encuentre asignado al mismo curso en otra seccion
    Select CURSO_CODIGO INTO codigo_curso 
    FROM  SECCION
    WHERE ID_SECCION = p_Section_ID;

    DECLARE v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM asignacion a
        WHERE a.CARNET = p_Student_ID  AND a.CODIGO = codigo_curso;

        IF v_count != 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'ESTUDIANTE YA ESTA ASIGNADO AL CURSO');
        END IF;
    END;

    -- curso corresponda a la carrera 
    DECLARE curso_carrera NUMBER;
    BEGIN
        SELECT COUNT(*) INTO curso_carrera
        FROM pensum p
        WHERE p.CARRERA = (SELECT i.CARRERA FROM inscrito i WHERE i.CARNET = p_Student_ID)
        AND p.CURSO_CODIGO = codigo_curso;

        IF curso_carrera = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'CURSO NO PERTENECE A LA CARRERA DEL ESTUDIANTE');
        END IF;
    END;

    -- cuenta con los creditos necesarios 
    DECLARE creditos_necesarios NUMBER;
    BEGIN
        SELECT CREDPRERREQ INTO creditos_necesarios
        FROM pensum p
        WHERE p.curso_codigo = codigo_curso;
        
        -- CREDITOS NECESARIO = 0
        IF creditos_necesarios = 0 THEN
            --VERIFICAR SI YA APROBO PRERREQUISITOS
            IF verificar_prerrequisitos(codigo_curso, p_Student_ID) THEN
                --APROBO O NO TIENE PRERREQUISITOS
                    INSERT INTO ASIGNACION (
                    CARNET, CODIGO, SECCION, ANIO, CICLO, ZONA, NOTA, APROBADO
                ) VALUES (
                    p_Student_ID, (SELECT CURSO_CODIGO FROM SECCION WHERE ID_SECCION = p_Section_ID), 
                    (SELECT SECCION FROM SECCION WHERE ID_SECCION = p_Section_ID), (SELECT ANIO FROM SECCION WHERE ID_SECCION = p_Section_ID), (SELECT CICLO FROM SECCION WHERE ID_SECCION = p_Section_ID), 0, 0,
                    0
                );
            ELSE
                RAISE_APPLICATION_ERROR(-20001, 'NO A APROBADO CURSOS PRERREQUISITOS');
            END IF;
        ELSE
            -- NECESITA CIERTA CANTIDAD DE CREDITOS (UTILIZO LA VISTA)
            SELECT CREDITOS_ACUMULADOS INTO creditos_acomulados
            FROM vw_creditos_acumulados
            WHERE carnet = p_Student_ID;
            
            IF creditos_necesarios <= creditos_acomulados THEN
                --el estudiante tiene creditos necesarios
                IF verificar_prerrequisitos(codigo_curso, p_Student_ID) THEN
                    --APROBO O NO TIENE PRERREQUISITOS
                        INSERT INTO ASIGNACION (
                        CARNET, CODIGO, SECCION, ANIO, CICLO, ZONA, NOTA, APROBADO
                    ) VALUES (
                        p_Student_ID, (SELECT CURSO_CODIGO FROM SECCION WHERE ID_SECCION = p_Section_ID), 
                        (SELECT SECCION FROM SECCION WHERE ID_SECCION = p_Section_ID), (SELECT ANIO FROM SECCION WHERE ID_SECCION = p_Section_ID), (SELECT CICLO FROM SECCION WHERE ID_SECCION = p_Section_ID), 0, 0,
                        0
                    );
                ELSE
                    RAISE_APPLICATION_ERROR(-20001, 'NO A APROBADO CURSOS PRERREQUISITOS');
                END IF;
            ELSE
                RAISE_APPLICATION_ERROR(-20001, 'NO CUENTA CON CREDITOS NECESARIOS');    
            END IF;
        END IF;
    END;
    
END;


--INSERTAR NOTAS
create or replace NONEDITIONABLE PROCEDURE EnterGrades (
    p_Section_ID NUMBER,
    p_Student_ID NUMBER,
    p_Midterm_Grade NUMBER,
    p_Final_Grade NUMBER
) IS
    v_Total_Grade NUMBER;
BEGIN
    -- Calculate total grade
    v_Total_Grade := ROUND(p_Midterm_Grade + p_Final_Grade);
    
    IF v_total_grade >=61 THEN
        -- Update Enrollment with grades
        UPDATE asignacion
        SET ZONA = p_Midterm_Grade,
            NOTA = p_Final_Grade, 
            APROBADO = 1
        WHERE CARNET = p_Student_ID AND SECCION = (SELECT SECCION FROM SECCION WHERE ID_SECCION = p_Section_ID);    
    ELSE
        UPDATE asignacion
        SET ZONA = p_Midterm_Grade,
            NOTA = p_Final_Grade, 
            APROBADO = 0
        WHERE CARNET = p_Student_ID AND SECCION = (SELECT SECCION FROM SECCION WHERE ID_SECCION = p_Section_ID);         
    END IF;
END;



--DESASIGNAR CURSO 
create or replace NONEDITIONABLE PROCEDURE UnassignCourse (
    p_Section_ID NUMBER,
    p_Student_ID NUMBER
) IS
BEGIN
    -- Validar que no este asignado al curso 
    DECLARE
    v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM asignacion a
        WHERE a.CARNET = p_Student_ID AND a.SECCION = (SELECT SECCION FROM SECCION WHERE ID_SECCION = p_Section_ID);

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'ESTUDIANTE NO ESTABA ASIGNADO A DICHA SECCION');
        END IF;
    END;
    -- Unassign Course
    DELETE FROM ASIGNACION 
    WHERE CARNET = p_Student_ID AND SECCION = (SELECT SECCION FROM SECCION WHERE ID_SECCION = p_Section_ID);
END;



---LLAMADAS
-- INSERTAR ESTUDIANTES
CALL registroestudiante(
15, --carnet
'Luis', --nombres
'Lizama',  --apellidos
TO_DATE('1999-12-10', 'YYYY-MM-DD'),    --cumpleanios
'reyeslizando@gmail.com',   --correo
'215DS4563',    --telefono
'GuateSDSDmala, zona 7',    --direccion
'36345480101',  --dpi
1, --carrera
'M'--plan
);

-- INSERTAR CARRERAS
CALL registrocarrera(
'CONTADURIA' --nombre carrera
);

--INSERTAR CATEDRATICOS
CALL registrarcatedratico(
    3,  --id_catedratico
    'Lady', --nombre
    'Pedroso', --apellido
    TO_DATE('1990-12-10', 'YYYY-MM-DD'),    --cumpleanios
    'ladyttu@gmail.com',    --correo
    343536,-- tel
    'Zona 11 Guatemala',--direccion
    54654540101,--dpi
    5500 --salario
);

-- INSERTAR CURSO PENSUM 
CALL CREATECOURSECURRICULUM(
    2021, --codigo curso
    '1', --OBLIGATORIO
    0,   --creditos que otorga
    61,  --nota aprobatoria   
    36,  --zona minima
    35,  --creditos necesarios
    'M', --plan
    1    --carrera
);

-- INSERTAR PRERREQUISIRO
CALL addprerequisite(
    40, --codigo curso
    39, --codigo prerrequisio
    1,   --carrera
    'M'  --plan
);


-- CREACION DE SECCCION 
CALL CREATESECTION(
    2021,    --codigo curso
    'S1',   --ciclo
    2,      --codigo catedratico
    'qm'     --seccion char(1)
);


-- CREACION DE HORARIO 
CALL ADDSCHEDULE(
    2021,    --codigo curso
    'qm',    --seccion
    '2024', --anio
    'S1',   --ciclo
    4,      --periodo id
    2,      --dia id
    'T3',   --edificio
    '311'   --salon
);

-- CREACION DE ASIGNACIONES
CALL assigncourse(
    11, --id_SECCION
     14  --CARNET
);

--INGRESAR NOTAS
CALL entergrades(
    13,    --ID_SECCION 
    1,       --CARNET
    49,    --ZONA
    23 --EXAMEN FINAL
);


-- DESASIGNAR CURSO
CALL unassigncourse(
        15,    --SECCION 
        1    --CARNET 
);


-- --------------------------------------------------------
--REPORTES
-- --------------------------------------------------------

SET SERVEROUTPUT ON;

-- PROCEDIMIENTO PARA CONSULTAR CURSOS DE CARRERAS
CREATE OR REPLACE PROCEDURE ConsultarPensum(Cod_Carrera NUMBER) AS
    CURSOR c_pensum IS
      SELECT c.CODIGO, c.NOMBRE, p.OBLIGATIEDAD, p.NUMCREDITOS, p.CREDPRERREQ
      FROM Curso c
      JOIN Pensum p ON c.CODIGO = p.CURSO_CODIGO
      WHERE p.CARRERA = Cod_Carrera;
    
   -- Declaración de variables para almacenar los resultados
   v_CODIGO Curso.CODIGO%TYPE;
   v_NOMBRE Curso.NOMBRE%TYPE;
   v_OBLIGATIEDAD Pensum.OBLIGATIEDAD%TYPE;
   v_NUMCREDITOS Pensum.NUMCREDITOS%TYPE;
   v_CREDPRERREQ Pensum.CREDPRERREQ%TYPE;
BEGIN
   FOR r_pensum in c_pensum loop
        v_CODIGO := r_pensum.CODIGO;
        v_NOMBRE := r_pensum.NOMBRE;
        v_OBLIGATIEDAD := r_pensum.OBLIGATIEDAD;
        v_NUMCREDITOS   := r_pensum.NUMCREDITOS;
        v_CREDPRERREQ    := r_pensum.CREDPRERREQ;
        
        DBMS_OUTPUT.PUT_LINE('Código: ' || v_CODIGO);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Obligatoriedad: ' || v_OBLIGATIEDAD);
        DBMS_OUTPUT.PUT_LINE('Creditos otorda: ' || v_NUMCREDITOS);
        DBMS_OUTPUT.PUT_LINE('Creditos necesarios: ' || v_CREDPRERREQ);
    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No se encontraron registros para la carrera ' || Cod_Carrera);
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


-- PROCEDIMIENTO PARA CONSULTAR ESTUDIANTES
CREATE OR REPLACE PROCEDURE ConsultarEstudiante(Cod_carnet NUMBER) AS
    CURSOR s_studiante IS
      SELECT e.CARNET, 
            e.NOMBRE || ' ' || e.APELLIDO AS NOMBRE,
            e.FECHANACIMIENTO, 
            e.CORREO, 
            e.TELEFONO, 
            e.DIRECCION, 
            e.DPI, 
            a.NOMBRE as NOMBRE_CARRERA, 
            c.CREDITOS_ACUMULADOS
      FROM ESTUDIANTE e
      JOIN CARRERA a ON e.CARRERA = a.CARRERA
      JOIN VW_CREDITOS_ACUMULADOS c ON e.CARNET = c.CARNET
      WHERE e.CARNET = Cod_carnet ;

   -- Declaración de variables para almacenar los resultados
   v_CARNET ESTUDIANTE.CARNET%TYPE;
   v_NOMBRE ESTUDIANTE.NOMBRE%TYPE;
   v_NACIMIENTO ESTUDIANTE.FECHANACIMIENTO%TYPE;
   v_CORREO ESTUDIANTE.CORREO%TYPE;
   v_DIRECCION ESTUDIANTE.DIRECCION%TYPE;
   v_DPI ESTUDIANTE.DPI%TYPE;
   v_CARRERA CARRERA.NOMBRE%TYPE;
   v_CREDITOS VW_CREDITOS_ACUMULADOS.CREDITOS_ACUMULADOS%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Estiante carnet: ' || Cod_carnet );
   FOR r_estudiante in s_studiante loop
        v_CARNET := r_estudiante.CARNET;
        v_NOMBRE := r_estudiante.NOMBRE;
        v_NACIMIENTO := r_estudiante.FECHANACIMIENTO;
        v_CORREO   := r_estudiante.CORREO;
        v_DIRECCION   := r_estudiante.DIRECCION;
        v_DPI       :=  r_estudiante.DPI;
        v_CARRERA   :=  r_estudiante.NOMBRE_CARRERA;
        v_CREDITOS  :=  r_estudiante.CREDITOS_ACUMULADOS;
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------- ' );
        DBMS_OUTPUT.PUT_LINE('Carnet: ' || v_CARNET);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Fecha de nacimiento: ' || v_NACIMIENTO);
        DBMS_OUTPUT.PUT_LINE('Correo: ' || v_CORREO);
        DBMS_OUTPUT.PUT_LINE('Direccion: ' || v_DIRECCION);
        DBMS_OUTPUT.PUT_LINE('DPI: ' || v_DPI);
        DBMS_OUTPUT.PUT_LINE('Carrera: ' || v_CARRERA);
        DBMS_OUTPUT.PUT_LINE('Creditos Acomulados: ' || v_CREDITOS);
    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Carnet no registrado ' || Cod_carnet );
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- PROCEDIMIENTO PARA CONSULTAR ESTUDIANTES
CREATE OR REPLACE PROCEDURE ConsultarCatedratico(Cod_Catedratico NUMBER) AS
    CURSOR s_catedratico IS
      SELECT c.CAT, 
            c.NOMBRE || ' ' || c.APELLIDO AS NOMBRE,
            c.FECHA_NACIMIENTO, 
            c.CORREO, 
            c.TELEFONO, 
            c.DIRECCION, 
            c.DPI
      FROM  CATEDRATICO c
      WHERE c.CAT= Cod_Catedratico;

   -- Declaración de variables para almacenar los resultados
   v_CARNET CATEDRATICO.CAT%TYPE;
   v_NOMBRE CATEDRATICO.NOMBRE%TYPE;
   v_NACIMIENTO CATEDRATICO.FECHA_NACIMIENTO%TYPE;
   v_CORREO CATEDRATICO.CORREO%TYPE;
   v_DIRECCION CATEDRATICO.DIRECCION%TYPE;
   v_DPI CATEDRATICO.DPI%TYPE;
   v_TELEFONO CATEDRATICO.TELEFONO%TYPE;
 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Catedratico codigo: ' || Cod_Catedratico);
   FOR r_estudiante in s_catedratico loop
        v_CARNET := r_estudiante.CAT;
        v_NOMBRE := r_estudiante.NOMBRE;
        v_NACIMIENTO := r_estudiante.FECHA_NACIMIENTO;
        v_CORREO   := r_estudiante.CORREO;
        v_DIRECCION   := r_estudiante.DIRECCION;
        v_DPI       :=  r_estudiante.DPI;
        v_TELEFONO  := r_estudiante.TELEFONO;
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------- ' );
        DBMS_OUTPUT.PUT_LINE('Carnet: ' || v_CARNET);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Fecha de nacimiento: ' || v_NACIMIENTO);
        DBMS_OUTPUT.PUT_LINE('Correo: ' || v_CORREO);
        DBMS_OUTPUT.PUT_LINE('TELEFONO: ' || v_TELEFONO);
        DBMS_OUTPUT.PUT_LINE('Direccion: ' || v_DIRECCION);
        DBMS_OUTPUT.PUT_LINE('DPI: ' || v_DPI);
        
    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Catedratico no registrado ' || Cod_Catedratico);
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE ConsultarAsignaciones(Codigo_Curso NUMBER, Ciclo VARCHAR2, Anio VARCHAR2, Seccion CHAR) AS
    CURSOR s_asignacion IS
      SELECT a.CARNET,
             e.NOMBRE || ' ' || e.APELLIDO AS NOMBRE_COMPLETO 
      FROM  ASIGNACION a
      JOIN ESTUDIANTE e ON a.CARNET = e.CARNET
      WHERE a.CODIGO = Codigo_Curso AND a.CICLO = Ciclo AND a.ANIO = Anio AND a.SECCION = Seccion;

   -- Declaración de variables para almacenar los resultados
   v_CARNET CATEDRATICO.CAT%TYPE;
   v_NOMBRE CATEDRATICO.NOMBRE%TYPE;

 
BEGIN
    DBMS_OUTPUT.PUT_LINE('ESTUDIANTES ASIGNADOS AL CURSO: ');
   FOR r_estudiante in s_asignacion loop
        v_CARNET := r_estudiante.CARNET;
        v_NOMBRE := r_estudiante.NOMBRE_COMPLETO;
       
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------- ' );
        DBMS_OUTPUT.PUT_LINE('Carnet: ' || v_CARNET);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_NOMBRE);
        
    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Seccion no exite para un ciclo o anio mencionado');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


-- CONSULTAR HORARIO DE ESTUDIANTE 
CREATE OR REPLACE PROCEDURE ConsultarHorario(cod_carnet NUMBER, Ciclo1 VARCHAR2, Anio1 VARCHAR2) AS
    CURSOR s_horario IS
       SELECT CURSO.NOMBRE AS Curso, 
                HORARIO.SECCION AS Seccion, 
                DIA.NOMBRE AS Dia, 
                PERIODO.HoraInicio || '-' || PERIODO.HoraFinal AS Periodo, 
                SALON.EDIFICIO || ',' || SALON.SALON AS Lugar
        FROM HORARIO
        JOIN CURSO  ON HORARIO.SECCION_CURSO_CODIGO = CURSO.CODIGO
        JOIN DIA  ON HORARIO.DIA = DIA.DIA
        JOIN PERIODO  ON HORARIO.PERIODO = PERIODO.PERIODO
        JOIN SALON  ON HORARIO.SALON = SALON.SALON
        JOIN ASIGNACION  ON HORARIO.SECCION = ASIGNACION.SECCION
        WHERE ASIGNACION.CARNET = cod_carnet AND ASIGNACION.CICLO = Ciclo1 AND ASIGNACION.ANIO = Anio1;

   -- Declaración de variables para almacenar los resultados
   v_CURSO CURSO.NOMBRE%TYPE;
   v_SECCION HORARIO.SECCION%TYPE;
   v_DIA DIA.NOMBRE%TYPE;
   v_PERIODO CATEDRATICO.NOMBRE%TYPE;
   v_LUGAR SALON.SALON%TYPE;


BEGIN
    DBMS_OUTPUT.PUT_LINE('Horario del estudiante: ' || cod_carnet);
   FOR r_estudiante in s_horario loop
        v_CURSO := r_estudiante.Curso;
        v_SECCION := r_estudiante.Seccion;
        v_DIA := r_estudiante.Dia;
        v_PERIODO := r_estudiante.Periodo;
        v_LUGAR := r_estudiante.Lugar;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------------- ' );
        DBMS_OUTPUT.PUT_LINE('Curso: ' || v_CURSO);
        DBMS_OUTPUT.PUT_LINE('Seccion: ' || v_SECCION);
        DBMS_OUTPUT.PUT_LINE('Dia: ' || v_DIA);
        DBMS_OUTPUT.PUT_LINE('Periodo: ' || v_PERIODO);
        DBMS_OUTPUT.PUT_LINE('Lugar: ' || v_LUGAR);

    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Estudiante no tiene cursos asignados en este ciclo y anio');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- CONSULTAR APROBACION 
CREATE OR REPLACE PROCEDURE ConsultarAprobaciones(cod_curso NUMBER, Ciclo1 VARCHAR2, Anio1 VARCHAR2, Seccion1 CHAR) AS
    CURSOR s_aprobacion IS
       SELECT ASIGNACION.CODIGO AS Curso, 
                ASIGNACION.CARNET, 
                ESTUDAINTE.NOMBRE ||' '|| ESTUDIANTE.APELLIDO AS NOMBRE,  
                ASIGNACION.APROBADO
        FROM ASIGNACION
        JOIN ESTUDIANTE  ON ESTUDIANTE.CARNET = ASIGNACION.CARNET
        WHERE ASIGNACION.CODIGO = cod_curso AND ASIGNACION.CICLO = Ciclo1 AND ASIGNACION.ANIO = Anio1 AND ASIGNACION.SECCION = Seccion1;

   -- Declaración de variables para almacenar los resultados
   v_CURSO CURSO.CODIGO%TYPE;
   v_CARNET ESTUDIANTE.CARNET%TYPE;
   v_NOMBRE ESTUDIANTE.NOMBRE%TYPE;
   v_APROBADO ASIGNACION.APROBADO%TYPE;
   v_AUX ESTUDIANTE.NOMBRE%TYPE;


BEGIN
    DBMS_OUTPUT.PUT_LINE('Resultados de estudiantes asignados a este curso');
   FOR r_estudiante in s_aprobacion loop
        v_CURSO := r_estudiante.Curso;
        v_CARNET := r_estudiante.CARNET;
        v_NOMBRE := r_estudiante.NOMBRE;
        v_APROBADO := r_estudiante.APROBADO;
        IF v_APROBADO = 1 THEN
            v_AUX := 'Aprobado';
        ELSE
            v_AUX := 'Reprobado';
        END IF;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------------- ' );
        DBMS_OUTPUT.PUT_LINE('Curso: ' || v_CURSO);
        DBMS_OUTPUT.PUT_LINE('Carnet: ' || v_CARNET);
        DBMS_OUTPUT.PUT_LINE('Nombre Estudiante: ' || v_NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Aprobado: ' || v_AUX);
    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nadie gano este curso');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


-- CONSULTAR CURSOS PROXIMO SEMESTRE
CREATE OR REPLACE PROCEDURE ConsultarCursoSemestre(cod_carnet NUMBER) AS
    CURSOR s_semestre IS
       SELECT ASIGNACION.CODIGO AS COD_CURSO
        FROM ASIGNACION
        WHERE ASIGNACION.CARNET = cod_carnet AND ASIGNACION.APROBADO = 1;

   -- Declaración de variables para almacenar los resultados
   v_CURSO CURSO.CODIGO%TYPE;
   v_NOMBRE CURSO.NOMBRE%TYPE;
   v_CRED_OTORGA PENSUM.NUMCREDITOS%TYPE;
   v_PRE_APROBADO CURSO.CODIGO%TYPE;
   v_PRE_NOMBRE CURSO.NOMBRE%TYPE;


BEGIN
    DBMS_OUTPUT.PUT_LINE('Cursos que puede asignarse el siguiente semestre:');
   FOR r_estudiante in s_semestre loop
        v_PRE_APROBADO := r_estudiante.COD_CURSO; --curso aprobado 
        
        SELECT CURSO.CODIGO, CURSO.NOMBRE, pensum.numcreditos
        INTO v_CURSO, v_NOMBRE, v_CRED_OTORGA
        FROM PRERREQ
        JOIN CURSO ON CURSO.CODIGO = PRERREQ.CURSO_CODIGO
        JOIN PENSUM ON pensum.curso_codigo = CURSO.CODIGO
        WHERE PRERREQ.PRERREQ = v_PRE_APROBADO;
        
        

        SELECT CURSO.NOMBRE INTO v_PRE_NOMBRE
        FROM CURSO
        WHERE CURSO.CODIGO = v_PRE_APROBADO;
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------- ' );
        DBMS_OUTPUT.PUT_LINE('Curso: ' || v_CURSO);
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_NOMBRE);
        DBMS_OUTPUT.PUT_LINE('Creditos Otorga: ' || v_CRED_OTORGA);
        DBMS_OUTPUT.PUT_LINE('Prerrequisito Aprobado: ' || v_PRE_APROBADO);
        DBMS_OUTPUT.PUT_LINE('Nombre Prerrequisito Aprobado: ' || v_PRE_NOMBRE);
    END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No puede asignarse a otro curso, debe recursar');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

-- --------------------------------------------------------
-- LLAMADA DE REPORTES
-- --------------------------------------------------------
-- consultar curso de carrera
CALL CONSULTARPENSUM(2); --codigo carrera

-- Consulta datos estudiante
CALL CONSULTARESTUDIANTE(1); -- Carnet estudiante

-- Consuta datos catedratico 
CALL CONSULTARCATEDRATICO(2);   --Codigo catedratico

-- Consultar Alumnos asignados a determinada seccion
CALL CONSULTARASIGNACIONES(
    17,      --CODIGO CURSO
    'S1',    --CICLO
    '2024',   --ANIO
    'B'      --SECCION
);

-- Consultar horario
CALL CONSULTARHORARIO(
    2,      -- CARNET 
    'S1',   --CICLO (S1, S2, VJ, VD)
    '2024'  --ANIO
);

-- Consultar Aprobaciones
CALL CONSULTARAPROBACIONES(
    17,      --CODIGO CURSO
    'S1',     --CICLO
    '2024',  --ANIO
    'B'
);

-- CONSULTAR CURSO SIGUIENTE SEMESTRE
CALL CONSULTARCURSOSEMESTRE(
    1       --CARNET
);


-- --------------------------------------------------------
-- CREACION DE HISTORIAL
-- --------------------------------------------------------
-- Creacion tabla
CREATE TABLE HistorialTransacciones (
    ID NUMBER PRIMARY KEY,
    FechaHora DATE,
    TablaAfectada VARCHAR2(100),
    Accion VARCHAR2(100)
);
/

--Creacion trigger
CREATE OR REPLACE TRIGGER trg_Carrera
AFTER INSERT OR UPDATE OR DELETE ON CARRERA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HistorialTransacciones (ID, FechaHora, TablaAfectada, Accion)
        VALUES (HISTORIAL_SEQ.NEXTVAL, SYSDATE, 'Se a realizado una accion en la tabla Carrera', 'INSERT');
    ELSIF UPDATING THEN
        INSERT INTO HistorialTransacciones (FechaHora, TablaAfectada, Accion)
        VALUES (HISTORIAL_SEQ.NEXTVAL, SYSDATE, 'Se a realizado una accion en la tabla Carrera', 'UPDATE');
    ELSIF DELETING THEN
        INSERT INTO HistorialTransacciones (FechaHora, TablaAfectada, Accion)
        VALUES (HISTORIAL_SEQ.NEXTVAL, SYSDATE, 'Se a realizado una accion en la tabla Carrera', 'DELETE');
    END IF;
END;

CREATE OR REPLACE TRIGGER trg_prerrequisito
AFTER INSERT OR UPDATE OR DELETE ON PRERREQ
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO HistorialTransacciones (ID, FechaHora, TablaAfectada, Accion)
        VALUES (HISTORIAL_SEQ.NEXTVAL, SYSDATE, 'Se a realizado una accion en la tabla Horario', 'INSERT');
    ELSIF UPDATING THEN
        INSERT INTO HistorialTransacciones (ID, FechaHora, TablaAfectada, Accion)
        VALUES (HISTORIAL_SEQ.NEXTVAL, SYSDATE, 'Se a realizado una accion en la tabla Horario', 'UPDATE');
    ELSIF DELETING THEN
        INSERT INTO HistorialTransacciones (ID, FechaHora, TablaAfectada, Accion)
        VALUES (HISTORIAL_SEQ.NEXTVAL, SYSDATE, 'Se a realizado una accion en la tabla Horario', 'DELETE');
    END IF;
END;

