﻿Процедура ПроверитьУстановитьВерсиюПриложения() Экспорт
	
	Версия = Константы.ВерсияПриложения.Получить();
	ВерсияПриложения = Метаданные.Версия;
	Если Версия <> ВерсияПриложения Тогда
		Если Версия <> "1.0.13.1" и НЕ Константы.СериалыПреобразованы.Получить() Тогда
			ВыполнитьОбновлениеДоВерсии_1_0_13_1();			
		КонецЕсли;
		Константы.ВерсияПриложения.Установить(ВерсияПриложения);
	КонецЕсли;	
	
КонецПроцедуры	  

Процедура ВыполнитьОбновлениеДоВерсии_1_0_13_1()
	
	Запрос = Новый запрос("ВЫБРАТЬ
	|	Кино.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.Кино КАК Кино
	|ГДЕ
	|	Кино.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКино.Сериал)");
	Таб = Запрос.Выполнить().Выгрузить();
	Для каждого стр из Таб Цикл
		Об = стр.Ссылка.ПолучитьОбъект();
		Для каждого стрОб Из Об.Серии Цикл
			Попытка
				стрОб.Сезон = Число(СокрЛП(стрОб.СезонСтрока));
				стрОб.Серия = Число(СокрЛП(стрОб.СерияСтрока)); 
			Исключение
				Сообщить(Нстр("ru = 'Ошибка обновления сериала';
						|en = 'Series Update Error:'") + Об.Наименование + ". " + ОписаниеОшибки());
			КонецПопытки;
		КонецЦикла;
		Об.Серии.Сортировать("Сезон,Серия");
		Об.записать();
	КонецЦикла;	
	
	Константы.СериалыПреобразованы.Установить(Истина);
	
КонецПроцедуры      

