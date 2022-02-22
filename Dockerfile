FROM rocker/shiny:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get install -y git libxml2-dev libmagick++-dev && \
    rm -rf /var/lib/apt/lists/*

RUN Rscript -e 'install.packages(c("shiny","tidyverse"))'

COPY /app/ /app/

RUN cd /app/ && \
    sudo chown -R shiny:shiny /app/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/app/', host = '0.0.0.0', port = 3838)"]
