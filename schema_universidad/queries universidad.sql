 -- 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM universidad.persona WHERE tipo = 'alumno' ORDER BY concat(apellido1, apellido2, nombre) ASC;
 -- 2 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = 'alumno' AND telefono IS NULL;
 -- 3 Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM universidad.persona WHERE tipo = 'alumno' AND fecha_nacimiento LIKE '1999%';
 -- 4 Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
SELECT * FROM universidad.persona WHERE tipo = 'profesor' AND nif LIKE '%K' AND telefono IS NULL;
 -- 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM universidad.asignatura WHERE curso = 3 AND cuatrimestre = 1 AND id_grado = 7;
 -- 6 Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento FROM universidad.persona p JOIN universidad.profesor pr ON p.id = pr.id_profesor JOIN universidad.departamento d ON pr.id_departamento = d.id ORDER BY concat(p.apellido1, p.apellido2, p.nombre) ASC; 
 -- 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
SELECT a.nombre, c.anyo_inicio, c.anyo_fin FROM universidad.asignatura a JOIN universidad.curso_escolar c ON a.id = c.id
	JOIN universidad.alumno_se_matricula_asignatura m ON a.id = m.id_asignatura
    JOIN universidad.persona p ON m.id_alumno = p.id WHERE nif = '26902806M';
 -- 8 Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT d.nombre FROM universidad.departamento d JOIN universidad.profesor pr ON pr.id_departamento=d.id 
    JOIN universidad.asignatura c ON pr.id_profesor = c.id_profesor WHERE c.id_profesor IS NOT NULL AND id_grado=4 GROUP BY d.nombre;
-- 9 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT p.apellido1, p.apellido2, p.nombre FROM universidad.persona p JOIN universidad.alumno_se_matricula_asignatura m ON p.id=m.id_alumno
	WHERE m.id_curso_escolar =5 GROUP BY concat (p.apellido1, p.apellido2, p.nombre);
/* 2.1. Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. 
El llistat també ha de mostrar aquells professors que no tenen cap departament associat. 
El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. 
El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/
INSERT INTO universidad.persona VALUES (NULL,'39367543J', 'Juanit', 'Thabes', 'Causeyes', 'Almería', 'C/ Falsa', 666666666, '1974-03-22', 'H', 'profesor');
INSERT INTO universidad.profesor VALUES (25, NULL);
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON p.id = pr.id_profesor
	LEFT JOIN universidad.departamento d ON pr.id_departamento = d.id ORDER BY d.nombre ASC, concat(p.apellido1, p.apellido2, p.nombre);
 -- 2.2. Retorna un llistat amb els professors que no estan associats a un departament.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON p.id = pr.id_profesor
	LEFT JOIN universidad.departamento d ON pr.id_departamento = d.id WHERE pr.id_departamento IS NULL;
 -- 2.3. Retorna un llistat amb els departaments que no tenen professors associats.
SELECT d.nombre AS departamento FROM universidad.departamento d LEFT JOIN universidad.profesor pr ON pr.id_departamento = d.id WHERE pr.id_profesor IS NULL;
 -- 2.4. Retorna un llistat amb els professors que no imparteixen cap assignatura.
SELECT p.nombre, p.apellido1, p.apellido2 FROM universidad.persona p RIGHT JOIN universidad.profesor pr ON pr.id_profesor = p.id
	LEFT JOIN universidad.asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;
 -- 2.5. Retorna un llistat amb les assignatures que no tenen un professor assignat.   
SELECT a.nombre FROM universidad.asignatura a LEFT JOIN universidad.profesor pr ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL; 
 -- 2.6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.nombre FROM universidad.departamento d LEFT JOIN universidad.profesor pr ON pr.id_departamento = d.id
	LEFT JOIN universidad.asignatura a ON a.id_profesor=pr.id_profesor WHERE a.id_profesor IS NULL GROUP BY d.nombre;  
 -- 3.1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(tipo) AS total_alumnos FROM universidad.persona WHERE tipo='alumno';
 -- 3.2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(tipo) AS alumnos_nacidos_en_1999 FROM universidad.persona WHERE tipo = 'alumno' AND fecha_nacimiento LIKE '1999%';
 /* 3.3. Calcula quants professors hi ha en cada departament. 
El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors 
que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i 
haurà d'estar ordenat de major a menor pel nombre de professors.*/
SELECT COUNT(pr.id_profesor), d.nombre AS departamento FROM universidad.profesor pr JOIN universidad.departamento d ON pr.id_departamento = d.id GROUP BY pr.id_departamento;
 /* 3.4. Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. 
 Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.*/
SELECT d.nombre, COUNT(pr.id_profesor) AS profesores FROM universidad.departamento d 
	LEFT JOIN universidad.profesor pr ON pr.id_departamento = d.id GROUP BY d.id;
 /* 3.5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
 Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
 El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/
SELECT g.nombre, COUNT(a.id) AS numero_asignaturas FROM universidad.grado g 
	LEFT JOIN universidad.asignatura a ON g.id=a.id_grado GROUP BY g.id ORDER BY COUNT(a.id) DESC;
/* 3.6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, 
dels graus que tinguin més de 40 assignatures associades.*/
SELECT g.nombre, COUNT(a.id) AS numero_asignaturas FROM universidad.grado g
	LEFT JOIN universidad.asignatura a ON g.id=a.id_grado GROUP BY g.id HAVING COUNT(a.id)>40;
/*3.7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/
SELECT g.nombre, a.tipo, SUM(a.creditos) AS creditos FROM universidad.grado g
	RIGHT JOIN universidad.asignatura a ON g.id=a.id_grado GROUP BY g.nombre, a.tipo;
 /*3.8.Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
 El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.*/
SELECT COUNT(DISTINCT m.id_alumno) AS alumnos_matriculados, c.anyo_inicio FROM universidad.alumno_se_matricula_asignatura m JOIN universidad.curso_escolar c ON m.id_curso_escolar=c.id GROUP BY c.anyo_inicio;
 /*3.9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. 
 El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. 
 El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
 El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS asignaturas_impartidas FROM universidad.persona p JOIN universidad.profesor pr ON p.id = pr.id_profesor
	LEFT JOIN universidad.asignatura a ON pr.id_profesor = a.id_profesor GROUP BY pr.id_profesor ORDER BY COUNT(a.id) DESC;
 -- 3. 10 Retorna totes les dades de l'alumne més jove.
SELECT * FROM universidad.persona WHERE fecha_nacimiento IN (SELECT max(fecha_nacimiento) FROM universidad.persona);
 -- 3.11. Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.
 SELECT p.id, p.nombre, p.apellido1, p.apellido2, d.nombre FROM universidad.persona p JOIN universidad.profesor pr ON p.id = pr.id_profesor
	JOIN universidad.departamento d ON pr.id_departamento = d.id
    LEFT JOIN universidad.asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;