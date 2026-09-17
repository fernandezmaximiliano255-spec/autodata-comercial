DROP TABLE IF EXISTS ventas, vehiculos, clientes, vendedores, sucursales CASCADE;

CREATE TABLE sucursales (
    sucursal_id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    provincia VARCHAR(60) NOT NULL,
    zona VARCHAR(30) NOT NULL CHECK (zona IN ('CABA', 'Norte', 'Oeste', 'Sur'))
);

CREATE TABLE vendedores (
    vendedor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    sucursal_id INT NOT NULL REFERENCES sucursales(sucursal_id),
    fecha_ingreso DATE NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    ciudad VARCHAR(60) NOT NULL,
    provincia VARCHAR(60) NOT NULL,
    segmento VARCHAR(20) NOT NULL CHECK (segmento IN ('Particular', 'Empresa')),
    fecha_alta DATE NOT NULL
);

CREATE TABLE vehiculos (
    vehiculo_id SERIAL PRIMARY KEY,
    marca VARCHAR(40) NOT NULL,
    modelo VARCHAR(60) NOT NULL,
    anio INT NOT NULL CHECK (anio BETWEEN 2015 AND 2026),
    tipo VARCHAR(30) NOT NULL CHECK (tipo IN ('Sedán', 'SUV', 'Hatchback', 'Pickup', 'Utilitario')),
    combustible VARCHAR(20) NOT NULL CHECK (combustible IN ('Nafta', 'Diésel', 'Híbrido', 'Eléctrico')),
    precio_lista NUMERIC(14, 2) NOT NULL CHECK (precio_lista > 0),
    costo_adquisicion NUMERIC(14, 2) NOT NULL CHECK (costo_adquisicion > 0),
    estado VARCHAR(20) NOT NULL DEFAULT 'Disponible' CHECK (estado IN ('Disponible', 'Reservado', 'Vendido'))
);

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    vehiculo_id INT NOT NULL UNIQUE REFERENCES vehiculos(vehiculo_id),
    cliente_id INT NOT NULL REFERENCES clientes(cliente_id),
    vendedor_id INT NOT NULL REFERENCES vendedores(vendedor_id),
    sucursal_id INT NOT NULL REFERENCES sucursales(sucursal_id),
    fecha_venta DATE NOT NULL,
    precio_final NUMERIC(14, 2) NOT NULL CHECK (precio_final > 0),
    medio_pago VARCHAR(25) NOT NULL CHECK (medio_pago IN ('Contado', 'Financiado', 'Plan de ahorro')),
    cuotas INT NOT NULL DEFAULT 1 CHECK (cuotas BETWEEN 1 AND 84),
    descuento NUMERIC(14, 2) NOT NULL DEFAULT 0 CHECK (descuento >= 0)
);

CREATE INDEX idx_ventas_fecha ON ventas(fecha_venta);
CREATE INDEX idx_ventas_sucursal ON ventas(sucursal_id);
CREATE INDEX idx_vehiculos_estado ON vehiculos(estado);

INSERT INTO sucursales (nombre, ciudad, provincia, zona) VALUES
('AutoData Centro', 'Buenos Aires', 'CABA', 'CABA'),
('AutoData Norte', 'San Isidro', 'Buenos Aires', 'Norte'),
('AutoData Oeste', 'Morón', 'Buenos Aires', 'Oeste');

INSERT INTO vendedores (nombre, apellido, sucursal_id, fecha_ingreso) VALUES
('Lucía', 'Martínez', 1, '2022-03-14'),
('Facundo', 'Ríos', 1, '2023-08-01'),
('Carla', 'Benítez', 2, '2021-11-22'),
('Nicolás', 'Sosa', 3, '2024-02-05'),
('Marina', 'Pereyra', 2, '2024-06-17');

