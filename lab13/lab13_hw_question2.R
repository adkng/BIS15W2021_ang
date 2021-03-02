# Question 2
# Adrianna Ng

library(tidyverse)
library(shiny)
library(shinydashboard)
library(naniar)
library(janitor)
library(stringr)
library(RColorBrewer)

UC_admit <- readr::read_csv("data/UC_admit.csv")
UC_admit <- clean_names(UC_admit)
uc_admit_perc <- UC_admit %>% 
  mutate(perc_fc_dbl = str_replace(perc_fr, "%", "")) %>% 
  select(-perc_fr)
uc_admit_perc$perc_fc_dbl <- as.numeric(uc_admit_perc$perc_fc_dbl)
uc_admit_perc$academic_yr <- as.factor(uc_admit_perc$academic_yr)

ui <- dashboardPage(skin = "black",
                    dashboardHeader(title = "University of California Admissions from 2010 - 2019",
                                    titleWidth = 600),
                    dashboardSidebar(disable = T),
                    dashboardBody(
                      fluidRow(
                        box(title = "Plot Options", width = 3,
                            selectInput("x", "Select Admission Criteria", choices = c("academic_yr", "campus", "category"), 
                                        selected = "academic_yr"),
                            selectInput("filter", "Select Ethnicity", choices = c("All", "African American", "American Indian", "Asian", "Chicano/Latino", "International", "White", "Unknown"), selected = "All"),
                            hr(),
                            helpText("Reference: University of California Information Center, Admissions (2010-2019)")
                        ), # close the first box
                        box(title = "Admissions by Ethnicity", width = 6,
                            plotOutput("plot", width = "600px", height = "500px")
                        ) # close the second box
                      ) # close the row
                    ) # close the dashboard body
) # close the ui

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
    uc_admit_perc %>%
      filter(ethnicity == input$filter) %>% 
      ggplot(aes_string(x = input$x, y = "filtered_count_fr", fill = "campus")) +
      scale_fill_brewer(palette = "Paired") +
      geom_col(position = "dodge") + 
      theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
      theme_minimal() +
      labs(y = "Number of Admitted Freshmen")
  })
  
  # stop the app when we close it
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)