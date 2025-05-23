﻿/////////////////////////////////////////////////////////////////////////////////////////////////////
// Вспомогательные процедуры и функции
&НаСервере
Процедура ЗаполнитьВажностьИСтатус()
	// Заполнение ЭУ Важность
	Важность.Добавить("Ошибка", Строка(УровеньЖурналаРегистрации.Ошибка));
	Важность.Добавить("Предупреждение", Строка(УровеньЖурналаРегистрации.Предупреждение));
	Важность.Добавить("Информация", Строка(УровеньЖурналаРегистрации.Информация));
	Важность.Добавить("Примечание", Строка(УровеньЖурналаРегистрации.Примечание));
	
	// Заполнение ЭУ СтатусТранзакции
	СтатусТранзакции.Добавить("НетТранзакции", Строка(СтатусТранзакцииЗаписиЖурналаРегистрации.НетТранзакции));
	СтатусТранзакции.Добавить("Зафиксирована", Строка(СтатусТранзакцииЗаписиЖурналаРегистрации.Зафиксирована));
	СтатусТранзакции.Добавить("НеЗавершена", Строка(СтатусТранзакцииЗаписиЖурналаРегистрации.НеЗавершена));
	СтатусТранзакции.Добавить("Отменена", Строка(СтатусТранзакцииЗаписиЖурналаРегистрации.Отменена));
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьОтборЖурналаРегистрации()
	ОтборЖурналаРегистрации.Очистить();
	// Дата начала, окончания
	Если ДатаНачала <> '00010101000000' Тогда 
		ОтборЖурналаРегистрации.Вставить("ДатаНачала", ДатаНачала);
	КонецЕсли;
	Если ДатаОкончания <> '00010101000000' Тогда
		ОтборЖурналаРегистрации.Вставить("ДатаОкончания", ДатаОкончания);
	КонецЕсли;
	// Пользователь/User
	Если Пользователи.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("Пользователь", Пользователи);
	КонецЕсли;
	// Событие/Event
	Если События.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("Событие", События);
	КонецЕсли;
	// Компьютер/Computer
	Если Компьютеры.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("Компьютер", Компьютеры);
	КонецЕсли;
	// ИмяПриложения/ApplicationName
	Если Приложения.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("ИмяПриложения", Приложения);
	КонецЕсли;
	// Комментарий/Comment
	Если НЕ ПустаяСтрока(Комментарий) Тогда 
		ОтборЖурналаРегистрации.Вставить("Комментарий", Комментарий);
	КонецЕсли;
	// Метаданные/Metadata
	Если Метаданные.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("Метаданные", Метаданные);
	КонецЕсли;
	// Данные/Data 
	Если (Данные <> Неопределено) И (НЕ Данные.Пустая()) Тогда
		ОтборЖурналаРегистрации.Вставить("Данные", Данные);
	КонецЕсли;
	// ПредставлениеДанных/DataPresentation
	Если НЕ ПустаяСтрока(ПредставлениеДанных) Тогда 
		ОтборЖурналаРегистрации.Вставить("ПредставлениеДанных", ПредставлениеДанных);
	КонецЕсли;
	// Транзакция/TransactionID
	Если НЕ ПустаяСтрока(Транзакция) Тогда 
		ОтборЖурналаРегистрации.Вставить("Транзакция", Транзакция);
	КонецЕсли;
	// РабочийСервер/ServerName
	Если РабочиеСерверы.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("РабочийСервер", РабочиеСерверы);
	КонецЕсли;
	// Соединение/Connection
	Если Соединения.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("Соединение", Соединения);
	КонецЕсли;
	// ОсновнойIPПорт/Port
	Если ОсновныеIPПорты.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("ОсновнойIPПорт", ОсновныеIPПорты);
	КонецЕсли;
	// ВспомогательныйIPПорт/SyncPort
	Если ВспомогательныеIPПорты.Количество() > 0 Тогда 
		ОтборЖурналаРегистрации.Вставить("ВспомогательныйIPПорт", ВспомогательныеIPПорты);
	КонецЕсли;
	// Уровень/Level
	СписокУровней = Новый СписокЗначений;
	Для каждого ЭлементСпискаЗначений Из Важность Цикл
		Если ЭлементСпискаЗначений.Пометка Тогда 
			СписокУровней.Добавить(ЭлементСпискаЗначений.Значение, ЭлементСпискаЗначений.Представление);
		КонецЕсли;
	КонецЦикла;
	Если СписокУровней.Количество() > 0 И СписокУровней.Количество() <> Важность.Количество() Тогда
		ОтборЖурналаРегистрации.Вставить("Уровень", СписокУровней);
	КонецЕсли;
	// СтатусТранзакции/TransactionStatus
	СписокСтатусов = Новый СписокЗначений;
	Для каждого ЭлементСпискаЗначений Из СтатусТранзакции Цикл
		Если ЭлементСпискаЗначений.Пометка Тогда 
			СписокСтатусов.Добавить(ЭлементСпискаЗначений.Значение, ЭлементСпискаЗначений.Представление);
		КонецЕсли;
	КонецЦикла;
	Если СписокСтатусов.Количество() > 0 И СписокСтатусов.Количество() <> СтатусТранзакции.Количество() Тогда
		ОтборЖурналаРегистрации.Вставить("СтатусТранзакции", СписокСтатусов);
	КонецЕсли;
	
	Возврат ОтборЖурналаРегистрации;
