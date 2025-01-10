#
# This is a R Shiny dashboard exploring ADHD medication collection among 0-19 year olds in Sweden. The dashboard is based on data from Socialstyrelsen.
# GitHub repository: https://github.com/scilifelabdatacentre/adhd-medication-sweden
#

library(shiny)
library(tidyverse)

# Define UI for application
ui <- fluidPage(

    # Dashboard title
    titlePanel("ADHD medication collection among girls and boys (0-19 year olds) in Sweden over time"),

    # Intro text
    fluidRow(
      column(12,
             HTML("<p>Historically, boys have been diagnosed with ADHD and received treatment at a higher rate than girls<sup>[1]</sup>. While some estimates suggest that the symptoms may indeed be more severe among boys with ADHD than among girls with ADHD <sup>[2]</sup>, the gap is unlikely to be as large as the one seen in diagnosis rates <sup>[3]</sup>. Various researchers attribute the gap between boys and girls to, for example, a different presentation of the symptoms <sup>[4]</sup> or biased assessment of the girls' behaviour by parents and teachers <sup>[5]</sup>. This is a significant issue as we know that ADHD can severely lower life quality in both childhood and adulthood <sup>[6]</sup>. Here, I explore whether there are differences in the ADHD diagnosis and treatment rate between girls and boys in Sweden, and how that has changed over time (i.e. whether the gap is narrowing).</p>"),
             HTML("<p style='margin-bottom: 30px;'>Using open data from <i>The Swedish National Board of Health and Welfare</i> (<i>Socialstyrelsen</i>), I plot the number of people aged 0-19 who have have filled a prescription for ADHD medication each year as a proxy for diagnosis and treatment. What I was interested in is whether the rate of increase of the number of medication users is higher for girls than for boys; this would indicate that the sex gap is narrowing.</p>")
      )
    ),
    
    # Sidebar with inputs
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("sex", h4("Sexes to display"), 
                             choices = list("Female" = 'Kvinnor', 
                                            "Male" = 'Män', 
                                            "Both sexes" = 'Båda könen'),
                             selected = c('Män','Kvinnor')),
            radioButtons("medication", h4("Active ingredient to display"),
                         choices = list("All*" = 'all',
                                        "Metylfenidat" = 'N06BA04 Metylfenidat', 
                                        "Dexamfetamin" = 'N06BA02 Dexamfetamin',
                                        "Lisdexamfetamin" = 'N06BA12 Lisdexamfetamin',
                                        "Guanfacin" = 'C02AC02 Guanfacin',
                                        "Atomoxetin" = 'N06BA09 Atomoxetin'),
                         selected = 'N06BA04 Metylfenidat'),
            selectInput("region", h4("County to display"), 
                        choices = list("All counties" = 'Riket', 
                                       "Blekinge County" = 'Blekinge län',
                                       "Dalarna County" = 'Dalarnas län',
                                       "Gävleborg County" = 'Gävleborgs län',
                                       "Gotland County" = 'Gotlands län',
                                       "Halland County" = 'Hallands län',
                                       "Jämtland County" = 'Jämtlands län',
                                       "Jönköping County" = 'Jönköpings län',
                                       "Kalmar County" = 'Kalmar län',
                                       "Kronoberg County" = 'Kronobergs län',
                                       "Norrbotten County" = 'Norrbottens län',
                                       "Örebro County" = 'Örebro län',
                                       "Östergötland County" = 'Östergötlands län',
                                       "Skåne County" = 'Skåne län',
                                       "Södermanland County" = 'Södermanlands län',
                                       "Stockholm County" = 'Stockholms län',
                                       "Uppsala County" = 'Uppsala län',
                                       "Värmland County" = 'Värmlands län',
                                       "Västerbotten County" = 'Västerbottens län',
                                       "Västernorrland County" = 'Västernorrlands län',
                                       "Västmanland County" = 'Västmanlands län',
                                       "Västra Götaland County" = 'Västra Götalands län'),
                        selected = 'Riket'),
            sliderInput("year", h4("Years to display"),
                        min = 2006, max = 2023, sep = "", value = c(2006, 2023))
        ),

        # Show the plot
        mainPanel(
           plotOutput("medicationsPlot"),
           column(12, p("The graph shows the number of patients aged 0-19 per 1000 inhabitants aged 0-19 who have at least once during the year filled an ADHD medication prescription in Sweden. The number displayed at the end of the lines (e.g., 'x7', seven times higher) indicates the change between the first and the last year for which data is available."),
                      HTML("<p>Currently, there are five ADHD medication active ingredients <a target='_blank' href='https://lakemedelsverket.se/adhd'>approved for use in Sweden</a>. Three of these are central nervous system stimulants - metylfenidat, dexamfetamin and lisdexamfetamin. Two of these are not central stimulants - atomoxetin and guanfacin. Data can be displayed separately for each of them. Note that these are names of active ingredients but they may be sold under different brand names.</p>")),
           column(12, HTML("<p style='font-size: 0.9em;color:gray;'>*Please note that in the plot showing <i>all</i> active ingredients together the number of patients is simply a sum of patients which have filled prescription for each of the active ingredients. Therefore, if a patient has filled a prescription for more than one type of ADHD medication during the same year, they would be counted more than once. This means that the actual number of patients may be lower than the one displayed in this summed number. Different active ingredients are often tried when starting ADHD medication to find out which one is working best or needing to switch to another medication for some reason, so this does occur. This is not an issue when looking at each active ingredient separately.</p>"))
        ),
    ),

    # Explanation texts about the source of data, contributing, and references.
    fluidRow(
      column(12,
             h3("Data behind this dashboard", style = "margin-top: 30px;"),
             HTML("<p>The graph in this dashboard is based on open data from the <i>The Swedish National Board of Health and Welfare</i> (<i>Socialstyrelsen</i>). Specifically, the data has been extracted from the <a target='_blank' href='https://sdb.socialstyrelsen.se/if_lak/val.aspx'>Statistikdatabas för läkemedel</a> where data about all medications that have been bought/given based on a prescription in Sweden since 2006 are available.</p>"),
             h3("Code behind this dashboard"),
             HTML("<p>This dashboard is built using <a target='_blank' href='https://shiny.rstudio.com/'>R Shiny</a>. The data and code behind this dashboard <a target='_blank' href='https://github.com/akochari/adhd-medication-sweden'>are available on GitHub</a> (MIT license). Feel free to contribute to this dashboard by sending a pull request on GitHub or re-use the code for your own dashboards. If you have any suggestions or questions, you are welcome to start an issue on GitHub.</p>"),
             h3("References"),
             HTML("<ol>
                  <li>'Under-diagnosed and under-treated, girls with ADHD face distinct risks', 2020-04-17. Retrieved from https://knowablemagazine.org/article/mind/2020/adhd-in-girls-and-women</li>
                  <li>Arnett, Anne B., et al. 'Sex differences in ADHD symptom severity.' Journal of Child Psychology and Psychiatry 56.6 (2015): 632-639.</li>
                  <li>Ramtekkar, Ujjwal P., et al. 'Sex and age differences in attention-deficit/hyperactivity disorder symptoms and diagnoses: implications for DSM-V and ICD-11.' Journal of the American Academy of Child & Adolescent Psychiatry 49.3 (2010): 217-228.</li>
                  <li>Quinn, Patricia O. 'Attention-deficit/hyperactivity disorder and its comorbidities in women and girls: an evolving picture.' Current psychiatry reports 10.5 (2008): 419-423.</li>
                  <li>Mowlem, Florence, et al. 'Do different factors influence whether girls versus boys meet ADHD diagnostic criteria? Sex differences among children with high ADHD symptoms.' Psychiatry Research 272 (2019): 765-773.</li>
                  <li>Meza, Jocelyn I., Elizabeth B. Owens, and Stephen P. Hinshaw. 'Response inhibition, peer preference and victimization, and self-harm: Longitudinal associations in young adult women with and without ADHD.' Journal of abnormal child psychology 44.2 (2016): 323-334.</li>
                  </ol>")
      )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$medicationsPlot <- renderPlot({
        # load the data file
        adhd_medication <- read_delim("socialstyrelsen_2025-01-09.csv",
                                  delim = ";", escape_double = FALSE, 
                                  col_types = cols(År = col_integer()),
                                  locale = locale(decimal_mark = ","), 
                                  trim_ws = TRUE)
        
        # if needed, filter based on medication
        if(input$medication != 'all'){
          adhd_medication_filt <<- adhd_medication %>%
            filter(Läkemedel == input$medication)
        } else {
          adhd_medication_filt <<- adhd_medication
        }
        
        # filter data based on input, group, summarize, calculate difference for each sex
        adhd_medication_proc <- adhd_medication_filt %>%
          filter(Region == input$region, År >= input$year[1], År <= input$year[2], Kön %in% input$sex) %>%
          group_by(Kön, År) %>%
          summarize(patients_per_1000 = sum(`Patienter/1000 invånare`)) %>%
          group_by(Kön) %>% 
          mutate(change = last(patients_per_1000) / first(patients_per_1000)) %>% 
          mutate(change = ifelse(change >= 10, round(change), round(change, digits = 1))) %>%
          mutate(change = paste("x", as.character(change), sep = ""))
        
        # translate sexes to English
        adhd_medication_proc <- adhd_medication_proc %>%
          mutate(Kön = replace(Kön, Kön == 'Kvinnor', 'Female')) %>%
          mutate(Kön = replace(Kön, Kön == 'Män', 'Male')) %>%
          mutate(Kön = replace(Kön, Kön == 'Båda könen', 'Both sexes'))
      
        # plot the data
        ggplot(adhd_medication_proc, aes(x=as.character(År), y=patients_per_1000, group=Kön, color=Kön)) +
          geom_line(size=1.5) +
          geom_point(size=3) +
          geom_text(data = filter(adhd_medication_proc, År == max(År)), 
                                  aes(label = ifelse(change == "xInf", "", change)), vjust=2.5,
                                  show.legend = FALSE, size=7) +
          coord_cartesian(clip = "off") +
          scale_x_discrete(guide = guide_axis(check.overlap = TRUE)) +
          theme(text = element_text(size = 20), 
                legend.position="bottom",
                axis.title.y = element_text(size = 17)) +
          labs(
            x="Year",
            y="Patients per 1000 inhabitants aged 0-19",
            colour = "Sex"
          )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
