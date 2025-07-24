FROM python:3.12-slim

WORKDIR /app

# Copiar requirements e instalar dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código da aplicação
COPY . .

# Criar diretório público se não existir
RUN mkdir -p public

# Expor a porta que o Render usa
EXPOSE 10000

# Comando de execução
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]