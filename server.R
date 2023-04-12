library(shiny)
library(shinydashboard)
library(plotly)
library(stringr)

source("khorana_model.R")
source("heatmap.R")

server <- function(input, output, session) {
  ## Store the values for the different models
  data <- reactiveValues(hf = NA,
                         age = NA,
                         # khorana
                         platelet_ge_350 = NA,
                         hemoglobin_l_10 = NA,
                         leukocyte_ge_11 = NA,
                         bmi_ge_35 = NA
                         )
  
  ## !! Age block !!
  observeEvent(input$age, {
    if(is.numeric(input$age) && as.numeric(input$age) >= 40 && as.numeric(input$age) <= 80) {
      data$age <- as.numeric(input$age)
    } else {
      data$age <- NULL
    }
  })
  
  output$age_status <- renderText({
    if(input$age == '' || is.null(input$age) || is.na(input$age)) {
      return("Age is invalid")
    } else if(as.numeric(input$age) < 40) {
      return('Age must be above or equal to 40')
    } else if(as.numeric(input$age) > 80) {
      return('Age must be below or equal to 80')
    }
  })
  ## !! Age block !!
  
  ## --------------- KHORANA
  ## !! Platelet block !!
  ## Check if the yes button was pressed
  observeEvent({
    input$t3_platelet_350_yes
    1
  }, {
    if(input$t3_platelet_350_yes) {
      updateActionButton(session = session, inputId = 't3_platelet_350_yes', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_platelet_350_no', icon = character(0))
      data$platelet_ge_350 <- T
    }
  })
  ## Check if the no button was pressed
  observeEvent({
    input$t3_platelet_350_no
    1
  }, {
    if(input$t3_platelet_350_no) {
      updateActionButton(session = session, inputId = 't3_platelet_350_no', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_platelet_350_yes', icon = character(0))
      data$platelet_ge_350 <- F
    }
  })
  ## Update information text
  output$t3_platelet_350_status <- renderText({
    if(is.na(data$platelet_ge_350)) {
      return(as.character(icon('exclamation-triangle')))
    }
  })
  ## !! Platelet block !!
  
  ## !! Hemoglobin block !!
  ## Check if the yes button was pressed
  observeEvent({
    input$t3_hemoglobin_10_yes
    1
  }, {
    if(input$t3_hemoglobin_10_yes) {
      updateActionButton(session = session, inputId = 't3_hemoglobin_10_yes', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_hemoglobin_10_no', icon = character(0))
      data$hemoglobin_l_10 <- T
    }
  })
  ## Check if the no button was pressed
  observeEvent({
    input$t3_hemoglobin_10_no
    1
  }, {
    if(input$t3_hemoglobin_10_no) {
      updateActionButton(session = session, inputId = 't3_hemoglobin_10_no', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_hemoglobin_10_yes', icon = character(0))
      data$hemoglobin_l_10 <- F
    }
  })
  ## Update information text
  output$t3_hemoglobin_10_status <- renderText({
    if(is.na(data$hemoglobin_l_10)) {
      return(as.character(icon('exclamation-triangle')))
    }
  })
  ## !! Hemoglobin block !!
  
  ## !! Leukocyte block !!
  ## Check if the yes button was pressed
  observeEvent({
    input$t3_leukocyte_11_yes
    1
  }, {
    if(input$t3_leukocyte_11_yes) {
      updateActionButton(session = session, inputId = 't3_leukocyte_11_yes', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_leukocyte_11_no', icon = character(0))
      data$leukocyte_ge_11 <- T
    }
  })
  ## Check if the no button was pressed
  observeEvent({
    input$t3_leukocyte_11_no
    1
  }, {
    if(input$t3_leukocyte_11_no) {
      updateActionButton(session = session, inputId = 't3_leukocyte_11_no', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_leukocyte_11_yes', icon = character(0))
      data$leukocyte_ge_11 <- F
    }
  })
  ## Update information text
  output$t3_leukocyte_status <- renderText({
    if(is.na(data$leukocyte_ge_11)) {
      return(as.character(icon('exclamation-triangle')))
    }
  })
  ## !! Leukocyte block !!
  
  ## !! BMI block !!
  ## Check if the yes button was pressed
  observeEvent({
    input$t3_bmi_35_yes
    1
  }, {
    if(input$t3_bmi_35_yes) {
      updateActionButton(session = session, inputId = 't3_bmi_35_yes', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_bmi_35_no', icon = character(0))
      data$bmi_ge_35 <- T
    }
  })
  ## Check if the no button was pressed
  observeEvent({
    input$t3_bmi_35_no
    1
  }, {
    if(input$t3_bmi_35_no) {
      updateActionButton(session = session, inputId = 't3_bmi_35_no', icon = icon("check", lib = "font-awesome"))
      updateActionButton(session = session, inputId = 't3_bmi_35_yes', icon = character(0))
      data$bmi_ge_35 <- F
    }
  })
  ## Update information text
  output$t3_bmi_35_status <- renderText({
    if(is.na(data$bmi_ge_35)) {
      return(as.character(icon('exclamation-triangle')))
    }
  })
  ## !! BMI block !!
  ## --------------- KHORANA
  
  ## Output
  # output$text <- renderText({paste0("You are viewing tab \"", input$tabs, "\"")})
  
  output$output_score <- renderValueBox({
    if(input$tabs == "Khorana") {
      # platelet_ge_350, hemoglobin_l_10, leukocyte_ge_11, bmi_ge_35
      risk_group <- khorana_risk_group(input$t3_cancer_type,
                                       data$platelet_ge_350,
                                       data$hemoglobin_l_10,
                                       data$leukocyte_ge_11,
                                       data$bmi_ge_35)
      
      risk_score <- khorana_score(input$t3_cancer_type,
                                   data$platelet_ge_350,
                                   data$hemoglobin_l_10,
                                   data$leukocyte_ge_11,
                                   data$bmi_ge_35)
      
      col <- switch(as.character(risk_group), 
                    "Low" = "green",
                    "Intermediate" = "yellow",
                    "High" = "red",
                    `NA` = "black")
      
      risk_score <- ifelse(is.na(risk_score), "Missing", risk_score)
      
      valueBox(risk_score, 
               "Risk score", icon = icon("exclamation-triangle"), color = col)
    } else {
      valueBox("Select Khorana tab", 
               "Risk score", icon = icon("fire"), color = "yellow")
    }
  })
  
  output$output_risk <- renderValueBox({
    if(input$tabs == "Khorana") {
      risk_group <- khorana_risk_group(input$t3_cancer_type,
                                       data$platelet_ge_350,
                                       data$hemoglobin_l_10,
                                       data$leukocyte_ge_11,
                                       data$bmi_ge_35)
      
      risk_rate <- khorana_rate(input$t3_cancer_type,
                                       data$platelet_ge_350,
                                       data$hemoglobin_l_10,
                                       data$leukocyte_ge_11,
                                       data$bmi_ge_35)
      
      col <- switch(as.character(risk_group), 
                    "Low" = "green",
                    "Intermediate" = "yellow",
                    "High" = "red",
                    `NA` = "black")
      
      risk_rate <- ifelse(is.na(risk_rate), "Missing", risk_rate)
      
      valueBox(risk_rate, 
               "2.5-month rate of VTE", icon = icon("exclamation-triangle"), color = 'orange')
    } else {
      valueBox("Select Khorana tab", 
               "2.5-month rate of VTE", icon = icon("fire"), color = "yellow")
    }
  })
  
  output$output_risk_group <- renderValueBox({
    if(input$tabs == "Khorana") {
      risk_group <- khorana_risk_group(input$t3_cancer_type,
                                       data$platelet_ge_350,
                                       data$hemoglobin_l_10,
                                       data$leukocyte_ge_11,
                                       data$bmi_ge_35)
      
      col <- switch(as.character(risk_group), 
                    "Low" = "green",
                    "Intermediate" = "yellow",
                    "High" = "red",
                    `NA` = "black")
      
      risk_group <- ifelse(is.na(risk_group), "Missing", risk_group)
      
      valueBox(risk_group, 
               "Risk group", icon = icon("exclamation-triangle"), color = col)
    } else {
      valueBox("Select Khorana tab", 
               "Risk group", icon = icon("fire"), color = "yellow")
    }
  })

  output$plot_left <- renderPlot({
    if(input$tabs == "Khorana") {
      risk_rate <- khorana_rate(input$t3_cancer_type,
                                data$platelet_ge_350,
                                data$hemoglobin_l_10,
                                data$leukocyte_ge_11,
                                data$bmi_ge_35)
      
      if(is.na(risk_rate)) {
        figure <- NULL
      } else {
        risk_rate <- 100 - round(as.numeric(str_split(sub("%", "", risk_rate), " - ")[[1]][1]))
        
        figure <- get_data_points(risk_rate, 100-risk_rate)
      }
    } else {
      figure <- NULL
    }
    plot(figure)
  })
  
  output$plot_right <- renderPlot({
    if(input$tabs == "Model 3") {
      risk_rate <- min(as.numeric(input$age) + 7, 100)
      figure <- get_data_points(100-risk_rate, risk_rate)
      plot(figure)
    } else if(input$tabs == "Khorana") {
      risk_rate <- khorana_rate(input$t3_cancer_type,
                                data$platelet_ge_350,
                                data$hemoglobin_l_10,
                                data$leukocyte_ge_11,
                                data$bmi_ge_35)
      
      if(is.na(risk_rate)) {
        figure <- NULL
      } else {
        risk_rate <- 100 - round(as.numeric(str_split(sub("%", "", risk_rate), " - ")[[1]][2]))
        
        figure <- get_data_points(risk_rate, 100-risk_rate)
      }
    } else {
      figure <- NULL
    }
    plot(figure)
  })
  ##
}