INSERT INTO clientes (nombre, apellido, ciudad, provincia, segmento, fecha_alta) VALUES
('Martín', 'Acosta', 'Caballito', 'CABA', 'Particular', '2025-01-12'),
('Sofía', 'Vega', 'Palermo', 'CABA', 'Particular', '2025-01-19'),
('Diego', 'Navarro', 'Vicente López', 'Buenos Aires', 'Particular', '2025-02-03'),
('Estudio Delta', 'SRL', 'San Isidro', 'Buenos Aires', 'Empresa', '2025-02-14'),
('Valentina', 'Luna', 'Ramos Mejía', 'Buenos Aires', 'Particular', '2025-03-08'),
('Transporte Sur', 'SA', 'Morón', 'Buenos Aires', 'Empresa', '2025-03-22'),
('Julián', 'Molina', 'Belgrano', 'CABA', 'Particular', '2025-04-11'),
('Camila', 'Ferreyra', 'Olivos', 'Buenos Aires', 'Particular', '2025-04-25'),
('Grupo Horizonte', 'SA', 'Tigre', 'Buenos Aires', 'Empresa', '2025-05-09'),
('Agustín', 'Romero', 'Haedo', 'Buenos Aires', 'Particular', '2025-05-18'),
('Paula', 'Giménez', 'Villa Devoto', 'CABA', 'Particular', '2025-06-02'),
('Logística Plata', 'SRL', 'Merlo', 'Buenos Aires', 'Empresa', '2025-06-20');

INSERT INTO vehiculos (marca, modelo, anio, tipo, combustible, precio_lista, costo_adquisicion, estado) VALUES
('Toyota', 'Corolla XEI', 2023, 'Sedán', 'Híbrido', 32500000, 27600000, 'Vendido'),
('Volkswagen', 'T-Cross Comfortline', 2024, 'SUV', 'Nafta', 38900000, 33200000, 'Vendido'),
('Ford', 'Ranger XLT', 2023, 'Pickup', 'Diésel', 54800000, 47600000, 'Vendido'),
('Fiat', 'Cronos Drive', 2024, 'Sedán', 'Nafta', 24900000, 21100000, 'Vendido'),
('Peugeot', '208 Allure', 2023, 'Hatchback', 'Nafta', 27600000, 23700000, 'Vendido'),
('Renault', 'Kangoo Express', 2022, 'Utilitario', 'Diésel', 31200000, 27100000, 'Vendido'),
('Toyota', 'Yaris XLS', 2024, 'Hatchback', 'Nafta', 29100000, 24900000, 'Vendido'),
('Chevrolet', 'Tracker Premier', 2024, 'SUV', 'Nafta', 41500000, 35900000, 'Vendido'),
('Volkswagen', 'Amarok Comfortline', 2023, 'Pickup', 'Diésel', 58900000, 51200000, 'Vendido'),
('Nissan', 'Kicks Advance', 2024, 'SUV', 'Nafta', 37800000, 32700000, 'Vendido'),
('Honda', 'HR-V LX', 2023, 'SUV', 'Nafta', 43200000, 37400000, 'Disponible'),
('Fiat', 'Pulse Drive', 2024, 'SUV', 'Nafta', 29800000, 25700000, 'Disponible'),
('Ford', 'Territory SEL', 2024, 'SUV', 'Nafta', 61500000, 53800000, 'Reservado'),
('Renault', 'Duster Intens', 2023, 'SUV', 'Nafta', 34500000, 29700000, 'Disponible'),
('Volkswagen', 'Polo Highline', 2024, 'Hatchback', 'Nafta', 31900000, 27400000, 'Disponible');

INSERT INTO ventas (vehiculo_id, cliente_id, vendedor_id, sucursal_id, fecha_venta, precio_final, medio_pago, cuotas, descuento) VALUES
(1, 1, 1, 1, '2025-01-20', 31900000, 'Financiado', 36, 600000),
(2, 2, 2, 1, '2025-02-15', 38200000, 'Contado', 1, 700000),
(3, 3, 3, 2, '2025-02-28', 53500000, 'Financiado', 48, 1300000),
(4, 4, 1, 1, '2025-03-10', 24400000, 'Financiado', 24, 500000),
(5, 5, 4, 3, '2025-03-29', 26900000, 'Contado', 1, 700000),
(6, 6, 4, 3, '2025-04-18', 30600000, 'Financiado', 36, 600000),
(7, 7, 1, 1, '2025-04-30', 28500000, 'Contado', 1, 600000),
(8, 8, 3, 2, '2025-05-16', 40700000, 'Financiado', 48, 800000),
(9, 9, 5, 2, '2025-05-30', 57500000, 'Plan de ahorro', 60, 1400000),
(10, 10, 4, 3, '2025-06-14', 37100000, 'Contado', 1, 700000);

