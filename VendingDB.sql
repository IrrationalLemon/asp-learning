CREATE DATABASE VendingMachines
GO

USE VendingMachines
GO

CREATE TABLE Товар
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
	Название NVARCHAR(50) NOT NULL,
	Описание NVARCHAR(MAX),
	Цена FLOAT NOT NULL,
	Количество INT NOT NULL,
	Минимальное_количество INT NOT NULL,
	Средние_продажи INT NOT NULL
)

INSERT INTO Товар(Название, Описание, Цена, Количество, Минимальное_количество, Средние_продажи)
VALUES
('Чипсы', 'Чипсы обычные', 80, 20, 10, 15),
('Батончик', 'Батончик обычный', 20, 30, 15, 16),
('Сухарики', 'Сухарики обычные', 80, 20, 10, 15),
('Моти', 'Моти обычные', 50, 20, 10, 15),
('Мармеладки', 'Мармеладки обычные', 60, 30, 20, 10)

CREATE TABLE Роль
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
)

INSERT INTO Роль(Название)
VALUES
('Администратор'),
('Оператор')

CREATE TABLE Пользователь
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
	Фамилия NVARCHAR(MAX) NOT NULL,
	Имя NVARCHAR(MAX) NOT NULL,
	Отчество NVARCHAR(MAX) NOT NULL,
	Электронная_почта NVARCHAR(50) NOT NULL,
	Код_роль INT

	FOREIGN KEY(Код_роль) REFERENCES Роль(Код)
)

INSERT INTO Пользователь(Фамилия, Имя, Отчество, Электронная_почта, Код_роль)
VALUES
('Иван', 'Иванов', 'Иванович', 'ivan96@gmail.com', 1),
('Петр', 'Петров', 'Петрович', 'petrsup@gmail.com', 2),
('Виталий', 'Виталиев', 'Витальевич', 'vityaaa@gmail.com', 2)

CREATE TABLE Статус
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
) 

INSERT INTO Статус(Название)
VALUES
('Работает'),
('Вышел из строя'),
('В ремонте/на обслуживании')

CREATE TABLE Изготовитель
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
) 

INSERT INTO Изготовитель(Название)
VALUES
('АвтоматыПРО'),
('Еда из автоматов'),
('Рога и Копыта')

CREATE TABLE Страна_производства
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
) 

INSERT INTO Страна_производства(Название)
VALUES
('Россия'),
('Китай'),
('Казахстан')

CREATE TABLE Календарь
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Дата_изготовления DATE,
	Дата_начала_эксплуатации DATE,
	Дата_последней_проверки DATE,
	Дата_инвентаризации DATE
)

INSERT INTO Календарь(Дата_изготовления, Дата_начала_эксплуатации, Дата_последней_проверки, Дата_инвентаризации)
VALUES
('2020-10-12', '2020-11-12', '2025-09-15', '2025-10-05'),
('2021-10-12', '2021-11-12', '2025-09-15', '2025-10-05'),
('2022-10-12', '2022-11-12', '2025-09-15', '2025-10-05')

CREATE TABLE Ресурс
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Часы INT NOT NULL
)

INSERT INTO Ресурс(Часы)
VALUES
(10),
(20),
(30)

CREATE TABLE Тип_аппарата
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
)

INSERT INTO Тип_аппарата(Название)
VALUES
('С оплатой картой'),
('С оплатой наличными'),
('С двумя видами оплаты')

CREATE TABLE Межпроверочный_интервал
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Количество_месяцев INT NOT NULL
)

INSERT INTO Межпроверочный_интервал(Количество_месяцев)
VALUES
(3),
(5),
(7)

CREATE TABLE Время_обслуживания
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Часы INT NOT NULL
)

INSERT INTO Время_обслуживания(Часы)
VALUES
(1),
(2),
(3)

CREATE TABLE Сотрудник
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
	Фамилия NVARCHAR(50),
	Имя NVARCHAR(50),
	Отчество NVARCHAR(50)
)

DECLARE @пользователь1 UNIQUEIDENTIFIER, @пользователь2 UNIQUEIDENTIFIER
DECLARE @сотрудник1 UNIQUEIDENTIFIER, @сотрудник2 UNIQUEIDENTIFIER

SELECT TOP 1 @пользователь1 = Код FROM Пользователь WHERE Имя = 'Иван'
SELECT TOP 1 @пользователь2 = Код FROM Пользователь WHERE Имя = 'Петр'
SELECT TOP 1 @сотрудник1 = Код FROM Сотрудник WHERE Имя = 'Иван'
SELECT TOP 1 @сотрудник2 = Код FROM Сотрудник WHERE Имя = 'Петр'

