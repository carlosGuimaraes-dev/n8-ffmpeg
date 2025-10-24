# n8n com FFmpeg (Build Automatizado)

[![Build & Push Docker Image](https://github.com/carlosGuimaraes-dev/n8-ffmpeg/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/carlosGuimaraes-dev/n8-ffmpeg/actions/workflows/docker-publish.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/carlosguimaraes76/n8n-ffmpeg)](https://hub.docker.com/r/carlosguimaraes76/n8n-ffmpeg)

Este repositório contém a configuração para construir uma imagem Docker customizada do **n8n**, a ferramenta de automação de workflows, com a adição do **FFmpeg**.

Isso permite a criação de fluxos de trabalho que podem executar operações complexas de manipulação de áudio e vídeo, como conversão de formatos, extração de clipes, geração de thumbnails e muito mais, diretamente de dentro do n8n através do nó "Execute Command".

A imagem é construída e publicada automaticamente no Docker Hub via GitHub Actions.

## ✨ Features

-   **Baseado no n8n oficial:** Utiliza a imagem oficial do n8n como base, garantindo estabilidade.
-   **FFmpeg incluído:** Vem com uma instalação completa do FFmpeg, pronta para uso.
-   **Builds automatizados:** Cada `push` na branch `main` aciona o GitHub Actions para construir e publicar uma nova imagem no Docker Hub.
-   **Pronto para Deploy:** Otimizado para fazer deploy em plataformas como Railway, Heroku, etc.

## ⚙️ Como Funciona o Build

O processo de CI/CD é simples e totalmente gerenciado pelo GitHub Actions:

1.  Um `push` é feito na branch `main`.
2.  O workflow definido em `.github/workflows/docker-publish.yml` é acionado.
3.  O Action faz login no Docker Hub usando os segredos `DOCKERHUB_USERNAME` e `DOCKERHUB_TOKEN`.
4.  A imagem Docker é construída a partir do `Dockerfile`.
5.  A imagem final é enviada (push) para o Docker Hub com as tags `latest` e uma tag de versão específica.

## 🚀 Deploy no Railway

Esta imagem é ideal para fazer deploy no Railway. Siga os passos abaixo:

1.  **Crie um Novo Projeto:** No seu painel do Railway, clique em **New Project**.
2.  **Deploy a partir de uma Imagem Docker:** Escolha a opção **Deploy from Docker Image**.
3.  **Informe o nome da Imagem:**
    `carlosguimaraes76/n8n-ffmpeg:latest`
4.  **Defina o Comando de Inicialização:**
    -   Após o deploy inicial (que pode falhar), vá para a aba **Settings** do seu novo serviço.
    -   Na seção "Service", encontre o campo **Start Command**.
    -   Insira o seguinte comando:
        ```
        n8n
        ```
    -   Isso garantirá que o Railway inicie o contêiner corretamente.

## 🔧 Configuração (Variáveis de Ambiente)

Para rodar n8n em produção, você **precisa** configurar algumas variáveis de ambiente no Railway (na aba **Variables** do seu serviço).

| Variável | Descrição | Exemplo de Valor |
| :--- | :--- | :--- |
| `N8N_ENCRYPTION_KEY` | **(OBRIGATÓRIO)** Chave secreta para criptografar suas credenciais. [Gere uma string longa e aleatória](https://1password.com/password-generator/). | `uma_string_muito_longa_e_aleatoria_de_32_chars` |
| `WEBHOOK_URL` | **(OBRIGATÓRIO)** A URL pública do seu serviço. Você pode encontrá-la na aba **Settings** do Railway. | `https://meu-n8n.up.railway.app/` |
| `GENERIC_TIMEZONE` | **(Recomendado)** Garante que os workflows agendados (CRON) rodem no fuso horário correto. | `America/Los_Angeles` |
| `DB_TYPE` | **(Recomendado)** Para usar um banco de dados persistente (evita perder dados a cada deploy). | `postgresdb` |
| `DB_POSTGRESDB_*` | **(Recomendado)** Variáveis de conexão com o banco de dados. O Railway as fornece automaticamente quando você cria um serviço PostgreSQL. | `${{Postgres.host}}`, `${{Postgres.database}}`, etc. |

---

## 💻 Desenvolvimento Local (Opcional)

Se você tiver Docker instalado localmente e quiser testar a imagem:

**1. Construa a imagem:**
```bash
docker build -t n8n-ffmpeg .
