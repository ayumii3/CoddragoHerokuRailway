FROM python:3.10-slim-bullseye as main

# Variáveis de ambiente
ENV RAILWAY=true
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet
ENV PIP_NO_CACHE_DIR=1

# Instalação de dependências
RUN apt update && apt install -y libcairo2 git --no-install-recommends
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# Clonando o repositório
RUN git clone https://github.com/coddrago/Heroku /Hikka
WORKDIR /Hikka

# Instalando dependências do Python
RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
RUN pip install --no-warn-script-location --no-cache-dir redis

# Expondo a porta
EXPOSE 8080

# Criando diretório de dados
RUN mkdir /data

# Script de inicialização
COPY init.sh /init.sh
RUN chmod +x /init.sh

# Comando de inicialização
CMD ["/init.sh"]