-- 1. Facturación y unidades vendidas por mes.
SELECT DATE_TRUNC('month', fecha_venta)::DATE AS mes,
       COUNT(*) AS unidades_vendidas,
       SUM(precio_final) AS facturacion
FROM ventas
GROUP BY mes
ORDER BY mes;

-- 2. Marcas con mayor cantidad de ventas y facturación.
SELECT v.marca,
       COUNT(*) AS unidades_vendidas,
       SUM(ve.precio_final) AS facturacion
FROM ventas ve
JOIN vehiculos v ON v.vehiculo_id = ve.vehiculo_id
GROUP BY v.marca
ORDER BY facturacion DESC;

-- 3. Rendimiento comercial por vendedor.
SELECT ve.vendedor_id,
       ve.nombre || ' ' || ve.apellido AS vendedor,
       s.nombre AS sucursal,
       COUNT(*) AS ventas,
       SUM(ven.precio_final) AS facturacion,
       ROUND(AVG(ven.precio_final), 2) AS ticket_promedio
FROM ventas ven
JOIN vendedores ve ON ve.vendedor_id = ven.vendedor_id
JOIN sucursales s ON s.sucursal_id = ven.sucursal_id
GROUP BY ve.vendedor_id, vendedor, s.nombre
ORDER BY facturacion DESC;

-- 4. Margen estimado por vehículo vendido.
SELECT v.marca,
       v.modelo,
       ven.precio_final,
       v.costo_adquisicion,
       ven.precio_final - v.costo_adquisicion AS margen_estimado,
       ROUND((ven.precio_final - v.costo_adquisicion) / ven.precio_final * 100, 2) AS margen_porcentual
FROM ventas ven
JOIN vehiculos v ON v.vehiculo_id = ven.vehiculo_id
ORDER BY margen_estimado DESC;

-- 5. Estado actual del inventario.
SELECT estado,
       COUNT(*) AS cantidad_vehiculos,
       SUM(precio_lista) AS valor_inventario
FROM vehiculos
GROUP BY estado
ORDER BY estado;

-- 6. Distribución de ventas por medio de pago.
SELECT medio_pago,
       COUNT(*) AS operaciones,
       SUM(precio_final) AS facturacion,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS porcentaje_operaciones
FROM ventas
GROUP BY medio_pago
ORDER BY operaciones DESC;

-- 7. Clientes empresa y facturación generada.
SELECT c.nombre,
       c.apellido,
       c.provincia,
       COUNT(ve.venta_id) AS compras,
       COALESCE(SUM(ve.precio_final), 0) AS facturacion
FROM clientes c
LEFT JOIN ventas ve ON ve.cliente_id = c.cliente_id
WHERE c.segmento = 'Empresa'
GROUP BY c.cliente_id
ORDER BY facturacion DESC;


-- 1. ¿Qué marcas se venden más?
SELECT
    v.marca,
    COUNT(*) AS unidades_vendidas
FROM ventas ve
JOIN vehiculos v
    ON v.vehiculo_id = ve.vehiculo_id
GROUP BY v.marca
ORDER BY unidades_vendidas DESC;


-- 2. ¿Cuál es la facturación mensual?
SELECT
    v.marca,
    COUNT(*) AS unidades_vendidas,
    SUM(ve.precio_final) AS facturacion_total
FROM ventas ve
JOIN vehiculos v
    ON v.vehiculo_id = ve.vehiculo_id
GROUP BY v.marca
ORDER BY unidades_vendidas DESC, facturacion_total DESC;

-- 3. ¿Qué sucursal tiene mayor facturación?
SELECT
    s.nombre AS sucursal,
    s.zona,
    COUNT(ve.venta_id) AS ventas,
    SUM(ve.precio_final) AS facturacion
FROM ventas ve
JOIN sucursales s ON s.sucursal_id = ve.sucursal_id
GROUP BY s.sucursal_id, s.nombre, s.zona
ORDER BY facturacion DESC;

-- 4. ¿Qué vendedor tiene mejor rendimiento?
SELECT
    ven.nombre || ' ' || ven.apellido AS vendedor,
    COUNT(ve.venta_id) AS ventas,
    SUM(ve.precio_final) AS facturacion,
    ROUND(AVG(ve.precio_final), 2) AS ticket_promedio
