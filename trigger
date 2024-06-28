/* EXERCÍCIO
Criar uma trigger que valide se o dinossauro que esta sendo cadastrado esta vinculado corretamente com a sua era conforme
o seu periodo de existência */

-- Trigger que verifica se os anos de início e fim do dinossauro estão dentro do intervalo de anos da era associada
CREATE OR REPLACE FUNCTION valida_era_dinossauro()
RETURNS TRIGGER AS $$
DECLARE
    era_inicio integer;
    era_fim integer;
BEGIN
    -- Busca os anos de início e fim da era informada
    SELECT ano_inicio, ano_fim INTO era_inicio, era_fim FROM eras WHERE id = NEW.fk_era;

    -- Verifica se os anos de existência do dinossauro estão dentro da era informada
    IF (NEW.inicio < era_inicio OR NEW.fim > era_fim) THEN
        RAISE EXCEPTION 'Os anos de existência do dinossauro não condizem com a era informada.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger que irá chamar a função valida_era_dinossauro antes de inserir ou atualizar um dinossauro
CREATE TRIGGER trg_valida_era_dinossauro
BEFORE INSERT OR UPDATE ON dinossauros
FOR EACH ROW
EXECUTE FUNCTION valida_era_dinossauro();

select * from dinossauros

INSERT INTO eras (nome, ano_inicio, ano_fim) values ('Triássico', 251, 200),('Jurássico', 200, 145),('Cretáceo', 145, 65);

INSERT INTO dinossauros (nome, toneladas, ano_descoberta,
	fk_grupo, fk_descobridor, fk_era, inicio, fim, fk_regiao) values 
	('Saichania',4,1977,1,1,3,145,66,1); -- Era Cretáceo (145 - 65)

INSERT INTO dinossauros (nome, toneladas, ano_descoberta,
	fk_grupo, fk_descobridor, fk_era, inicio, fim, fk_regiao) values 
	('Tricerátops',6,1887,2,2,3,70,66,2); -- Era Cretáceo (145 - 65)

-- ÚNICO QUE SERÁ INSERIDO
INSERT INTO dinossauros (nome, toneladas, ano_descoberta,
	fk_grupo, fk_descobridor, fk_era, inicio, fim, fk_regiao) values 
	('Kentrossauro',2,1909,3,3,2,200,145,3); -- Era Jurássico (200 - 145)

INSERT INTO dinossauros (nome, toneladas, ano_descoberta,
	fk_grupo, fk_descobridor, fk_era, inicio, fim, fk_regiao) values 
	('Pinacossauro',6,1999,1,4,1,85,75,4); -- Era Triássico (251 - 200)

INSERT INTO dinossauros (nome, toneladas, ano_descoberta,
	fk_grupo, fk_descobridor, fk_era, inicio, fim, fk_regiao) values 
	('Alossauro',3,1877,4,5,2,155,150,5); -- Era Jurássico (200 - 145)

INSERT INTO dinossauros (nome, toneladas, ano_descoberta,
	fk_grupo, fk_descobridor, fk_era, inicio, fim, fk_regiao) values 
	('Torossauro',8,1891,2,2,3,67,65,6); -- Era Cretáceo (145 - 65)

INSERT INTO dinossauros (nome, toneladas, ano_descoberta,
	fk_grupo, fk_descobridor, fk_era, inicio, fim, fk_regiao) values 
	('Anquilossauro',8,1906,1,6,1,66,63,5); -- Era Triássico (251 - 200)
