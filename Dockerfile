FROM rocker/r-base

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    unixodbc \
    unixodbc-dev


RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
        apt-transport-https \
        curl \
        gnupg \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install --yes --no-install-recommends msodbcsql17 \
    && install2.r odbc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*


RUN install2.r --error \
    Rcpp \
    lubridate \
    ndjson \
    xts \
    readxl \
    data.table \
    dplyr \
    RODBC \
    ggplot2 \
    scales \
    caret \
    gridExtra \
    readr \
    ggthemes \
    bit64
