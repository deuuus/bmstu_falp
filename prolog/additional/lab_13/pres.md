<font size = 1>

При выполнении программы на Prolog используются следующие стеки:
* Стек резольвенты.
* Стек меток.
* Стек унификации.
* Стек переменных.
* "Мусорный стек". 

Рассмотрим пример программы на Prolog:

```
domains
    surname, phone = symbol.
    city, street = symbol.
    house, flat = integer.
    address = address_struct(city, street, house, flat)
    mark, color = symbol.
    cost = integer.
    bank = symbol.
    account, sum = integer.
    
    area = integer.
    
    property = building(cost, address); 
    land(cost, area); 
    water_transport(cost, mark, color); 
    car(cost, mark, color).

predicates
    has_phone(surname, phone, address).
    has_deposite(surname, bank, account, sum).
    
    own(surname, property).
    
    person_property(surname, symbol).
    person_property_and_cost(surname, symbol, cost).
    
    sum(surname, cost).
    if_has_property(surname, symbol, cost).

clauses
    (1) has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1)).
    (2) has_phone(ivanov, "222", address_struct(vladimir, lomonosova, 2, 2)).
    (3) has_phone(fedorov, "333", address_struct(tver, gagarina, 3, 3)).
    
    (4) has_deposite(petrov, alpha, 0, 1000).
    (5) has_deposite(ivanov, beta, 1, 2000).
    (6) has_deposite(fedorov, gamma, 2, 1500).
    
    (7) own(petrov, building(1000, address_struct(moscow, lenina, 1, 1))).
    (8) own(petrov, water_transport(300, aqua, purple)).
    
    (9) own(ivanov, land(2000, 40)).
    (10) own(ivanov, car(300, bmw, black)).
    
    (11) own(fedorov, building(2000, address_struct(tver, gagarina, 3, 3))).
    (12) own(fedorov, land(500, 25)).
    (13) own(fedorov, water_transport(200, aqua, white)).
    (14) own(fedorov, car(1500, audi, white)).
    
    (15) person_property(Surname, building) :- own(Surname, building(_, _)).
    (16) person_property(Surname, land) :- own(Surname, land(_, _)).
    (17) person_property(Surname, water_transport) :- own(Surname, water_transport(_, _, _)).
    (18) person_property(Surname, car) :- own(Surname, car(_, _, _)).
		
    (19) person_property_and_cost(Surname, building, Cost) :- own(Surname, building(Cost, _)).
    (20) person_property_and_cost(Surname, land, Cost) :- own(Surname, land(Cost, _)).
    (21) person_property_and_cost(Surname, water_transport, Cost) :- own(Surname, water_transport(Cost, _, _)).
    (22) person_property_and_cost(Surname, car, Cost) :- own(Surname, car(Cost, _, _)).
    
    (23) if_has_property(Surname, building, Cost) :- own(Surname, building(Cost, _)), !.
    (24) if_has_property(Surname, land, Cost) :- own(Surname, land(Cost, _)), !.
    (25) if_has_property(Surname, water_transport, Cost) :- own(Surname, water_transport(Cost, _, _)), !.
    (26) if_has_property(Surname, car, Cost) :- own(Surname, car(Cost, _, _)), !.
    (27) if_has_property(_, _, 0).
    
    (28) sum(Surname, Total_sum) :- if_has_property(Surname, building, Building_cost), 
                if_has_property(Surname, land, Land_cost),
                if_has_property(Surname, water_transport, Water_transport_cost),
                if_has_property(Surname, car, Car_cost),
                Total_sum = Building_cost + Land_cost + Water_transport_cost + Car_cost.

goal
    person_property_and_cost(A, B, C).
```

</br>

