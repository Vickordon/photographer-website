# Фотограф - Сайт

Професійний сайт для фотографа на **Elixir** + **Phoenix Framework**.

## Можливості

- 📸 Головна сторінка з презентацією послуг
- 🖼️ Портфоліо з галереєю робіт
- 👤 Про мене - інформація про фотографа  
- 📧 Контакти з формою зворотного зв'язку
- 🔐 Адмін-панель для управління фото

## Технології

- **Backend**: Elixir, Phoenix Framework
- **Database**: PostgreSQL
- **Frontend**: HTML5, CSS3, JavaScript

## Встановлення

```bash
git clone https://github.com/Vickordon/photographer-website.git
cd photographer-website
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
```

Сайт: http://localhost:4000

## Структура

- `/` - Головна
- `/portfolio` - Портфоліо
- `/about` - Про мене
- `/contact` - Контакти
- `/admin` - Адмін-панель
