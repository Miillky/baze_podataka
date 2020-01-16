/* Strani ključ - Foreign key */
/* Strani ključevi se dodaju uvijek na child tablicu, a referenciraju se na parent tablicu. */
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
	FOREIGN KEY (column1, column2, ... column_n)
	REFERENCES parent_table (column1, column2, ... column_n);

/* Skripta za definiranje stranog ključa prilikom kreiranja tablice */
CREATE TABLE talbe_name
(
	column1 datatype null/not null,
	column1 datatype null/not null
	...
	CONSTRAINT fk_column
		FOREIGN KEY (column1, column2 ... column_n)
		REFERENCES parent_table (column1, column2 ... column_n)
);