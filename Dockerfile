FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências do sistema
RUN apt update && \
    apt install -y python3 python3-pip python3-venv build-essential && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Criar ambiente virtual
RUN python3 -m venv /opt/venv

# Ativar ambiente virtual através do PATH
ENV PATH="/opt/venv/bin:$PATH"

# Copiar e instalar dependências Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código da aplicação
COPY . .

# Comando de execução
CMD ["python", "app.py"]