|№ шага|Стек резольвенты|Стек меток|Стек унификации|Стек переменных|"Мусорный" стек|Дальнейшие действия|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|1|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|(1)|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)</br>=</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1))|$\color {green} A$, $\color {red} B$, $\color {blue} C$||Унификация неуспешна.</br>Переход к следующему предложению.|
|2-18|...|...|...|...|...|...|
|19|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|(19)|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)</br>=</br>person_property_and_cost($\color {green}Surname$, $\color {red}building$, $\color {blue}Cost$)|$\color {green} A = Surname$, $\color {red} B = building$, $\color {blue} C = Cost$||Унификация успешна. </br>Редукция резольвенты.|
|20|own($\color {green}A$, building($\color {blue}C$, _))|(1)</br>(19)|own($\color {green}A$, building($\color {blue}C$, _))</br>=</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1))|$\color {green} A = Surname$, $\color {red} B = building$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|21-25|...|...|...|...|...|...|
|26|own($\color {green}A$, building($\color {blue}C$, _))|(7)</br>(19)|own($\color {green}A$, building($\color {blue}C$, _))</br>=</br>own($\color {green}petrov$, building($\color {blue}1000$, address_struct(moscow, lenina, 1, 1)))|$\color {green} A = petrov$, $\color {red} B = building$, $\color {blue} C = 1000$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой,  </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|27|own($\color {green}A$, building($\color {blue}C$, _))|(8)</br>(19)|own($\color {green}A$, building($\color {blue}C$, _))</br>=</br>own($\color {green}petrov$, water_transport($\color {blue}300$, aqua, purple))|$\color {green} A = Surname$, $\color {red} B = building$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|28-29|...|...|...|...|...|...|
|30|own($\color {green}A$, building($\color {blue}C$, _))|(11)</br>(19)|own($\color {green}A$, building($\color {blue}C$, _))</br>=</br>own($\color {green}fedorov$, building($\color {blue}2000$, address_struct(tver, gagarina, 3, 3)))|$\color {green} A = fedorov$, $\color {red} B = building$, $\color {blue} C = 2000$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой, </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|31|own($\color {green}A$, building($\color {blue}C$, _))|(12)</br>(19)|own($\color {green}A$, building($\color {blue}C$, _))</br>=</br>own($\color {green}fedorov$, land($\color {blue}500$, 25))|$\color {green} A = Surname$, $\color {red} B = building$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|32-47|...|...|...|...|...|...|
|48|own($\color {green}A$, building($\color {blue}C$, _))|(28)</br>(19)|own($\color {green}A$, building($\color {blue}C$, _))</br>=</br>sum(Surname, Total_sum)|$\color {green} A = Surname$, $\color {red} B = building$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна. </br>Метка достигла конца БЗ. </br> Откат к предыдущему состоянию резольвенты,</br>переход к следующему предложению.|
|49|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|(20)|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)</br>=</br>person_property_and_cost($\color {green}Surname$, $\color {red}land$, $\color {blue}Cost$)|$\color {green} A = Surname$, $\color {red} B = land$, $\color {blue} C = Cost$||Унификация успешна.</br>Редукция резольвенты.|
|50|own($\color {green}A$, land($\color {blue}C$, _))|(1)</br>(20)|own($\color {green}A$, land($\color {blue}C$, _))</br>=</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1))|$\color {green} A = Surname$, $\color {red} B = land$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|51-57|...|...|...|...|...|...|
|58|own($\color {green}A$, land($\color {blue}C$, _))|(10)</br>(20)|own($\color {green}A$, land($\color {blue}C$, _))</br>=</br>own($\color {green}ivanov$, car($\color {blue}300$, bmw, black))|$\color {green} A = ivanov$, $\color {red} B = land$, $\color {blue} C = 300$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой, </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|59|own($\color {green}A$, land($\color {blue}C$, _))|(11)</br>(20)|own($\color {green}A$, land($\color {blue}C$, _))</br>=</br>own(fedorov, building(2000, address_struct(tver, gagarina, 3, 3)))|$\color {green} A = Surname$, $\color {red} B = land$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|60|own($\color {green}A$, land($\color {blue}C$, _))|(12)</br>(20)|own($\color {green}A$, land($\color {blue}C$, _))</br>=</br>own($\color {green}fedorov$, land($\color {blue}500$, 25))|$\color {green} A = fedorov$, $\color {red} B = land$, $\color {blue} C = 500$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой, </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|61|own($\color {green}A$, land($\color {blue}C$, _))|(13)</br>(20)|own($\color {green}A$, land($\color {blue}C$, _))</br>=</br>own(fedorov, water_transport(200, aqua, white))|$\color {green} A = Surname$, $\color {red} B = land$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|62-75|...|...|...|...|...|...|
|76|own($\color {green}A$, land($\color {blue}C$, _))|(28)</br>(20)|own($\color {green}A$, land($\color {blue}C$, _))</br>=</br>sum(Surname, Total_sum)|$\color {green} A = Surname$, $\color {red} B = land$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна. </br>Метка достигла конца БЗ. </br> Откат к предыдущему состоянию резольвенты,</br>переход к следующему предложению.|
|77|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|(21)|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)</br>=</br>person_property_and_cost($\color {green}Surname$, water_transport, $\color {blue}Cost$)|$\color {green} A = Surname$, $\color {red} B = water\_transport$, $\color {blue} C = Cost$||Унификация успешна.</br>Редукция резольвенты.|
|78|own($\color {green}A$, water_transport($\color {blue}C$, _, _))|(1)</br>(21)|own($\color {green}A$, water_transport($\color {blue}C$, _, _))</br>=</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1))|$\color {green} A = Surname$, $\color {red} B = water\_transport$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|79-84|...|...|...|...|...|...|
|85|own($\color {green}A$, water_transport($\color {blue}C$, _, _))|(8)</br>(21)|own($\color {green}A$, water_transport($\color {blue}C$, _, _))</br>=</br>own($\color {green}petrov$, water_transport($\color {blue}300$, aqua, purple))|$\color {green} A = petrov$, $\color {red} B = water\_transport$, $\color {blue} C = 300$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой, </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|86|own($\color {green}A$, water_transport($\color {blue}C$, _, _))|(9)</br>(21)|own($\color {green}A$, water_transport($\color {blue}C$, _, _))</br>=</br>own(ivanov, land(2000, 40))|$\color {green} A = Surname$, $\color {red} B = water\_transport$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|87-90|...|...|...|...|...|...|
|91|own($\color {green}A$, water_transport($\color {blue}C$, _, _))|(13)</br>(21)|own($\color {green}A$, water_transport($\color {blue}C$, _, _))</br>=</br>own($\color {green}fedorov$, water_transport($\color {blue}200$, aqua, white))|$\color {green} A = fedorov$, $\color {red} B = water\_transport$, $\color {blue} C = 200$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой, </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|92|own($\color {green}A$, water_transport($\color {blue}C$, _, _))|(14)</br>(21)|own($\color {green}A$, water_transport($\color {blue}C$, _, _))</br>=</br>own(fedorov, car(1500, audi, white))|$\color {green} A = Surname$, $\color {red} B = water\_transport$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|93-105|...|...|...|...|...|...|
|106|own($\color {green}A$, water_transport($\color {blue}C$, _, _))|(28)</br>(21)|own($\color {green}A$, water_transport($\color {blue}C$, _, _))</br>=</br>sum(Surname, Total_sum)|$\color {green} A = Surname$, $\color {red} B = water\_transport$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна. </br>Метка достигла конца БЗ. </br> Откат к предыдущему состоянию резольвенты,</br>переход к следующему предложению.|
|107|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|(22)|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)</br>=</br>person_property_and_cost($\color {green}Surname$, $\color {red}car$, $\color {blue}Cost$)|$\color {green} A = Surname$, $\color {red} B = car$, $\color {blue} C = Cost$||Унификация успешна.</br>Редукция резольвенты.|
|108|own($\color {green}A$, car($\color {blue}C$, _, _))|(1)</br>(22)|own($\color {green}A$, car($\color {blue}C$, _, _))</br>=</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1))|$\color {green} A = Surname$, $\color {red} B = car$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|108-115|...|...|...|...|...|...|
|116|own($\color {green}A$, car($\color {blue}C$, _, _))|(10)</br>(22)|own($\color {green}A$, car($\color {blue}C$, _, _))</br>=</br>own($\color {green}ivanov$, car($\color {blue}300$, bmw, black))|$\color {green} A = ivanov$, $\color {red} B = car$, $\color {blue} C = 300$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой, </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|117|own($\color {green}A$, car($\color {blue}C$, _, _))|(11)</br>(22)|own($\color {green}A$, car($\color {blue}C$, _, _))</br>=</br>own(fedorov, building(2000, address_struct(tver, gagarina, 3, 3)))|$\color {green} A = Surname$, $\color {red} B = car$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|118-119|...|...|...|...|...|...|
|120|own($\color {green}A$, car($\color {blue}C$, _, _))|(14)</br>(22)|own($\color {green}A$, car($\color {blue}C$, _, _))</br>=</br>own($\color {green}fedorov$, car($\color {blue}1500$, audi, white))|$\color {green} A = fedorov$, $\color {red} B = car$, $\color {blue} C = 1500$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация успешна. </br>Резольвента становится пустой, </br>метка не достигла конца БЗ. Вывод ответа. </br>Поиск других решений.|
|121|own($\color {green}A$, car($\color {blue}C$, _, _))|(15)</br>(22)|own($\color {green}A$, car($\color {blue}C$, _, _))</br>=</br>person_property(Surname, building)|$\color {green} A = Surname$, $\color {red} B = car$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна.</br>Переход к следующему предложению.|
|122-133|...|...|...|...|...|...|
|134|own($\color {green}A$, car($\color {blue}C$, _, _))|(15)</br>(22)|own($\color {green}A$, car($\color {blue}C$, _, _))</br>=</br>sum(Surname, Total_sum)|$\color {green} A = Surname$, $\color {red} B = car$, $\color {blue} C = Cost$|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|Унификация неуспешна. </br>Метка достигла конца БЗ. </br> Откат к предыдущему состоянию резольвенты,</br>переход к следующему предложению.|
|135|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|(23)|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)</br>=</br>if_has_property(Surname, building, Cost)|$\color {green}A$, $\color {red} B$, $\color {blue}C$||Унификация неуспешна.</br>Переход к следующему предложению.|
|136-139|...|...|...|...|...|...|
|140|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)|(23)|person_property_and_cost($\color {green}A$, $\color {red}B$, $\color {blue}C$)</br>=</br>sum(Surname, Total_sum)|$\color {green}A$, $\color {red} B$, $\color {blue}C$||Унификация неуспешна.</br>Все метки достигли конца БЗ.</br>Завершение работы.|