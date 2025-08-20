# Usa una imagen oficial de R
FROM rocker/r-ver:4.3.1

# Instala dependencias del sistema necesarias para compilar paquetes
RUN apt-get update -qq && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala los paquetes de R necesarios
RUN R -e "install.packages(c('plumber','dplyr'), repos='https://cloud.r-project.org/')"

# Copia tu proyecto al contenedor
WORKDIR /app
COPY . /app

# Render necesita que expongas el puerto 8000
EXPOSE 8000

# Comando para arrancar la API
CMD ["Rscript", "app.R"]
