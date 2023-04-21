--������� �� Holding (�������)
USE master;
DROP DATABASE IF EXISTS Holding;
CREATE DATABASE Holding;
USE Holding;

--������� ������� ����� Director (�������� ��������)
CREATE TABLE Director
(
  id INT NOT NULL PRIMARY KEY,
  fio NVARCHAR(150) NOT NULL
) AS NODE;
--������� � ������� Director 12 ������� (����� ����������):
INSERT INTO Director (id, fio)
VALUES
(1, '������ ������ ����������'),
(2, '������ ���� ���������'),
(3, '����������� ��������� �������������'),
(4, '�������� ������� ���������'),
(5, '�������� ���� �����'),
(6, '�������� ���� �����������'),
(7, '��������� ���� �������������'),
(8, '����� ������� �����'),
(9, '�������� ����� ��������'),
(10, '������� ���� ��������'),
(11, '�������� ����� ������������'),
(12, '�������� ������� �����������');
--������� ���������� ������� Director
SELECT *
FROM Director

--������� ������� ����� SisterCompany (�������� ��������)
CREATE TABLE SisterCompany
(
  id INT NOT NULL PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
) AS NODE;
--������� � ������� SisterCompany 10 �������:
INSERT INTO SisterCompany (id, name)
VALUES
(1, 'Showa Sekkei'),
(2, 'HMC Architects'),
(3, 'Page Southerland'),
(4, 'Atkins'),
(5, 'SmithGroup JJR'),
(6, 'Hassell'),
(7, 'Woods Bagot'),
(8, 'Perkins Eastman'),
(9, 'Gensler'),
(10, 'RSP Architects');
--������� ���������� ������� SisterCompany
SELECT *
FROM SisterCompany

--������� ������� ����� SubsidiaryCompany (�������� ��������)
CREATE TABLE SubsidiaryCompany
(
  id INT NOT NULL PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  sisterCompany NVARCHAR(100) NOT NULL,
) AS NODE;
--������� � ������� SubsidiaryCompany 15 �������:
INSERT INTO SubsidiaryCompany (id, name, sisterCompany)
VALUES
(1, 'Corgan', 'Woods Bagot'),
(2, 'Beck Group', 'HMC Architects'),
(3, 'Elkus Manfredi Architects', 'Gensler'),
(4, 'Ratio Architects', 'Perkins Eastman'),
(5, 'HNTB Corporation', 'Atkins'),
(6, 'Cuningham Group Architecture', 'SmithGroup JJR'),
(7, 'ZGF Architects', 'Page Southerland'),
(8, 'Robert A.M. Stern Architects', 'Showa Sekkei'),
(9, 'Cooper Carry', 'SmithGroup JJR'),
(10, 'Populous', 'RSP Architects'),
(11, 'TPG Architecture', 'Perkins Eastman'),
(12, 'LS3P', 'Hassell');
--������� ���������� ������� SubsidiaryCompany
SELECT *
FROM SubsidiaryCompany

--������� ������� ����� isFamiliar, ��� �������� ����� "���� �������� ������ � ������ ����������"
CREATE TABLE isFamiliar AS EDGE;

--������� ������� ����� containsSubCompany, ��� �������� ����� "�������� �������� �������� � ���� ��������" 
CREATE TABLE containsSubCompany AS EDGE;

--������� ������� ����� proposesToInclude, ��� �������� ����� "�������� ���������� �������� �������� �������� � �������"
CREATE TABLE proposesToInclude AS EDGE;

--������� ��� ������� �����, ������� � ��� ����������� �����
ALTER TABLE isFamiliar ADD CONSTRAINT EC_isFamiliar CONNECTION (Director TO Director);
ALTER TABLE containsSubCompany ADD CONSTRAINT EC_containsSubCompany CONNECTION (SisterCompany TO SubsidiaryCompany);
ALTER TABLE proposesToInclude ADD CONSTRAINT EC_proposesToInclude CONNECTION (Director TO SisterCompany);

