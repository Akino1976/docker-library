FROM databricksruntime/standard:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    unixodbc \
    unixodbc-dev

RUN apt-get update \
  && apt-get install --yes software-properties-common apt-transport-https \
  && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
  && gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add - \
  && add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/' \
  && apt-get update \
  && apt-get install --yes \
    libssl-dev \
    r-base \
    r-base-dev \
  && add-apt-repository -r 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/' \
  && apt-key del E298A3A825C0D65DFD57CBB651716619E084DAB9 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# hwriterPlus is used by Databricks to display output in notebook cells
# Rserve allows Spark to communicate with a local R process to run R code
RUN R -e "install.packages('hwriterPlus', repos='https://mran.revolutionanalytics.com/snapshot/2017-02-26')" \
 && R -e "install.packages('Rserve', repos='http://rforge.net/')"


RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
        apt-transport-https \
        curl \
        gnupg \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install --yes --no-install-recommends msodbcsql17 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN R -e "install.packages('odbc')" \
    && R -e "install.packages('Rcpp')" \
    && R -e "install.packages('data.table')" \
    && R -e "install.packages('ggplot2')" \
    && R -e "install.packages('scales')" \
    && R -e "install.packages('dplyr')" \
    && R -e "install.packages('DBI')" \
    && R -e "install.packages('lubridate')"
