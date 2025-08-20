FROM r-base:4.3.1

# Instalar plumber (y otras dependencias si las necesitas)
RUN R -e "install.packages('plumber', repos='https://cloud.r-project.org')"

# Copiar tu API al contenedor
WORKDIR /app
COPY api.R /app/

# Exponer el puerto (Render usa $PORT)
EXPOSE 8000

# Comando para ejecutar la API con plumber
CMD ["R", "-e", "pr <- plumber::plumb('api.R'); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT', 8000)))"]
