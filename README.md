скрипт который превращает карту в музыку, с помощью файла .gpx. gpx - xml файл стандартный для записи координат. свой поход я записывал с помощью приложения в google play "высотомер". Вроде как такое есть оч много где

# описание звуков
в файле много переменных с помощью которых можно управлять рандомизированностью сигнала, основные входы и выходы вот:
Характеристики звуковой волны для рандомизации - амплитуда, частота, продолжительность одного паттерна, форма
Данные для рандомизации - широта, долгота, высота, время (время не используется). Потенциально можно также добавить скорость и ускорение как производные
  Полифония из 4 инструментов:
    1 - amp-long, freq-lat, elev-time; sine
    2 - amp-lat, freq-elev, tim-long; square
    3 - amp-elev, freq-long, tim-lat; triangle
    4 - amp-long, freq-long, tim-long; sawtooth