--��������� ������� �����
INSERT INTO isFamiliar($from_id, $to_id)
VALUES ((SELECT $node_id FROM Director WHERE id = 1), (SELECT $node_id FROM Director WHERE id = 2)),
	   ((SELECT $node_id FROM Director WHERE id = 1), (SELECT $node_id FROM Director WHERE id = 3)),
	   ((SELECT $node_id FROM Director WHERE id = 2), (SELECT $node_id FROM Director WHERE id = 6)),
	   ((SELECT $node_id FROM Director WHERE id = 2), (SELECT $node_id FROM Director WHERE id = 9)),
	   ((SELECT $node_id FROM Director WHERE id = 3), (SELECT $node_id FROM Director WHERE id = 5)),
	   ((SELECT $node_id FROM Director WHERE id = 3), (SELECT $node_id FROM Director WHERE id = 8)),
	   ((SELECT $node_id FROM Director WHERE id = 5), (SELECT $node_id FROM Director WHERE id = 2)),
	   ((SELECT $node_id FROM Director WHERE id = 6), (SELECT $node_id FROM Director WHERE id = 11)),
	   ((SELECT $node_id FROM Director WHERE id = 7), (SELECT $node_id FROM Director WHERE id = 12)),
	   ((SELECT $node_id FROM Director WHERE id = 8), (SELECT $node_id FROM Director WHERE id = 4)),
	   ((SELECT $node_id FROM Director WHERE id = 8), (SELECT $node_id FROM Director WHERE id = 10)),
	   ((SELECT $node_id FROM Director WHERE id = 10), (SELECT $node_id FROM Director WHERE id = 7)),
	   ((SELECT $node_id FROM Director WHERE id = 10), (SELECT $node_id FROM Director WHERE id = 12)),
	   ((SELECT $node_id FROM Director WHERE id = 11), (SELECT $node_id FROM Director WHERE id = 7)),
	   ((SELECT $node_id FROM Director WHERE id = 11), (SELECT $node_id FROM Director WHERE id = 9)),
	   ((SELECT $node_id FROM Director WHERE id = 12), (SELECT $node_id FROM Director WHERE id = 8)),
	   ((SELECT $node_id FROM Director WHERE id = 12), (SELECT $node_id FROM Director WHERE id = 9));

INSERT INTO containsSubCompany($from_id, $to_id)
VALUES ((SELECT $node_id FROM SisterCompany WHERE id = 1), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 8)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 2), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 2)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 3), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 7)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 4), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 5)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 5), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 6)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 5), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 9)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 6), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 12)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 7), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 1)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 8), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 4)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 8), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 11)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 9), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 3)),
	   ((SELECT $node_id FROM SisterCompany WHERE id = 10), (SELECT $node_id FROM SubsidiaryCompany WHERE id = 10));


INSERT INTO proposesToInclude($from_id, $to_id)
VALUES ((SELECT $node_id FROM Director WHERE id = 1), (SELECT $node_id FROM SisterCompany WHERE id = 8)),
	   ((SELECT $node_id FROM Director WHERE id = 2), (SELECT $node_id FROM SisterCompany WHERE id = 9)),
	   ((SELECT $node_id FROM Director WHERE id = 3), (SELECT $node_id FROM SisterCompany WHERE id = 6)),
	   ((SELECT $node_id FROM Director WHERE id = 3), (SELECT $node_id FROM SisterCompany WHERE id = 10)),
	   ((SELECT $node_id FROM Director WHERE id = 4), (SELECT $node_id FROM SisterCompany WHERE id = 1)),
	   ((SELECT $node_id FROM Director WHERE id = 5), (SELECT $node_id FROM SisterCompany WHERE id = 2)),
	   ((SELECT $node_id FROM Director WHERE id = 5), (SELECT $node_id FROM SisterCompany WHERE id = 6)),
	   ((SELECT $node_id FROM Director WHERE id = 6), (SELECT $node_id FROM SisterCompany WHERE id = 5)),
	   ((SELECT $node_id FROM Director WHERE id = 7), (SELECT $node_id FROM SisterCompany WHERE id = 3)),
	   ((SELECT $node_id FROM Director WHERE id = 8), (SELECT $node_id FROM SisterCompany WHERE id = 6)),
	   ((SELECT $node_id FROM Director WHERE id = 8), (SELECT $node_id FROM SisterCompany WHERE id = 7)),
	   ((SELECT $node_id FROM Director WHERE id = 9), (SELECT $node_id FROM SisterCompany WHERE id = 6)),
	   ((SELECT $node_id FROM Director WHERE id = 10), (SELECT $node_id FROM SisterCompany WHERE id = 4)),
	   ((SELECT $node_id FROM Director WHERE id = 11), (SELECT $node_id FROM SisterCompany WHERE id = 2)),
	   ((SELECT $node_id FROM Director WHERE id = 11), (SELECT $node_id FROM SisterCompany WHERE id = 9)),
	   ((SELECT $node_id FROM Director WHERE id = 12), (SELECT $node_id FROM SisterCompany WHERE id = 8)),
	   ((SELECT $node_id FROM Director WHERE id = 12), (SELECT $node_id FROM SisterCompany WHERE id = 10));
      

--������� �� ������� � �������� ��������

--MATCH

