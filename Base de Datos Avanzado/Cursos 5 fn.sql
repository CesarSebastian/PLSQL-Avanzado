/*PlSQL OO*/
CREATE OR REPLACE TYPE direccion AS OBJECT 
(
casa_num VARCHAR2(10),
calle VARCHAR2(30),
ciudad VARCHAR2(20),
estado VARCHAR2(10),
CP VARCHAR2(10)
);
/
CREATE OR REPLACE TYPE cliente AS OBJECT 
(
codigo NUMBER(5),
nombre VARCHAR2(30),
num_contacto VARCHAR2(12),
addr direccion,
member procedure display
);
/
/*Creacion de instancia del objeto*/
DECLARE 
	recidentes direccion;
BEGIN 
	recidentes := direccion('392','poniente 16','Nezahualcoyotl','Mexico','57820');
	DBMS_OUTPUT.PUT_LINE('Número de casa '||recidentes.casa_num);
	DBMS_OUTPUT.PUT_LINE('Calle '||recidentes.calle);
	DBMS_OUTPUT.PUT_LINE('Ciudad'||recidentes.ciudad);
	DBMS_OUTPUT.PUT_LINE('Estado '||recidentes.estado);
	DBMS_OUTPUT.PUT_LINE('CP '||recidentes.CP);
END;
/
/*Herencia*/
CREATE OR REPLACE TYPE figuraGeometrica AS OBJECT
(
	color VARCHAR2(30),
	textura VARCHAR2(20),
	NOT FINAL MEMBER PROCEDURE calculaPerimetro
) NOT FINAL;
/
CREATE OR REPLACE TYPE BODY figuraGeometrica AS 
	MEMBER PROCEDURE calculaPerimetro IS 
		BEGIN
			DBMS_OUTPUT.PUT_LINE('Color: ' || color);
			DBMS_OUTPUT.PUT_LINE('Textura: ' || textura);
		END;
	END;
/
/*SUBTIPO*/
CREATE OR REPLACE TYPE triangulo UNDER figuraGeometrica(
	base NUMERIC,
	altura NUMERIC,
	OVERRIDING MEMBER PROCEDURE calculaPerimetro
);
/
CREATE OR REPLACE TYPE circulo UNDER figuraGeometrica(
	radio NUMERIC,
	OVERRIDING MEMBER PROCEDURE calculaPerimetro
);
/
CREATE OR REPLACE TYPE cuadrado UNDER figuraGeometrica(
	lado NUMERIC,
	OVERRIDING MEMBER PROCEDURE calculaPerimetro
);
/
CREATE OR REPLACE TYPE rectangulo UNDER figuraGeometrica(
	largo NUMERIC,
	ancho NUMERIC, 
	OVERRIDING MEMBER PROCEDURE calculaPerimetro
);
/
/*Cuerpo*/
CREATE OR REPLACE TYPE BODY triangulo AS 
	OVERRIDING MEMBER PROCEDURE calculaPerimetro IS 
		perimetro NUMERIC;
		BEGIN
			perimetro := (2*base + 2*altura);
			DBMS_OUTPUT.PUT_LINE('Color: '||color);
			DBMS_OUTPUT.PUT_LINE('Textura: '||textura);
			DBMS_OUTPUT.PUT_LINE('Base: '||base||', Altura: '||altura);
			DBMS_OUTPUT.PUT_LINE('Perimetro: '||perimetro);
		END calculaPerimetro;
END;
/
CREATE OR REPLACE TYPE BODY circulo AS 
	OVERRIDING MEMBER PROCEDURE calculaPerimetro IS 
		perimetro NUMERIC;
		BEGIN
			perimetro := (3.1416 + (2*radio));
			DBMS_OUTPUT.PUT_LINE('Color: '||color);
			DBMS_OUTPUT.PUT_LINE('Textura: '||textura);
			DBMS_OUTPUT.PUT_LINE('Radio: '||radio);
			DBMS_OUTPUT.PUT_LINE('Perimetro: '||perimetro);
		END calculaPerimetro;
