SELECT 
    nombre,
    email,
    pedidos.id_pedido,
    id_producto,
    precio_unitario
FROM
    clientes
        JOIN
    pedidos ON clientes.id_cliente = pedidos.id_cliente
        JOIN
    detalle_pedido ON pedidos.id_pedido = detalle_pedido.id_pedido
WHERE
    nombre LIKE 'Ana Torres';
    
-- Pedidos 2023 pagados con tarjeta--
SELECT 
    pedidos.id_pedido, id_cliente, estado, metodo_pago
FROM
    pedidos
        JOIN
    pagos ON pedidos.id_pedido = pagos.id_pedido
WHERE
    YEAR(fecha_pedido) = '2023'
        AND metodo_pago = 'tarjeta';

-- Obtén los pedidos pendientes que se han pagado con tarjeta--
SELECT 
    pedidos.id_pedido, id_cliente, estado,fecha_pago, metodo_pago,total_pagado
FROM
    pedidos
        JOIN
    pagos ON pedidos.id_pedido = pagos.id_pedido
WHERE
    estado = 'pendiente'
        AND metodo_pago = 'tarjeta';

-- Obtén los nombres de los productos que se han comprado juntos más de 3 veces en algún pedido--
SELECT 
    productos.nombre,
    detalle_pedido.cantidad,
    detalle_pedido.id_pedido
FROM
    productos
        JOIN
    detalle_pedido ON productos.id_producto = detalle_pedido.id_producto
WHERE
    detalle_pedido.cantidad > 0;

-- Obtén los productos que se han comprado juntos más de 3 veces en algún pedido en 2024--
SELECT 
    productos.nombre,
    detalle_pedido.cantidad,
    detalle_pedido.id_pedido
FROM
    productos
        JOIN
    detalle_pedido ON productos.id_producto = detalle_pedido.id_producto
        JOIN
    pedidos ON detalle_pedido.id_pedido = pedidos.id_pedido
WHERE
    detalle_pedido.cantidad > 0
        AND YEAR(pedidos.fecha_pedido) = '2024';

-- Obtén los nombres de los productos que ha comprado Ana Torres--
SELECT 
    productos.nombre
FROM
    productos
        JOIN
    detalle_pedido ON productos.id_producto = detalle_pedido.id_producto
        JOIN
    pedidos ON detalle_pedido.id_pedido = pedidos.id_pedido
        JOIN
    clientes ON pedidos.id_cliente = clientes.id_cliente
WHERE
    cliente.nombre = 'Ana Torres';

-- Obtén los nombres de los productos que ha comprado Ana Torres--
SELECT 
    productos.nombre
FROM
    productos
        JOIN
    detalle_pedido ON productos.id_producto = detalle_pedido.id_producto
        JOIN
    pedidos ON detalle_pedido.id_pedido = pedidos.id_pedido
        JOIN
    clientes ON pedidos.id_cliente = clientes.id_cliente
WHERE
    clientes.nombre = 'Ana Torres';
    
    
-- ¿Cuántos pedidos se han comprado por clientes de Argentina?--
select count(*) as num_pedidos,pais
from pedidos 
join clientes on pedidos.id_cliente = clientes.id_cliente
where pais = "Argentina";

-- ¿Cuántos productos se han comprado por clientes de Argentina?--
select count(*) as num_productos
from productos
join detalle_pedido ON productos.id_producto = detalle_pedido.id_producto
join pedidos ON detalle_pedido.id_pedido = pedidos.id_pedido
JOIN clientes ON pedidos.id_cliente = clientes.id_cliente
where pais = "Argentina";

-- ¿Cuántos productos se han comprado por pais de origen del cliente?--
select clientes.pais,count(*) as num_prod_distintos,sum(cantidad) as num_prod_totales
from productos
join detalle_pedido ON productos.id_producto = detalle_pedido.id_producto
join pedidos ON detalle_pedido.id_pedido = pedidos.id_pedido
JOIN clientes ON pedidos.id_cliente = clientes.id_cliente
group by pais
order by num_prod_totales desc;

-- ¿Cuántos productos se han comprado por pais de origen y categoria del cliente?--
select clientes.pais,productos.categoria,count(detalle_pedido.id_producto) as num_prod_distintos,sum(cantidad) as num_prod_totales
from clientes
join pedidos on clientes.id_cliente=pedidos.id_cliente
join detalle_pedido on pedidos.id_pedido=detalle_pedido.id_pedido
join productos on detalle_pedido.id_producto=productos.id_producto
group by clientes.pais,productos.categoria
order by clientes.pais,productos.categoria; -- No es la mejor forma pero hay q ordenarlo de alguna manera--