FROM ventas ve
JOIN vendedores ven ON ven.vendedor_id = ve.vendedor_id
GROUP BY ven.vendedor_id, vendedor
ORDER BY facturacion DESC;

-- 5. ¿Cuál es el ticket promedio de las ventas?
SELECT
    COUNT(*) AS cantidad_ventas,
    SUM(precio_final) AS facturacion_total,
    ROUND(AVG(precio_final), 2) AS ticket_promedio
FROM ventas;

-- 6. ¿Qué vehículos generaron mayor margen estimado?
SELECT
    v.marca,
    v.modelo,
    ve.precio_final,
    v.costo_adquisicion,
    ve.precio_final - v.costo_adquisicion AS margen_estimado,
    ROUND(
        (ve.precio_final - v.costo_adquisicion)
        / ve.precio_final * 100,
        2
    ) AS margen_porcentual
FROM ventas ve
JOIN vehiculos v ON v.vehiculo_id = ve.vehiculo_id
ORDER BY margen_estimado DESC;

-- 8. ¿Qué medio de pago utilizan más los clientes?
SELECT
    medio_pago,
    COUNT(*) AS cantidad_operaciones,
    SUM(precio_final) AS facturacion,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS porcentaje_operaciones
FROM ventas
GROUP BY medio_pago
ORDER BY cantidad_operaciones DESC;

-- 9. ¿Qué provincias concentran más ventas?
SELECT
    c.provincia,
    COUNT(ve.venta_id) AS ventas,
    COUNT(DISTINCT c.cliente_id) AS clientes,
    SUM(ve.precio_final) AS facturacion
FROM ventas ve
JOIN clientes c ON c.cliente_id = ve.cliente_id
GROUP BY c.provincia
ORDER BY ventas DESC;

-- 10. ¿Qué tipo de vehículo se vende más?
SELECT
    v.tipo,
    COUNT(*) AS unidades_vendidas,
    SUM(ve.precio_final) AS facturacion,
    ROUND(AVG(ve.precio_final), 2) AS ticket_promedio
FROM ventas ve
JOIN vehiculos v ON v.vehiculo_id = ve.vehiculo_id
GROUP BY v.tipo
ORDER BY unidades_vendidas DESC;

CREATE VIEW reporte_ventas AS
SELECT
    ve.venta_id,
    ve.fecha_venta,
    v.marca,
    v.modelo,
    v.tipo,
    c.segmento,
    c.provincia,
    ven.nombre || ' ' || ven.apellido AS vendedor,
    s.nombre AS sucursal,
    s.zona,
    ve.precio_final,
    v.costo_adquisicion,
    ve.precio_final - v.costo_adquisicion AS margen_estimado,
    ve.medio_pago,
    ve.cuotas
FROM ventas ve
JOIN vehiculos v ON v.vehiculo_id = ve.vehiculo_id
JOIN clientes c ON c.cliente_id = ve.cliente_id
JOIN vendedores ven ON ven.vendedor_id = ve.vendedor_id
JOIN sucursales s ON s.sucursal_id = ve.sucursal_id;

SELECT *
FROM reporte_ventas;

-- KPI 1: facturación total contra objetivo comercial.
WITH resultados AS (
    SELECT
        SUM(precio_final) AS facturacion_actual,
        COUNT(*) AS unidades_vendidas
    FROM ventas
)
SELECT
    facturacion_actual,
    400000000::NUMERIC AS objetivo_facturacion,
    ROUND(facturacion_actual / 400000000 * 100, 2) AS cumplimiento_facturacion,
    unidades_vendidas,
    12 AS objetivo_unidades,
    ROUND(unidades_vendidas * 100.0 / 12, 2) AS cumplimiento_unidades
FROM resultados;

-- KPI 2: facturación mensual contra objetivo mensual.
SELECT
    DATE_TRUNC('month', fecha_venta)::DATE AS mes,
    SUM(precio_final) AS facturacion_actual,
    40000000::NUMERIC AS objetivo_mensual,
    ROUND(SUM(precio_final) / 40000000 * 100, 2) AS cumplimiento_mensual
FROM ventas
GROUP BY mes
ORDER BY mes;

