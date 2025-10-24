# n8n with FFmpeg

[![Build & Push Docker Image](https://github.com/carlosGuimaraes-dev/n8-ffmpeg/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/carlosGuimaraes-dev/n8-ffmpeg/actions/workflows/docker-publish.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/carlosguimaraes76/n8n-ffmpeg)](https://hub.docker.com/r/carlosguimaraes76/n8n-ffmpeg)

This repository contains the configuration to build a custom **n8n** Docker image that includes **FFmpeg**.

This enhancement allows for the creation of powerful automation workflows that can perform complex audio and video manipulation tasks, such as format conversion, clip extraction, thumbnail generation, and much more, directly within n8n using the "Execute Command" node.

The image is automatically built and published to Docker Hub via GitHub Actions.

## ✨ Features

-   **Based on Official n8n:** Uses the official n8n image as its foundation, ensuring stability and compatibility.
-   **FFmpeg Included:** Comes with a full installation of FFmpeg, ready to be used in your workflows.
-   **Automated Builds:** Every `push` to the `main` branch triggers a GitHub Action to build and publish a fresh image to Docker Hub.
-   **Deploy Ready:** Optimized for easy deployment on platforms like Railway, Heroku, and others.

## ⚙️ How the Build Works

The CI/CD process is managed entirely by GitHub Actions:

1.  A `push` is made to the `main` branch.
2.  The workflow defined in `.github/workflows/docker-publish.yml` is triggered.
3.  The Action logs into Docker Hub using the `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets.
4.  The Docker image is built from the `Dockerfile` in this repository.
5.  The final image is pushed to Docker Hub with the `latest` and a specific version tag.

## 🚀 Deploy on Railway

This image is ideal for deploying on Railway. Follow these steps:

1.  **Create a New Project:** In your Railway dashboard, click **New Project**.
2.  **Deploy from Docker Image:** Choose the **Deploy from Docker Image** option.
3.  **Provide the Image Name:**
    `carlosguimaraes76/n8n-ffmpeg:latest`
4.  **Set the Start Command:**
    -   After the initial deployment (which might fail), go to your new service's **Settings** tab.
    -   In the "Service" section, locate the **Start Command** field.
    -   Enter the following command:
        ```
        n8n
        ```
    -   This ensures Railway starts the container correctly.

## 🔧 Configuration (Environment Variables)

To run n8n in production, you **must** configure the following environment variables in your Railway service's **Variables** tab.

| Variable             | Description                                                                                                                   | Example Value                                        |
| :------------------- | :---------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------- |
| `N8N_ENCRYPTION_KEY` | **(REQUIRED)** A secret key to encrypt your credentials. [Generate a long, random string](https://1password.com/password-generator/).     | `a_very_long_and_random_string_of_at_least_32_chars` |
| `WEBHOOK_URL`        | **(REQUIRED)** The public URL of your service. You can find this in the Railway **Settings** tab.                                 | `https://my-n8n-instance.up.railway.app/`                |
| `GENERIC_TIMEZONE`   | **(Recommended)** Ensures that scheduled workflows (CRON) run in the correct timezone.                                        | `America/Los_Angeles`                                |
| `DB_TYPE`            | **(Recommended)** To use a persistent database, preventing data loss on redeploy.                                             | `postgresdb`                                         |
| `DB_POSTGRESDB_*`    | **(Recommended)** Connection variables for the database. Railway provides these automatically when you add a PostgreSQL service. | `${{Postgres.host}}`, `${{Postgres.database}}`, etc.     |

---

## 💻 Local Development (Optional)

If you have Docker installed locally and wish to test the image:

**1. Build the image:**
```bash
docker build -t n8n-ffmpeg .
```

**2. Run the container:**
```bash
docker run -d --rm \
  --name n8n-local \
  -p 5678:5678 \
  -e N8N_ENCRYPTION_KEY="your_super_secret_key_here" \
  -e GENERIC_TIMEZONE="America/Los_Angeles" \
  n8n-ffmpeg
```

You can then access the local instance at `http://localhost:5678`.

## 📄 License

This project is licensed under the MIT License.
```

**1. Construa a imagem:**
```bash
docker build -t n8n-ffmpeg .