КонецФункции

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Обработчики событий
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Отбор <> Неопределено Тогда
		ОтборЖурналаРегистрации = Параметры.Отбор;
	КонецЕсли;
	
	ЗаполнитьВажностьИСтатус();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// ДатаНачала/StartDate
	ЗначениеСвойства = Неопределено;
	Если ОтборЖурналаРегистрации.Свойство("ДатаНачала", ЗначениеСвойства) Тогда
		ДатаНачала = ЗначениеСвойства;
	КонецЕсли;
	// ДатаОкончания/EndDate
	Если ОтборЖурналаРегистрации.Свойство("ДатаОкончания", ЗначениеСвойства) Тогда
		ДатаОкончания = ЗначениеСвойства;
	КонецЕсли;
	// Пользователь/User
	Если ОтборЖурналаРегистрации.Свойство("Пользователь", ЗначениеСвойства) Тогда
		Пользователи = ЗначениеСвойства;
	КонецЕсли;
	// Событие/Event
	Если ОтборЖурналаРегистрации.Свойство("Событие", ЗначениеСвойства) Тогда
		События = ЗначениеСвойства;
	КонецЕсли;
	// Компьютер/Computer
	Если ОтборЖурналаРегистрации.Свойство("Компьютер", ЗначениеСвойства) Тогда
		Компьютеры = ЗначениеСвойства;
	КонецЕсли;
	// ИмяПриложения/ApplicationName
	Если ОтборЖурналаРегистрации.Свойство("ИмяПриложения", ЗначениеСвойства) Тогда
		Приложения = ЗначениеСвойства;
	КонецЕсли;
	// Комментарий/Comment
	Если ОтборЖурналаРегистрации.Свойство("Комментарий", ЗначениеСвойства) Тогда
		Комментарий = ЗначениеСвойства;
	КонецЕсли;
	// Метаданные/Metadata
	Если ОтборЖурналаРегистрации.Свойство("Метаданные", ЗначениеСвойства) Тогда
		Метаданные = ЗначениеСвойства;
	КонецЕсли;
	// Данные/Data 
	Если ОтборЖурналаРегистрации.Свойство("Данные", ЗначениеСвойства) Тогда
		Данные = ЗначениеСвойства;
	КонецЕсли;
	// ПредставлениеДанных/DataPresentation
	Если ОтборЖурналаРегистрации.Свойство("ПредставлениеДанных", ЗначениеСвойства) Тогда
		ПредставлениеДанных = ЗначениеСвойства;
	КонецЕсли;
	// Транзакция/TransactionID
	Если ОтборЖурналаРегистрации.Свойство("Транзакция", ЗначениеСвойства) Тогда
		Транзакция = ЗначениеСвойства;
	КонецЕсли;
	// РабочийСервер/ServerName
	Если ОтборЖурналаРегистрации.Свойство("РабочийСервер", ЗначениеСвойства) Тогда
		РабочиеСерверы = ЗначениеСвойства;
	КонецЕсли;
	// Соединение/Connection
	Если ОтборЖурналаРегистрации.Свойство("Соединение", ЗначениеСвойства) Тогда
		Соединения = ЗначениеСвойства;
	КонецЕсли;
	// ОсновнойIPПорт/Port
	Если ОтборЖурналаРегистрации.Свойство("ОсновнойIPПорт", ЗначениеСвойства) Тогда
		ОсновныеIPПорты = ЗначениеСвойства;
	КонецЕсли;
	// ВспомогательныйIPПорт/SyncPort
	Если ОтборЖурналаРегистрации.Свойство("ВспомогательныйIPПорт", ЗначениеСвойства) Тогда
		ВспомогательныеIPПорты = ЗначениеСвойства;
	КонецЕсли;
	// Уровень/Level
	Если ОтборЖурналаРегистрации.Свойство("Уровень", ЗначениеСвойства) Тогда
		Для каждого ЭлементСпискаЗначений Из Важность Цикл
			Если ЗначениеСвойства.НайтиПоЗначению(ЭлементСпискаЗначений.Значение) <> Неопределено Тогда
				ЭлементСпискаЗначений.Пометка = Истина;
			КонецЕсли;
		КонецЦикла;
	Иначе
		Для каждого ЭлементСпискаЗначений Из Важность Цикл
			ЭлементСпискаЗначений.Пометка = Истина;
		КонецЦикла;
	КонецЕсли;
	// СтатусТранзакции/TransactionStatus
	Если ОтборЖурналаРегистрации.Свойство("СтатусТранзакции", ЗначениеСвойства) Тогда
		Для каждого ЭлементСпискаЗначений Из СтатусТранзакции Цикл
			Если ЗначениеСвойства.НайтиПоЗначению(ЭлементСпискаЗначений.Значение) <> Неопределено Тогда
				ЭлементСпискаЗначений.Пометка = Истина;
			КонецЕсли;
		КонецЦикла;
	Иначе
		Для каждого ЭлементСпискаЗначений Из СтатусТранзакции Цикл
			ЭлементСпискаЗначений.Пометка = Истина;
		КонецЦикла;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	ПолучитьОтборЖурналаРегистрации();