-- 1) Listar cada id del pedido con el nombre del cliente que lo realizó.
select id_pedido,nombre
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
order by nombre asc,id_pedido asc;

-- 2) Listar cada línea de detalle con el nombre del producto y el id del pedido.
select id_detalle,productos.nombre,pedidos.id_pedido
from productos
join detalle_pedido on productos.id_producto=detalle_pedido.id_producto
join pedidos on detalle_pedido.id_pedido=pedidos.id_pedido
order by productos.nombre asc, id_pedido asc;

-- 3) Listar cada pedido con el nombre del cliente y su coste total.
select clientes.nombre,id_pedido,coste_total
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
order by coste_total desc, id_pedido asc;

-- Listar pedidos realizados a partir del 1 de enero de 2024 (incluido), con nombre del cliente y fecha.
select id_pedido,nombre,fecha_pedido
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
where fecha_pedido > "2024-01-01"
order by fecha_pedido asc, id_pedido asc;

-- 5) Listar pedidos cuyo estado sea 'cancelado' o 'pendiente', con cliente y coste_total.
select id_pedido,clientes.nombre,estado,coste_total
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
where estado IN("cancelado","pendiente")
order by estado asc,coste_total desc;

-- 6) Listar pagos con su pedido y cliente, mostrando el método de pago.
select pedidos.id_pedido,clientes.nombre,metodo_pago
from pagos
join pedidos on pagos.id_pedido=pedidos.id_pedido
join clientes on pedidos.id_cliente=clientes.id_cliente
order by id_pedido asc;

-- 7) Listar las líneas del pedido con id 10, incluyendo nombre del producto, cantidad y precio unitario.
select nombre, cantidad, precio_unitario
from productos
join detalle_pedido on productos.id_producto=detalle_pedido.id_producto
join pedidos on detalle_pedido.id_pedido=pedidos.id_pedido
where pedidos.id_pedido=10
order by nombre asc;

-- 8) Listar pedidos con estado 'entregado' con nombre del cliente y fecha del pedido.
select id_pedido,nombre,fecha_pedido
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
where estado="entregado"
order by fecha_pedido asc, id_pedido asc;

-- 9) Calcular la suma total pagada por cada pedido que tenga al menos un pago.
select pedidos.id_pedido,sum(total_pagado) as sum_total
from pagos
join pedidos on pagos.id_pedido=pedidos.id_pedido
group by id_pedido
having sum_total != 0
order by sum_total desc,id_pedido asc;

-- 10) Contar el número de pedidos realizados por cada cliente.
select count(id_pedido) as num_pedidos,nombre
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
group by nombre
order by num_pedidos desc, nombre asc;

-- 11) Listar los clientes que poseen MÁS DE 3 pedidos (estrictamente > 3).
select count(id_pedido) as num_pedidos, nombre
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
group by nombre
having num_pedidos > 3
order by num_pedidos desc, nombre asc;

-- 12) Calcular los ingresos totales por cada producto (cantidad * precio_unitario) considerando SOLO líneas existentes.
select id_producto,sum(cantidad*precio_unitario) as ingresos_totales
from detalle_pedido
join pedidos ON detalle_pedido.id_pedido = pedidos.id_pedido
group by id_producto
order by ingresos_totales desc, id_producto asc;

-- 13) Listar los productos cuyo ingreso total (cantidad * precio_unitario) sea superior a 10.000,00 euros.
select id_producto,sum(cantidad*precio_unitario) as ingresos_totales
from detalle_pedido
join pedidos ON detalle_pedido.id_pedido = pedidos.id_pedido
group by id_producto
having ingresos_totales > 10000
order by ingresos_totales desc, id_producto asc;

-- 14) Listar los pedidos cuyo estado sea 'entregado' O 'enviado' y cuyo cliente tenga país 'España' O 'México'.
select id_pedido,pais,estado
from pedidos
join clientes on pedidos.id_cliente=clientes.id_cliente
where estado IN("entregado","enviado") and pais in("españa","mexico")
order by pais asc, estado asc, id_pedido asc;

-- 15) Listar productos con precio_unitario > 200 en líneas pertenecientes a pedidos CANCELADOS.
select distinct productos.id_producto
from productos
join detalle_pedido on productos.id_producto=detalle_pedido.id_producto
join pedidos on detalle_pedido.id_pedido=pedidos.id_pedido
where precio_unitario > 200 and estado = "cancelado"
order by id_producto asc;

-- 16) Listar clientes registrados en 2024 que tengan al menos un pedido en estado 'pendiente' O 'enviado' (no entregado ni cancelado).
select distinct nombre, estado
from clientes
join pedidos on clientes.id_cliente=pedidos.id_cliente
where year(fecha_registro)="2024" and estado in("pendiente","enviado")
order by estado asc, nombre asc;
