library(shiny)

### Khorana Risk Score for Venous Thromboembolism in Cancer Patients
tab_khorana <- menuItem("Risk Model", tabName = "Khorana")

content_khorana <- div(id = 'sidebar_khorana',
                       conditionalPanel("input.tabs === 'Khorana'",
                                        ## Cancer Type
                                        selectInput("t3_cancer_type", "Cancer type:",
                                                    c("Stomach", "Pancreas", "Lung", "Lymphoma", "Gynecology", "Bladder", "Testicular", "Other")),
                                        ##
                                        br(),
                                        ## Platelet count
                                        div(class = "container-space",
                                          div(
                                            tags$b('Pre-chemotherapy platelet count \u2265350x10\u2079/L'),
                                            span(uiOutput("t3_platelet_350_status", inline=TRUE), style="color:red")
                                          ),
                                          div(
                                            div(style="display: inline-block;", actionButton("t3_platelet_350_no", "No")),
                                            div(style="display: inline-block;", actionButton("t3_platelet_350_yes", "Yes")),
                                          ),
                                        ),
                                        ##
                                        br(),
                                        ## Hemoglobin
                                        div(class = "container-space",
                                            div(
                                              tags$b('Hemoglobin level <10 g/dL or using RBC growth factors'),
                                              span(uiOutput("t3_hemoglobin_10_status", inline=TRUE), style="color:red")
                                            ),
                                            div(
                                              div(style="display: inline-block;", actionButton("t3_hemoglobin_10_no", "No")),
                                              div(style="display: inline-block;", actionButton("t3_hemoglobin_10_yes", "Yes")),
                                            ),
                                        ),
                                        ##
                                        br(),
                                        ## Leukocyte
                                        div(class = "container-space",
                                            div(
                                              tags$b('Pre-chemotherapy leukocyte count >11x10\u2079/L'),
                                              span(uiOutput("t3_leukocyte_status", inline=TRUE), style="color:red")
                                            ),
                                            div(
                                              div(style="display: inline-block;", actionButton("t3_leukocyte_11_no", "No")),
                                              div(style="display: inline-block;", actionButton("t3_leukocyte_11_yes", "Yes")),
                                            ),
                                        ),
                                        ##
                                        br(),
                                        ## BMI
                                        div(class = "container-space",
                                            div(
                                              tags$b('BMI \u226535 kg/m\u00b2'),
                                              span(uiOutput("t3_bmi_35_status", inline=TRUE), style="color:red")
                                            ),
                                            div(
                                              div(style="display: inline-block;", actionButton("t3_bmi_35_no", "No")),
                                              div(style="display: inline-block;", actionButton("t3_bmi_35_yes", "Yes")),
                                            ),
                                        )
                                        ##
                                        )
                       )

                        
                        