КонецПроцедуры

&НаКлиенте
Процедура ВажностьУстановитьВсе()
	Важность.ЗаполнитьПометки(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ВажностьСнятьВсе()
	Важность.ЗаполнитьПометки(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура СтатусТранзакцииУстановитьВсе()
	СтатусТранзакции.ЗаполнитьПометки(Истина);
КонецПроцедуры

&НаКлиенте
Процедура СтатусТранзакцииСнятьВсе()
	СтатусТранзакции.ЗаполнитьПометки(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ИсполнениеВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Если Элемент = Элементы.Пользователи Тогда
		РедактируемыйСписок = Пользователи;
		ОтбираемыеПараметры = "Пользователь";
	ИначеЕсли Элемент = Элементы.События Тогда
		РедактируемыйСписок = События;
		ОтбираемыеПараметры = "Событие";
	ИначеЕсли Элемент = Элементы.Компьютеры Тогда
		РедактируемыйСписок = Компьютеры;
		ОтбираемыеПараметры = "Компьютер";
	ИначеЕсли Элемент = Элементы.Приложения Тогда
		РедактируемыйСписок = Приложения;
		ОтбираемыеПараметры = "ИмяПриложения";
	ИначеЕсли Элемент = Элементы.Метаданные Тогда
		РедактируемыйСписок = Метаданные;
		ОтбираемыеПараметры = "Метаданные";
	ИначеЕсли Элемент = Элементы.РабочиеСерверы Тогда
		РедактируемыйСписок = РабочиеСерверы;
		ОтбираемыеПараметры = "РабочийСервер";
	ИначеЕсли Элемент = Элементы.ОсновныеIPПорты Тогда
		РедактируемыйСписок = ОсновныеIPПорты;
		ОтбираемыеПараметры = "ОсновнойIPПорт";
	ИначеЕсли Элемент = Элементы.ВспомогательныеIPПорты Тогда
		РедактируемыйСписок = ВспомогательныеIPПорты;
		ОтбираемыеПараметры = "ВспомогательныйIPПорт";
	Иначе
		СтандартнаяОбработка = Истина;
		Возврат;
	КонецЕсли;
	
	// Открытие редактора свойства
	ФормаРедактора = ПолучитьФорму("Обработка.ЖурналРегистрации.Форма.РедакторСоставаСвойства");
	ФормаРедактора.УстановитьПараметрыРедактора(РедактируемыйСписок, ОтбираемыеПараметры);
	ПараметрыЗавершения = Новый Структура(
		"Элемент, ФормаРедактора",
		Элемент, ФормаРедактора);
	ФормаРедактора.ОписаниеОповещенияОЗакрытии =
		Новый ОписаниеОповещения("ИсполнениеВыбораЗавершение", ЭтотОбъект, ПараметрыЗавершения);
	ФормаРедактора.Открыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполнениеВыбораЗавершение(КодВозврата, ПараметрыЗавершения) Экспорт
	Элемент = ПараметрыЗавершения.Элемент;
	Если КодВозврата = КодВозвратаДиалога.ОК Тогда
		ОтредактированныйСписок = Новый СписокЗначений;
		ПараметрыЗавершения.ФормаРедактора.ПолучитьОтредактированныйСписок(ОтредактированныйСписок);
		РедактируемыйСписок = ОтредактированныйСписок;
		Если Элемент = Элементы.Пользователи Тогда
			Пользователи = РедактируемыйСписок;
		ИначеЕсли Элемент = Элементы.События Тогда
			События = РедактируемыйСписок;
		ИначеЕсли Элемент = Элементы.Компьютеры Тогда
			Компьютеры = РедактируемыйСписок;
		ИначеЕсли Элемент = Элементы.Приложения Тогда
			Приложения = РедактируемыйСписок;
		ИначеЕсли Элемент = Элементы.Метаданные Тогда
			Метаданные = РедактируемыйСписок;
		ИначеЕсли Элемент = Элементы.РабочиеСерверы Тогда
			РабочиеСерверы = РедактируемыйСписок;
		ИначеЕсли Элемент = Элементы.ОсновныеIPПорты Тогда
			ОсновныеIPПорты = РедактируемыйСписок;
		ИначеЕсли Элемент = Элементы.ВспомогательныеIPПорты Тогда
			ВспомогательныеIPПорты = РедактируемыйСписок;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	Закрыть(ОтборЖурналаРегистрации);
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры
