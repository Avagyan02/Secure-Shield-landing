# CGI Скрипт display.cgi

## 📦 Назначение

Скрипт `display.cgi` предназначен для обработки HTTP GET и POST запросов и работы с JSON-файлом `/usr/share/domofonica/intercom_config.json`.

Скрипт написан на `sh` и работает на Linux-системах, совместимых с OpenWrt, с веб-сервером `httpd` (например, busybox httpd).

---

## 📁 Установка

1. Поместите файл `display.cgi` в директорию CGI:

   ```
   /www/cgi-bin/display.cgi
   ```

2. Сделайте его исполняемым:

   ```
   chmod +x /www/cgi-bin/display.cgi
   ```

3. Убедитесь, что файл `/usr/share/domofonica/intercom_config.json` доступен на запись. Если не существует — создайте:

   ```
   mkdir -p /usr/share/domofonica
   echo '{}' > /usr/share/domofonica/intercom_config.json
   chmod 666 /usr/share/domofonica/intercom_config.json
   ```

---

## 🌐 Запуск HTTP-сервера (если нет uhttpd)

Через busybox:

```
busybox httpd -f -p 8080 -h /www -c /cgi-bin
```

---

## ✅ Примеры запросов

### GET

```
curl http://localhost:8080/cgi-bin/display.cgi
```

**Ответы:**
- Файл отсутствует:
  ```json
  { "status": "error", "message": "File not found" }
  ```

- Объект `display` отсутствует:
  ```json
  { "status": "error", "message": "display not found" }
  ```

- Успешно:
  ```json
  { "status": "ok", "data": { "labels": [...], "localization": {...} } }
  ```

---

### POST

```
curl -X POST http://localhost:8080/cgi-bin/display.cgi \
  -H "Content-Type: application/json" \
  -d '{
    "labels": ["Main", "Info", "Settings"],
    "localization": {
      "ENTER_APARTMENT": "Welcome",
      "CALL": "Dialing",
      "CALL_BUSY": "Busy",
      "CONNECT": "Please wait",
      "OPEN": "Door opened",
      "FAIL_UNKNOWN": "Unknown error",
      "FAIL_BLACK_LIST": "Access denied",
      "ALWAYS_OPEN": "Always open"
    }
  }'
```

**Успешный ответ:**
```json
{ "status": "success", "data": { ... } }
```

---

## ❗ Зависимости

- `jq` должен быть установлен (`apt install jq`)
- `busybox` должен содержать `httpd`
