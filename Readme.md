# Gammu SMSD Container

This repository provides a **ready-to-use Docker container** with [Gammu SMSD](https://wammu.eu/docs/manual/smsd/).
It connects to a GSM modem, receives SMS messages, and forwards them to a configured endpoint (via HTTP POST).
All messages are also persisted in a MySQL/MariaDB database.

---

## Features

- Preconfigured **Gammu SMSD** (no manual config required)
- Connects to a GSM modem (USB device)
- Stores SMS in a **MySQL/MariaDB** database
- Forwards incoming SMS via HTTP POST to a message handler
- Configurable via `.env` only
- Works seamlessly with:
  - [gammu-mysql-db](https://github.com/Gasprinskiy/gammu-mysql-db)
  - [gammu-message-handler](https://github.com/Gasprinskiy/gammu-message-handler)

---

## Prerequisites

- Docker and Docker Compose installed
- A GSM modem attached to the host (e.g., `/dev/ttyUSB0`)
- A running database with the Gammu schema (see [gammu-mysql-db](https://github.com/Gasprinskiy/gammu-mysql-db))

👉 If you plan to run the database in a container, you will need a common Docker network:

```bash
docker network create sms_services
````

👉 If your database runs directly on the host,
you can **comment out** the `networks` section in the `docker-compose.yml`.

---

## Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/Gasprinskiy/gammu-smsd-container.git
   cd gammu-smsd-container
   ```

2. Create a `.env` file in the root of the project with the following variables:

   ```env
   DB_HOST=gammu-mysql-db:3306
   DB_USER=smsuser
   DB_PASSWORD=yourpassword
   DB_NAME=smsdb

   # Path to GSM modem device
   GSM_MODEM_PORT=/dev/ttyUSB0

   # Endpoint for handling incoming SMS
   MESSAGE_HANDLER_ENDPOINT=http://gammu-message-handler:8080/inbox/on_recieve
   ```

3. Start the SMSD container:

   ```bash
   ./start_docker.sh
   ```

---

## How it works

* Gammu SMSD automatically connects to your modem.

* When an SMS is received:

  * It is stored in the database (`inbox` table, see [gammu-mysql-db](https://github.com/Gasprinskiy/gammu-mysql-db))
  * The script `on_receive.sh` is triggered
  * This script sends an HTTP POST request to the `MESSAGE_HANDLER_ENDPOINT`

  Example POST body:

  ```json
  {
    "sender_number": "+998901234567"
  }
  ```

* By default, the repository points to your configured `MESSAGE_HANDLER_ENDPOINT`.
  You can:

  * Use your own service
  * Or deploy [gammu-message-handler](https://github.com/Gasprinskiy/gammu-message-handler) for Telegram integration

---

## Integration

* 📦 Database schema: [gammu-mysql-db](https://github.com/Gasprinskiy/gammu-mysql-db)
* 📦 Message handler: [gammu-message-handler](https://github.com/Gasprinskiy/gammu-message-handler)