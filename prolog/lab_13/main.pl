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
  has_phone("Petrov", "111", address_struct("Moscow", "Lenina", 1, 1)).
  has_phone("Ivanov", "222", address_struct("Vladimir", "Lomonosova", 2, 2)).
  has_phone("Fedorov", "333", address_struct("Tver", "Gagarina", 3, 3)).
  
  has_deposite("Petrov", "Alpha", 0, 1000).
  has_deposite("Ivanov", "Beta", 1, 2000).
  has_deposite("Fedorov", "Gamma", 2, 1500).
  
  own("Petrov", building(1000, address_struct("Moscow", "Lenina", 1, 1))).
  own("Petrov", water_transport(300, "Aqua", "purple")).
  
  own("Ivanov", land(2000, 40)).
  own("Ivanov", car(300, "BMW", "black")).
  
  own("Fedorov", building(2000, address_struct("Tver", "Gagarina", 3, 3))).
  own("Fedorov", land(500, 25)).
  own("Fedorov", water_transport(200, "Aqua", "white")).
  own("Fedorov", car(1500, "Audi", "white")).

  person_property(Surname, building) :- own(Surname, building(_, _)).
  person_property(Surname, land) :- own(Surname, land(_, _)).
  person_property(Surname, water_transport) :- own(Surname, water_transport(_, _, _)).
  person_property(Surname, car) :- own(Surname, car(_, _, _)).
  
  person_property_and_cost(Surname, building, Cost) :- own(Surname, building(Cost, _)).
  person_property_and_cost(Surname, land, Cost) :- own(Surname, land(Cost, _)).
  person_property_and_cost(Surname, water_transport, Cost) :- own(Surname, water_transport(Cost, _, _)).
  person_property_and_cost(Surname, car, Cost) :- own(Surname, car(Cost, _, _)).
  
  if_has_property(Surname, building, Cost) :- own(Surname, building(Cost, _)), !.
  if_has_property(Surname, land, Cost) :- own(Surname, land(Cost, _)), !.
  if_has_property(Surname, water_transport, Cost) :- own(Surname, water_transport(Cost, _, _)), !.
  if_has_property(Surname, car, Cost) :- own(Surname, car(Cost, _, _)), !.
  if_has_property(_, _, 0).
  
  sum(Surname, Total_sum) :- if_has_property(Surname, building, Building_cost), 
                             if_has_property(Surname, land, Land_cost),
                             if_has_property(Surname, water_transport, Water_transport_cost),
                             if_has_property(Surname, car, Car_cost),
                             Total_sum = Building_cost + Land_cost + Water_transport_cost + Car_cost.

goal
  %person_property("Petrov", Object).
  %persin_property_and_cost("Petrov", Object, Cost).
  %sum("Petrov", Total_sum).
  person_property_and_cost("Ivanov", Object, Cost).