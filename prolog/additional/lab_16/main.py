defines = {'c' : 2, 'h': 1}

arr = ['c', 'f']

# Res - список списков.
# Пытаемся найти соединение для первого элемента. Находим h. Удаляем его из списка, перемещаем в Res. У с связность увеличивается на единицу.
# Пытаемся найти соединение для первого элемента. Находим h. С полностью связан. Перемещаем в Res. 
# Ошибка - когда первый элемент нельзя связать. Нужно найти все возможные соединения.