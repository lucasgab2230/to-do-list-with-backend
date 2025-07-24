FROM python:3.12-slim

# Labels para melhor identificação
LABEL maintainer="lucas.gabriel.w2025@gmail.com"
LABEL version="1.0"
LABEL description="Todo App Production Server"

# Variáveis de ambiente
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV FLASK_ENV=production

# Diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema necessárias
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements e instalar dependências Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código da aplicação
COPY . .

# Criar diretório público se não existir
RUN mkdir -p public

# Criar usuário não-root para segurança
RUN adduser --disabled-password --gecos '' appuser
RUN chown -R appuser:appuser /app
USER appuser

# Expor a porta padrão
EXPOSE 10000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:10000/health || exit 1

# Comando de execução otimizado
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "--workers", "2", "--timeout", "30", "app:app"]