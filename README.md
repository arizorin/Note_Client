# Note_Client
Задание для комплекса лабораторных работ по ТРПО, 2 семестр Цель работы: Разработать комплекс приложений для демонстрации клиент-серверного взаимодействия и принципов устройства приложений. Выбор данных для которых реализуется приложение остается за вами. В качестве предложения - “заметки”, которые содержат заголовок, текст и геометку. Возможно использование той же модели данных, что и в курсовом проекте. Возможна работа в группах до 3-х человек. 
2. Мобильное приложение: ○ Дает возможность пользователь войти в систему. Полученный от сервера токен запоминается и при повторных запусках приложения, логин и пароль не запрашиваются. В случае, если токен стал невалидным (сервер отвечает ошибкой авторизации) - например, если пользователя удалили, логин и пароль запрашиваются снова ○ Имеет выезжающее главное меню (drawer) на основных страницы ○ Показывает список записей ○ Обеспечивает master/detail flow в обычном и планшетном режимах ■ На обычных телефонах: происходит переход полноэкранное отображение деталей записи ■ На планшетах экран разбивается на две части: слева список записей, справа - детали одной записи ○ Дает возможность редактирования в деталях записи ○ Валидация данных от пользователя, корректная обработка сетевых ошибок и отображение loader’ов в процессе загрузки данных с сервера ○ Показывает записи на карте, если это применимо к модели данных
