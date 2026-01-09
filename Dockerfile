FROM webdevops/php-apache:7.2

# Set environment variables
ENV WEB_DOCUMENT_ROOT=/app \
    PHP_DISPLAY_ERRORS=1 \
    PHP_DATE_TIMEZONE="America/Sao_Paulo"

# Set working directory
WORKDIR /app

# Copy application files
COPY ./src /app

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1
