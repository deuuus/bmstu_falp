<font size = 1>

|Шаг | Сравниваемые термы: результат, подстановка | Дальнейшие действия|
|:------: | :------: |:----------:|
|1|person_property_and_cost(ivanov, Object, Cost),</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1)).</br>Унификация неуспешна.|Прямой ход. Переход к следующему предложению.|
|2-18|...|...|
|19|person_property_and_cost(ivanov, Object, Cost),</br>person_property_and_cost(Surname, building, Cost).</br>Унификация успешна. Подстановка: {Object = building}.|Прямой ход. Конкретизация Object = building.</br>Переход к терму правила. </br>Унификация: own(ivanov, building(Cost, _)).|
|20|own(ivanov, building(Cost, _)),</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1)).</br>Унификация неуспешна.|Прямой ход. Переход к следующему предложению.|
|21-46|...|...|
|47|own(ivanov, building(Cost, _)),</br>sum(Surname, Total_sum).</br>Унификация неуспешна.|Достижение конца БЗ. Обратный ход.</br>Реконкретизация Object.</br>Переход к следующему предложению</br>относительно шага 19.|
|48|person_property_and_cost(ivanov, Object, Cost),</br>person_property_and_cost(Surname, land, Cost).</br>Унификация успешна.</br>Подстановка: {Object = land}.|Прямой ход. Конкретизация Object = land.</br>Переход к терму правила. </br>Унификация: own(ivanov, land(Cost, _)).|
|49|own(ivanov, land(Cost, _)),</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1)).</br>Унификация неуспешна.|Прямой ход. Переход к следующему предложению.|
|50-56|...|...|
|57|own(ivanov, land(Cost, _)),</br>own(ivanov, land(2000, 40)).</br>Унификация успешна.</br>Подстановка: {Object = land, Cost = 2000}.|Конкретизация Cost.</br>Сохранение подстановки.</br>Реконкретизация Cost.</br>Прямой ход. Переход к следующему предложению.|
|58|own(ivanov, land(Cost, _)),</br>own(ivanov, car(300, bmw, black)).</br>Унификация неуспешна.|</br>Прямой ход. Переход к следующему предложению.|
|59-75|...|...|
|76|own(ivanov, land(Cost, _)),</br>sum(Surname, Total_sum).</br>Унификация неуспешна.|Достижение конца БЗ. Обратный ход.</br>Реконкретизация Object.</br>Переход к следующему предложению относительно шага 48.|
|77|person_property_and_cost(ivanov, Object, Cost),</br>person_property_and_cost(Surname, water_transport, Cost).</br>Унификация успешна.</br>Подстановка: {Object = water_transport}.|Прямой ход. Конкретизация Object = water_transport.</br>Переход к терму правила. </br>Унификация: own(ivanov, water_transport(Cost, _, _)).|
|78|own(ivanov, water_transport(Cost, _, _)),</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1)).</br>Унификация неуспешна.|Прямой ход. Переход к следующему предложению.|
|79-1055|...|...|
|106|own(ivanov, water_transport(Cost, _, _)),</br>sum(Surname, Total_sum).</br>Унификация неуспешна.|Достижение конца БЗ. Обратный ход.</br>Реконкретизация Object.</br>Переход к следующему предложению</br>относительно шага 77.|
|107|person_property_and_cost(ivanov, Object, Cost),</br>person_property_and_cost(Surname, car, Cost).</br>Унификация успешна.</br>Подстановка: {Object = car}.|Прямой ход. Конкретизация Object = car.</br>Переход к терму правила. </br>Унификация: own(ivanov, car(Cost, _, _)).|
|108|own(ivanov, car(Cost, _, _)),</br>has_phone(petrov, "111", address_struct(moscow, lenina, 1, 1)).</br>Унификация неуспешна.|Прямой ход. Переход к следующему предложению.|
|109-116|...|...|
|117|own(ivanov, car(Cost, _, _)),</br>own(ivanov, car(300, bmw, black)).</br>Унификация успешна.</br>Подстановка: {Object = car, Cost = 300}.|Конкретизация Cost.</br>Сохранение подстановки.</br>Реконкретизация Cost.</br>Прямой ход. Переход к следующему предложению.| 
|118|own(ivanov, car(Cost, _, _)),</br>own(fedorov, building(2000, address_struct(tver, gagarina, 3, 3))).</br>Унификация неуспешна.|Прямой ход. Переход к следующему предложению.|
|119-134|...|...|
|135|own(ivanov, car(Cost, _, _)),</br>sum(Surname, Total_sum).</br>Унификация неуспешна.|Достижение конца БЗ. Обратный ход.</br>Реконкретизация Object.</br>Переход к следующему предложению</br>относительно шага 107.|
|136|person_property_and_cost(ivanov, Object, Cost),</br>if_has_property(Surname, building, Cost).</br>Унификация неуспешна.|</br>Прямой ход. Переход к следующему предложению.|
|137-140|...|...|
|141|person_property_and_cost(ivanov, Object, Cost),</br>sum(Surname, Total_sum).</br>Унификация неуспешна.|Достижение конца БЗ.</br>Завершение работы.