--1. ���� �� ���������� ����� �������� �������� (������ ������ ����������)?
SELECT Director1.fio, Director2.fio AS [familiarDirector]
FROM Director AS Director1, isFamiliar, Director AS Director2
WHERE MATCH(Director1-(isFamiliar)->Director2) AND Director1.fio = '������ ������ ����������';

--2�. ����� �������� ���������� �������� � ������� ���� �� ���������� (����������� ��������� �������������)?
SELECT Director.fio, SisterCompany.name AS [companyName]
FROM Director AS Director, proposesToInclude, SisterCompany AS SisterCompany
WHERE MATCH(Director-(proposesToInclude)->SisterCompany) AND Director.fio = '����������� ��������� �������������';

--2�. ����� �������� ���������� �������� � ������� ���� �� ���������� (�������� ������� �����������)?
SELECT Director.fio, SisterCompany.name AS [companyName]
FROM Director AS Director, proposesToInclude, SisterCompany AS SisterCompany
WHERE MATCH(Director-(proposesToInclude)->SisterCompany) AND Director.fio = '�������� ������� �����������';

--3. ����� �������� �������� ������ � �������� �������� �������� Perkins Eastman?
SELECT SisterCompany.name AS [nameOfSisterComapny], SubsidiaryCompany.name AS [nameOfSubsidiaryCompany]
FROM SubsidiaryCompany AS SubsidiaryCompany, containsSubCompany, SisterCompany AS SisterCompany
WHERE MATCH(SubsidiaryCompany<-(containsSubCompany)-SisterCompany) AND SisterCompany.name = 'Perkins Eastman';

--4. ����� �������� �������� ������ � ������� ����� ����������� ��������� � id = 3 �������� ��������������� �������� ��������? 
--������� id � ��� ���������, �������� �������� � �������������� �� �������� ��������
SELECT Director.id AS [IDdirector], Director.fio AS [DirectorWhoProposes], SisterCompany.name AS [nameOfSisterCompany], SubsidiaryCompany.name AS [nameOfSubsidiaryCompany]
FROM SubsidiaryCompany AS SubsidiaryCompany, containsSubCompany, SisterCompany AS SisterCompany, proposesToInclude, Director AS Director
WHERE MATCH(SubsidiaryCompany<-(containsSubCompany)-SisterCompany<-(proposesToInclude)-Director) AND Director.id = 3;

--5. � ��� ����� ������������� �������� �������� (������ ������ ����������) ����� ������ ������� �� ������� ������� ���� ����������?
--������� ��� ��������� �������� � ��� ��� ������������� ����� ��������
SELECT DISTINCT Director1.fio AS [HoldingDirector], Director3.fio AS [newFamiliardirector]
FROM Director AS Director1, isFamiliar AS familiar1, Director AS Director2, isFamiliar AS familiar2, Director AS Director3
WHERE MATCH(Director1-(familiar1)->Director2-(familiar2)->Director3) AND Director1.fio = '������ ������ ����������' AND Director2.fio = '������ ���� ���������';

--SHORTEST_PATH

--1�. ����������� ��������� ���-�� ��������� ��������� �������� (������� ������� �����������)
SELECT Director1.fio AS holdingDirector, STRING_AGG(Director2.fio, '->') WITHIN GROUP (GRAPH PATH) AS newFamiliar
FROM Director AS Director1, isFamiliar FOR PATH AS familiar, Director FOR PATH AS Director2
WHERE MATCH(SHORTEST_PATH(Director1(-(familiar)->Director2)+)) AND Director1.fio = '������ ������ ����������';

--1�. ����������� ��������� ���-�� ��������� ������ �� ���������� (������ ������� ������)
SELECT Director1.fio AS holdingDirector, STRING_AGG(Director2.fio, '->') WITHIN GROUP (GRAPH PATH) AS newFamiliar
FROM Director AS Director1, isFamiliar FOR PATH AS familiar, Director FOR PATH AS Director2
WHERE MATCH(SHORTEST_PATH(Director1(-(familiar)->Director2)+)) AND Director1.fio = '����� ������� �����';

--2. ����������� �������� � ������������� �������� ��������� �������� (������� ������� �����������) �� ������� �� ����� 2�� �������
SELECT Director1.fio AS holdingDirector, STRING_AGG(Director2.fio, '->') WITHIN GROUP (GRAPH PATH) AS newFamiliar
FROM Director AS Director1, isFamiliar FOR PATH AS familiar, Director FOR PATH AS Director2
WHERE MATCH(SHORTEST_PATH(Director1(-(familiar)->Director2){1, 2})) AND Director1.fio = '������ ������ ����������';

