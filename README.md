# AutoData Comercial

Proyecto de análisis comercial para una agencia ficticia de vehículos en Argentina. El objetivo es transformar las operaciones de ventas en información clara para responder preguntas de negocio y apoyar decisiones comerciales.

## Qué incluye

- Modelo relacional en PostgreSQL con cinco tablas relacionadas.
- Datos ficticios cargados con tipos de datos, restricciones y claves foráneas.
- Consultas SQL para responder preguntas planteadas en una reunión comercial.
- Vista de reporte con indicadores y métricas de seguimiento.
- Dashboard en Power BI con facturación, unidades vendidas, ticket promedio, margen estimado y análisis por mes, marca, sucursal y vendedor.

## Tecnologías

- PostgreSQL
- SQL
- Power BI
- DBeaver

No se utiliza Python para limpiar los datos. La información se carga limpia desde SQL y se trabaja con un modelo estructurado desde el origen.

## Tablas

- sucursales
- vendedores
- clientes
- vehiculos
- ventas

## Archivos principales

- PanelComercialVehiculos.pbix: archivo editable del dashboard de Power BI.
- PanelComercialVehiculos.pdf.pdf: exportación del dashboard.
- SQLComercialVehiculos.sql: esquema, datos, consultas y reporte SQL.

## Orden de ejecución

1. Crear una base llamada autodata_comercial en PostgreSQL.
2. Ejecutar SQLComercialVehiculos.sql.
3. Conectar Power BI a PostgreSQL.
4. Construir o revisar las visualizaciones del panel comercial.

Todos los nombres, datos y operaciones son ficticios y están pensados para fines educativos y de portfolio.
