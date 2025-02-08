FROM python:3.10-slim-bullseye as main

# Variáveis de ambiente
ENV RAILWAY=true
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet
ENV PIP_NO_CACHE_DIR=1

# Instalar dependências básicas
RUN apt update && apt install libcairo2 git -y --no-install-recommends

# Limpar arquivos temporários para reduzir o tamanho da imagem
RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

# Clonar o repositório
RUN git clone https://github.com/coddrago/Heroku /Hikka
WORKDIR /Hikka

# Instalar dependências do Python
RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
RUN pip install --no-warn-script-location --no-cache-dir redis

# Expor a porta 8080
EXPOSE 8080

# Criar o diretório de dados
RUN mkdir /data

# Rodar o bot
CMD ["python3", "-m", "hikka"]