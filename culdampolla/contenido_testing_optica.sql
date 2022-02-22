USE optica;
INSERT INTO proveedor VALUES(NULL, 'GAFAS PLUS S.L.', 'C/ Falsa', 1, 4, 'Falsita', 00001, 'España', 666666666, 123456789, 'B9998887776C');
INSERT INTO proveedor VALUES(NULL, 'GLASSES ULTRA S.L.', 'C/ False', 2, 5, 'Falsisimo', 00002, 'España', 777777777, 123456780, 'B7776665554A');
INSERT INTO proveedor VALUES(NULL, 'GAFITAS S.L.', 'C/ Falsium', 3, 6, 'Falsotu', 00003, 'España', 888888888, 087654321, 'B6665554443B');
	SELECT * FROM proveedor;
INSERT INTO marca VALUES (NULL, 'ray-ban', 1);
INSERT INTO marca VALUES (NULL, 'police', 2);
INSERT INTO marca VALUES (NULL, 'tous', 2);
INSERT INTO marca VALUES (NULL, 'carolina herrera', 3);
INSERT INTO marca VALUES (NULL, 'police', 1);
	SELECT * FROM marca;
INSERT INTO gafas VALUES(NULL, 0, 0, 'negro', 'negro', 99.99, 1, 1, 1, 1, '2021-03-22');
INSERT INTO gafas VALUES(NULL, 0.5, 1, 'azul', 'azul', 95.99, 2, 3, 1, 1, '2021-06-22');
INSERT INTO gafas (graduacion_cristal1, graduacion_cristal2, precio, id_marca, id_montura, id_cliente, id_vendedor, fecha_venta)
	VALUES(1.5, 2.5, 125.00, 1, 2, 2, 2, '2020-12-23');
INSERT INTO gafas (graduacion_cristal1, graduacion_cristal2, precio, id_marca, id_montura, id_cliente, id_vendedor, fecha_venta)
	VALUES(2.0, 2.5, 128.00, 3, 1, 3, 1, '2020-12-31');    
    SELECT * FROM gafas;
INSERT INTO vendedor VALUES (NULL, 'María');
INSERT INTO vendedor VALUES (NULL, 'Juan');    
	SELECT * FROM vendedor;
INSERT INTO clientes VALUES (NULL, NULL, 'Juan Pepito Palotes', 'C/ Del horror', 666, NULL, 'Secuele', 08666, 'España',621626262, 'pepitopalotes@mysql.com');
INSERT INTO clientes VALUES (NULL, 1, 'Laurita Pepita Palotes', 'C/ Del horror', 666, NULL, 'Secuele', 08666, 'España', 631636363, 'lauritapalotes@mysql.com');
INSERT INTO clientes VALUES (NULL, 2, 'Marcos Mis Amores', 'C/ Del horror', 333, NULL, 'Secuele', 08666, 'España', 641646464, 'marcosmisamores@mysql.com');
	SELECT * FROM clientes;
    
SELECT clientes.nombre, count(gafas.id_cliente) FROM gafas JOIN clientes ON gafas.id_cliente=clientes.id_cliente WHERE gafas.id_cliente = 1 GROUP BY gafas.id_cliente;
SELECT gafas.id_gafas, gafas.fecha_venta, vendedor.nombre FROM gafas JOIN vendedor ON gafas.id_vendedor=vendedor.id_vendedor WHERE vendedor.id_vendedor = 1 AND gafas.fecha_venta LIKE '2021%';
SELECT proveedor.id_proveedor, proveedor.nombre, marca.nombre, count(gafas.id_gafas) FROM proveedor JOIN marca ON proveedor.id_proveedor=marca.id_proveedor
	JOIN gafas ON gafas.id_marca=marca.id_marca GROUP BY marca.nombre;