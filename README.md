# Фотограф - Сайт

Професійний сайт для фотографа на **Elixir** + **Phoenix Framework**.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Можливості

- 📸 **Головна сторінка** - презентація послуг з hero секцією
- 🖼️ **Портфоліо** - галерея робіт з hover ефектами
- 👤 **Про мене** - інформація про фотографа
- 📧 **Контакти** - форма зворотного зв'язку
- 🔐 **Адмін-панель** - управління фотографіями (завантаження, видалення)

## 🛠 Технології

- **Backend**: Elixir 1.14+, Phoenix Framework 1.7
- **Database**: PostgreSQL 12+
- **Frontend**: HTML5, CSS3, JavaScript
- **Styling**: Custom CSS з адаптивним дизайном
- **LiveView**: Phoenix LiveView для інтерактивності

## 📦 Швидкий старт

### Вимоги

- Elixir 1.14+
- Erlang/OTP 24+
- PostgreSQL 12+
- Node.js 16+ (для asset pipeline)

### Встановлення

1. **Клонуйте репозиторій**
```bash
git clone https://github.com/Vickordon/photographer-website.git
cd photographer-website
```

2. **Встановіть залежності**
```bash
mix deps.get
```

3. **Налаштуйте базу даних**
```bash
mix ecto.create
mix ecto.migrate
```

4. **Встановіть frontend залежності**
```bash
cd assets && npm install && cd ..
```

5. **Зберіть assets**
```bash
mix assets.deploy
```

6. **Запустіть сервер**
```bash
mix phx.server
```

Сайт буде доступний за адресою: **http://localhost:4000**

## 🎨 Структура сайту

| Сторінка | URL | Опис |
|----------|-----|------|
| Головна | `/` | Презентація послуг |
| Портфоліо | `/portfolio` | Галерея робіт |
| Про мене | `/about` | Інформація про фотографа |
| Контакти | `/contact` | Форма зворотного зв'язку |
| Адмін-панель | `/admin` | Управління контентом |

## 📁 Структура проекту

```
photographer-website/
├── config/              # Конфігураційні файли
│   ├── config.exs       # Головна конфігурація
│   ├── dev.exs          # Dev середовище
│   ├── test.exs         # Test середовище
│   ├── prod.exs         # Production середовище
│   └── runtime.exs      # Runtime конфігурація
├── lib/
│   ├── photographer/    # Бізнес-логіка
│   │   ├── application.ex
│   │   └── repo.ex
│   └── photographer_web/ # Веб-інтерфейс
│       ├── controllers/ # Контролери
│       ├── components/  # Компоненти
│       ├── endpoint.ex  # Endpoint
│       └── router.ex    # Роутинг
├── assets/              # Frontend ресурси
│   ├── css/app.css      # Стилі
│   └── js/app.js        # JavaScript
├── priv/                # Статичні файли
└── test/                # Тести
```

## 🔧 Конфігурація

### Розробка

Порт: `4000`  
База даних: `photographer_dev`

### Production

Налаштуйте змінні оточення:

```bash
export DATABASE_URL="postgresql://user:pass@host:5432/dbname"
export SECRET_KEY_BASE="your-secret-key-base"
export PORT="4000"
export POOL_SIZE="10"
```

## 🚀 Deployment

### Docker (рекомендовано)

```bash
docker-compose up --build
```

### Heroku

```bash
heroku create
heroku addons:create heroku-postgresql:hobby-dev
git push heroku main
heroku run mix ecto.migrate
```

## 📝 Ліцензія

MIT License - дивись [LICENSE](LICENSE) файл для деталей.

## 👤 Автор

Розроблено для фотографа з любов'ю до мистецтва 📸

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

**Website**: https://github.com/Vickordon/photographer-website
