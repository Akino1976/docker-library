FROM rocker/r-base

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    unixodbc \
    unixodbc-dev

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
