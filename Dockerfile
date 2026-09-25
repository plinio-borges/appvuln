FROM python:3.9	

LABEL maintainer="lab"
LABEL purpose="Vulnerable application for Trivy training"

WORKDIR /app

# Instala ferramentas desnecessárias propositalmente
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        vim \
        net-tools \
        iputils-ping \
        telnet \
        git \
        gcc \
        build-essential && \
    rm -rf /var/lib/apt/lists/*

# Copia toda a aplicação
COPY . /app

# Instala dependências sem controle de versão
RUN pip install --no-cache-dir -r requirements.txt

# Informações propositalmente expostas
ENV APP_ENV=development
ENV DEBUG=true
ENV DB_USER=admin
ENV DB_PASSWORD=SuperSecret123

# Executa como root propositalmente
USER root

EXPOSE 8080

# Aplicação principal
CMD ["python", "banco_terminal.py"]