INSERT INTO Сотрудник(Фамилия, Имя, Отчество)
VALUES
('Иван', 'Иванов', 'Иванович'),
('Петр', 'Петров', 'Петрович'),
('Виталий', 'Виталиев', 'Витальевич')

CREATE TABLE Вендинговый_аппарат
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
	Местоположение NVARCHAR(255) NOT NULL,
	Модель NVARCHAR(255) NOT NULL,
	Доход FLOAT NOT NULL,
	Серийный_номер BIGINT NOT NULL UNIQUE,
	Инвентарный_номер BIGINT NOT NULL UNIQUE,
	Код_изготовитель INT,
	Код_календарь INT,
	Код_ресурс INT,
	Код_статус INT,
	Код_тип_аппарата INT,
	Код_страна_производства INT,
	Код_сотрудник UNIQUEIDENTIFIER,
	Код_пользователь UNIQUEIDENTIFIER

	FOREIGN KEY(Код_изготовитель) REFERENCES Изготовитель(Код),
	FOREIGN KEY(Код_календарь) REFERENCES Календарь(Код),
	FOREIGN KEY(Код_ресурс) REFERENCES Ресурс(Код),
	FOREIGN KEY(Код_статус) REFERENCES Статус(Код),
	FOREIGN KEY(Код_тип_аппарата) REFERENCES Тип_аппарата(Код),
	FOREIGN KEY(Код_страна_производства) REFERENCES Страна_производства(Код),
	FOREIGN KEY(Код_сотрудник) REFERENCES Сотрудник(Код),
	FOREIGN KEY(Код_пользователь) REFERENCES Пользователь(Код)
)

INSERT INTO Вендинговый_аппарат(Местоположение, Модель, Доход, Серийный_номер, Инвентарный_номер, Код_изготовитель, Код_календарь, Код_ресурс, Код_статус, Код_тип_аппарата, Код_страна_производства, Код_сотрудник, Код_пользователь)
VALUES
('Офис на Чайковского', 'А316', 30000,  12345678, 87654321, 1, 1, 1, 1, 1, 1, 1, 1),
('Торговый центр Олимп', 'Б322', 40000,  34567890, 09876543, 2, 2, 2, 2, 2, 2, 2, 2)

CREATE TABLE Тип_оплаты
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
)

INSERT INTO Тип_оплаты(Название)
VALUES
('Наличные'),
('Карта')

CREATE TABLE Продажи
(
	Код INT IDENTITY(1,1),
	Код_вендинговый_аппарат UNIQUEIDENTIFIER,
	Код_товар UNIQUEIDENTIFIER,
	Количество INT NOT NULL,
	Сумма_продажи FLOAT NOT NULL,
	Дата_время_продажи DATETIME2(0) NOT NULL,
	Код_тип_оплаты INT
	
	FOREIGN KEY(Код_вендинговый_аппарат) REFERENCES Вендинговый_аппарат(Код),
	FOREIGN KEY(Код_товар) REFERENCES Товар(Код),
	FOREIGN KEY(Код_тип_оплаты) REFERENCES Тип_оплаты(Код)
)

INSERT INTO Продажи(Код_вендинговый_аппарат, Код_товар, Количество, Сумма_продажи, Дата_время_продажи, Код_тип_оплаты)
VALUES
(1, 1, 5, 350, '2025-12-31 15:37:12', 1),
(2, 2, 5, 200, '2025-12-31 14:00:12', 2)

CREATE TABLE Обслуживание
(
	Код INT IDENTITY(1,1),
	Код_вендинговый_аппарат UNIQUEIDENTIFIER,
	Код_время_обслуживания INT,
	Код_межпроверочного_интервала INT,
	Дата_обслуживания DATE NOT NULL,
	Описание_работы NVARCHAR(MAX) NULL

	FOREIGN KEY(Код_вендинговый_аппарат) REFERENCES Вендинговый_аппарат(Код),
	FOREIGN KEY(Код_межпроверочного_интервала) REFERENCES Межпроверочный_интервал(Код),
	FOREIGN KEY(Код_время_обслуживания) REFERENCES Время_обслуживания(Код)
)

INSERT INTO Обслуживание(Код_вендинговый_аппарат, Код_время_обслуживания, Код_межпроверочного_интервала, Дата_обслуживания, Описание_работы)
VALUES
(1, 1, 1, '2025-10-12', 'Очистка от пыли'),
(2, 2, 2, '2025-12-10', 'Ремонт автомата')
