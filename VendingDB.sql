CREATE DATABASE VendingMachines11
GO

USE VendingMachines11
GO

CREATE TABLE Товар
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Название NVARCHAR(50) NOT NULL,
	Описание NVARCHAR(MAX),
	Цена FLOAT NOT NULL,
	Количество INT NOT NULL,
	Минимальное_количество INT NOT NULL,
	Средние_продажи INT NOT NULL
)

CREATE TABLE Роль
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
)

CREATE TABLE Пользователь
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Фамилия NVARCHAR(MAX) NOT NULL,
	Имя NVARCHAR(MAX) NOT NULL,
	Отчество NVARCHAR(MAX) NOT NULL,
	Электронная_почта NVARCHAR(50) NOT NULL,
	Код_роль INT

	FOREIGN KEY(Код_роль) REFERENCES Роль(Код)
)

CREATE TABLE Статус
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
) 

CREATE TABLE Изготовитель
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
) 

CREATE TABLE Страна_производства
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
) 

CREATE TABLE Календарь
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Дата_изготовления DATE,
	Дата_начала_эксплуатации DATE,
	Дата_последней_проверки DATE,
	Дата_инвентаризации DATE
)

CREATE TABLE Ресурс
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Часы INT NOT NULL
)

CREATE TABLE Тип_аппарата
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
)

CREATE TABLE Межпроверочный_интервал
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Количество_месяцев INT NOT NULL
)

CREATE TABLE Время_обслуживания
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Часы INT NOT NULL
)

CREATE TABLE Сотрудник
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Фамилия NVARCHAR(50),
	Имя NVARCHAR(50),
	Отчество NVARCHAR(50)
)

CREATE TABLE Вендинговый_аппарат
(
	Код UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	Местоположение NVARCHAR(255) NOT NULL,
	Модель NVARCHAR(255) NOT NULL,
	Доход FLOAT NOT NULL,
	Серийный_номер BIGINT NOT NULL UNIQUE,
	Инвентарный_номер BIGINT NOT NULL UNIQUE,
	Код_изготовитель INT,
	Код_календарь INT,
	Код_межпроверочного_интервала INT,
	Код_ресурс INT,
	Код_статус INT,
	Код_тип_аппарата INT,
	Код_страна_производства INT,
	Код_сотрудник UNIQUEIDENTIFIER

	FOREIGN KEY(Код_изготовитель) REFERENCES Изготовитель(Код),
	FOREIGN KEY(Код_календарь) REFERENCES Календарь(Код),
	FOREIGN KEY(Код_межпроверочного_интервала) REFERENCES Межпроверочный_интервал(Код),
	FOREIGN KEY(Код_ресурс) REFERENCES Ресурс(Код),
	FOREIGN KEY(Код_статус) REFERENCES Статус(Код),
	FOREIGN KEY(Код_тип_аппарата) REFERENCES Тип_аппарата(Код),
	FOREIGN KEY(Код_страна_производства) REFERENCES Страна_производства(Код),
	FOREIGN KEY(Код_сотрудник) REFERENCES Сотрудник(Код)
)

CREATE TABLE Тип_оплаты
(
	Код INT PRIMARY KEY IDENTITY(1,1),
	Название NVARCHAR(50) NOT NULL
)

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

CREATE TABLE Обслуживание
(
	Код INT IDENTITY(1,1),
	Код_вендинговый_аппарат UNIQUEIDENTIFIER,
	Дата_обслуживания DATE NOT NULL,
	Описание_работы NVARCHAR(MAX) NOT NULL

	FOREIGN KEY(Код_вендинговый_аппарат) REFERENCES Вендинговый_аппарат(Код)
)
