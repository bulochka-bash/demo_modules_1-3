DECLARE @json NVARCHAR(MAX)
-- если ошибка кодировки то использовать кодировку 1251
-- если ошибка кодировки .json файла использовать кодировку UTF-16LE
SELECT @json = BulkColumn
FROM OPENROWSET(BULK 'C:\Users\aydar\Desktop\Задание демо\Модуль 2\Прил_2_ОЗ_КОД 09.02.07-5-2026-М2\Заказчики.json', SINGLE_NCLOB) as j

-- Парсинг и вставка данных
INSERT INTO Заказчики_import
SELECT 
    id,
    name,
    inn,
    addres,
    phone,
    salesman,
    buyer
FROM OPENJSON(@json)
WITH (
    id INT '$.id',
    name NVARCHAR(100) '$.name',
    inn NVARCHAR(100) '$.inn',
    addres NVARCHAR(100) '$.addres',
    phone NVARCHAR(100) '$.phone',
    salesman BIT '$.salesman',
    buyer BIT '$.buyer'
)