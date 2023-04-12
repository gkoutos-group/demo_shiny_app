library(shiny)
library(shinydashboard)

source('ui_tabs.R')

ui <- dashboardPage(
                dashboardHeader(title = "Risk models"),
                dashboardSidebar(width=400,
                  sidebarMenu(id = "tabs",
                              style = "position:relative;",
                              tab_khorana,
                              content_khorana
                  ),
                  br()
                  # actionButton("refresh", 'Refresh', icon = icon('sync')),
                ),
                dashboardBody(
                  tags$head(
                    tags$style(HTML('.shiny-split-layout>div {overflow: hidden;}')),
                    tags$style(type='text/css', ".form-control.shiny-bound-input { text-align:center; max-width: 100px;}"),
                    tags$style(type='text/css', ".container-space { padding: 12px 15px 0px 15px;}")
                  ),
                  tags$head(tags$script('$(document).on("shiny:connected", function(e) {
                            Shiny.onInputChange("innerWidth", window.innerWidth);
                            });
                            $(window).resize(function(e) {
                            Shiny.onInputChange("innerWidth", window.innerWidth);
                            });
                            ')),
                  textOutput("text"),
                  fluidRow(valueBoxOutput("output_score"),
                           valueBoxOutput("output_risk"),
                           valueBoxOutput("output_risk_group")
                           ),
                  fluidRow(
                    box(title = "Current risk", solidHeader = T,
                        width = 6, collapsible = T, column(12, align='center', 
                                                           plotOutput("plot_left", width="400px", height="400px"))),
                    box(title = "Other plot", solidHeader = T,
                        width = 6, collapsible = T, column(12, align='center',
                                                           plotOutput("plot_right", width="400px", height="400px")))
                  )
                )
)