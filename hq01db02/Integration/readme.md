# Скрипты по очистке SSISDB

Отчёт стандартный - `Disk Usage by Table`

![Disk Usage by Table](https://user-images.githubusercontent.com/13679318/128154159-9c1034a0-59be-4374-b143-cf7174645beb.png)

Скрипт `cleanup-ssisdb.sql` запускается первым

Скрипты удаляют служебную информацию по выполняемым пакетам

Второй скрипт  `cleanup-ssisdb_new.sql` чистит только самые большие таблицы

![Animation](https://user-images.githubusercontent.com/13679318/128157615-db0b0eb5-f459-46af-8aaa-d748527f3840.gif)

После удаления информации из таблиц делаем `Shrink DB`


[youtube](https://www.youtube.com/embed/Tuwcx9BXx-o)


