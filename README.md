# ADHD medication collection among girls and boys (0-19 year olds) in Sweden over time

Dashboard plotting the number of people in Sweden aged 0-19 who have have filled a prescription for ADHD medication each year. The dashboard is based on open data from the *The Swedish National Board of Health and Welfare* (*Socialstyrelsen*). Specifically, the data has been extracted from the [Statistikdatabas för läkemedel](https://sdb.socialstyrelsen.se/if_lak/val.aspx) where data about all medications that have been bought/given based on a prescription in Sweden since 2006 are available.

The live dashboard can be found here: [adhd-medication-sweden.serve.scilifelab.se](https://adhd-medication-sweden.serve.scilifelab.se/).

## How the dashboard is built

The dashboard is built using [R](https://www.r-project.org/) with [Shiny](https://shiny.rstudio.com/) and [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html) packages. The code of the Shiny app can be found at `/app/app.R`; the app can be run locally e.g. using RStudio.

The underlying data is in a CSV file, located in the same folder as the dashboard code (`/app/`).

In addition, this repository contains commands to build an image with the app code and data (see `Dockerfile` for settings) and to push to DockerHub through GitHub actions (see `.github/workflows/docker-image.yml` for settings). On DockerHub this image can be found under `scilifelabdatacentre/shiny-adhd-medication-sweden`.

## Contributing

Suggestions and contributions are welcome. If you found a mistake or would like to make a suggestion, please create an issue in this repository. Those who wish are also welcome to submit pull requests.

## Contact

This dashboard was built by [@akochari](http://github.com/akochari/).
