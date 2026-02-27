use tienda_online;

-- Clientes del 2023 --
SELECT 
    *
FROM
    clientes
WHERE
    fecha_registro LIKE '2023-%';
    
-- 1) ¿Cuántos clientes se han registrado por año y mes?--
SELECT 
    COUNT(*) AS num_clientes,
    MONTH(fecha_registro) AS Mes,
    YEAR(fecha_registro) AS Año
FROM
    clientes
GROUP BY MONTH(fecha_registro) , YEAR(fecha_registro)
ORDER BY num_clientes DESC;

-- 2) ¿Cuántos clientes españoles se han registrado por año y mes?--
SELECT 
    COUNT(*) AS num_clientes,
    MONTH(fecha_registro) AS Mes,
    YEAR(fecha_registro) AS Año
FROM
    clientes
WHERE
    pais = 'España'
GROUP BY pais , MONTH(fecha_registro) , YEAR(fecha_registro)
ORDER BY num_clientes DESC;

-- 3) Ordenas las consultas anteriores--

-- 4) Precio promedio agrupando por categoría e inicial del nombre con más de 3 unidades de stock--
SELECT 
	AVG(precio) AS precio_promedio,
    categoria,SUBSTRING(nombre, 1, 1) AS inicial
FROM
    productos
WHERE
    stock > 3
GROUP BY categoria , SUSBSTRING(nombre, 1, 1)
ORDER BY precio_promedio desc;

-- 5) ¿Cuántos clientes cuyo nombre empieza por 'A' se han registrado cada año?--
SELECT 
    COUNT(*) AS num_clientes, YEAR(fecha_registro)
FROM
    clientes
WHERE
    nombre LIKE 'A%'
GROUP BY YEAR(fecha_registro);

-- 6.1) ¿Cuántos productos distintos se han pedido en cada pedido?--
SELECT 
    id_pedido, COUNT(DISTINCT id_producto) AS num_productos
FROM
    detalle_pedido
GROUP BY id_pedido;

-- 6.2) ¿Cuántos productos en total se han pedido en cada pedido?--
SELECT 
    id_pedido, SUM(cantidad) AS num_productos
FROM
    detalle_pedido
GROUP BY id_pedido;

-- 7.2) Obtén el listado de los pedidos que han solicitado más de 10 productos--
SELECT 
    id_pedido, count(cantidad)
FROM
    detalle_pedido
GROUP BY id_pedido
HAVING SUM(cantidad) > 10;

-- 7.2) Obtén el listado de los pedidos que han solicitado más de 10 productos--
SELECT 
    id_pedido, SUM(cantidad)
FROM
    detalle_pedido
GROUP BY id_pedido
HAVING SUM(cantidad) > 10;