END;
/
CREATE OR REPLACE TYPE BODY cuadrado AS 
	OVERRIDING MEMBER PROCEDURE calculaPerimetro IS 
		perimetro NUMERIC;
		BEGIN
			perimetro := (lado*lado*lado*lado);
			DBMS_OUTPUT.PUT_LINE('Color: '||color);
			DBMS_OUTPUT.PUT_LINE('Textura: '||textura);
			DBMS_OUTPUT.PUT_LINE('Lado: '||lado);
			DBMS_OUTPUT.PUT_LINE('Perimetro: '||perimetro);
		END calculaPerimetro;
END;
/
CREATE OR REPLACE TYPE BODY rectangulo AS 
	OVERRIDING MEMBER PROCEDURE calculaPerimetro IS 
		perimetro NUMERIC;
		BEGIN
			perimetro := ((2*largo)+(2*ancho));
			DBMS_OUTPUT.PUT_LINE('Color: '||color);
			DBMS_OUTPUT.PUT_LINE('Textura: '||textura);
			DBMS_OUTPUT.PUT_LINE('Largo: '||largo||', Ancho: '||ancho);
			DBMS_OUTPUT.PUT_LINE('Perimetro: '||perimetro);
		END calculaPerimetro;
END;
/
DECLARE 
	tri triangulo;
BEGIN
	tri := triangulo('azul','solida',32,25);
	tri.calculaPerimetro;
END;
/
/*EJERCICIO*/
DROP TYPE factura;
DROP TYPE retencion;
DROP TYPE tipoDocumento;
CREATE OR REPLACE TYPE tipoDocumento AS OBJECT 
(
	emisor VARCHAR2(30),
	folio VARCHAR2(3),
	NOT INSTANTIABLE NOT FINAL MEMBER PROCEDURE tipoDocumentos
) NOT INSTANTIABLE NOT FINAL;
/
CREATE OR REPLACE TYPE BODY tipoDocumento AS 
		MEMBER PROCEDURE tipoDocumentos IS 
		BEGIN
			DBMS_OUTPUT.PUT_LINE('Emisor: '||emisor);
			DBMS_OUTPUT.PUT_LINE('Folio: '||folio);
		END;
	END;
/
/**/
CREATE OR REPLACE TYPE factura UNDER tipoDocumento(
	sello VARCHAR2(30),
	qr VARCHAR2(100),
	OVERRIDING MEMBER PROCEDURE tipoDocumentos
);
/
CREATE OR REPLACE TYPE retencion UNDER tipoDocumento(
	uuid VARCHAR2(20),
	receptor VARCHAR2(30),
	OVERRIDING MEMBER PROCEDURE tipoDocumentos
);
/
CREATE OR REPLACE TYPE BODY factura AS 
	OVERRIDING MEMBER PROCEDURE tipoDocumentos IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('Emisor: '||emisor);
		DBMS_OUTPUT.PUT_LINE('Folio: '||folio);
		DBMS_OUTPUT.PUT_LINE('Sello: '||sello);
		DBMS_OUTPUT.PUT_LINE('QR: '||qr);
	END tipoDocumentos;
END;
/
CREATE OR REPLACE TYPE BODY retencion AS 
	OVERRIDING MEMBER PROCEDURE tipoDocumentos IS 
	BEGIN
		DBMS_OUTPUT.PUT_LINE('Emisor: '||emisor);
		DBMS_OUTPUT.PUT_LINE('Folio: '||folio);
		DBMS_OUTPUT.PUT_LINE('UUID: '||uuid);
		DBMS_OUTPUT.PUT_LINE('Receptor: '||receptor);
	END tipoDocumentos;
END;
/

/*Ejecucion*/
DECLARE 
	fac factura;
BEGIN
	fac := factura('YO','A1','asfg23r-efsdf2','Otro');
	fac.tipoDocumentos;
END;
/