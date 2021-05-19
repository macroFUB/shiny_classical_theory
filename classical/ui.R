library(shiny)
library(mathjaxr)

ui <- fluidPage(
  titlePanel("Modell der klassischen Theorie"),
  withMathJax(helpText(
    "$$C=c_0+c_1(Y-T),\\quad I=b_0-b_1r, \\quad G=\\bar{G}, \\quad T=\\bar{T},\\quad
    L=\\bar{L}, \\quad K=\\bar{K}, \\quad \\bar{Y}=\\bar{K}^\\alpha \\bar{L}^{(1-\\alpha)}$$"
  )),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId="c_0", label="c_0", value = 250, min = 0.01, max = 2000
      ),
      sliderInput(
        inputId = "c_1", label = "c_1", value = 0.75, min = 0.01, max = 0.99
      ),
      sliderInput(
        inputId = "T", label = "T", value = 1000, min = 0.01, max = 5000
      ),
      sliderInput(
        inputId = "b_0", label = "b_0", value = 1000, min = 0.01, max = 5000
      ),
      sliderInput(
        inputId = "b_1", label = "b_1", value = 5000, min = 0.01, max = 10000
      ),
      sliderInput(
        inputId = "G", label = "G", value = 1000, min = 0.01, max = 5000
      ),
      sliderInput(
        inputId = "L", label = "L", value = 5000, min = 0.01, max = 10000
      ),
      sliderInput(
        inputId = "K", label = "K", value = 5000, min = 0.01, max = 10000
      ),
      sliderInput(
        inputId="c_0_base", label="c_0_base", value = 250, min = 0.01, max = 2000
      ),
      sliderInput(
        inputId = "c_1_base", label = "c_1_base", value = 0.75, min = 0.01, max = 0.99
      ),
      sliderInput(
        inputId = "T_base", label = "T_base", value = 1000, min = 0.01, max = 5000
      ),
      sliderInput(
        inputId = "b_0_base", label = "b_0_base", value = 1000, min = 0.01, max = 5000
      ),
      sliderInput(
        inputId = "b_1_base", label = "b_1_base", value = 5000, min = 0.01, max = 10000
      ),
      sliderInput(
        inputId = "G_base", label = "G_base", value = 1000, min = 0.01, max = 5000
      ),
      sliderInput(
        inputId = "L_base", label = "L_base", value = 5000, min = 0.01, max = 10000
      ),
      sliderInput(
        inputId = "K_base", label = "K_base", value = 5000, min = 0.01, max = 10000
      ),
      sliderInput(
        inputId = "alpha", label = "alpha", value = 0.5, min = 0.01, max = 1
      ),
      tags$head(tags$style(
        type = 'text/css',
        'form.well { max-height: 600px; overflow-y: auto; }'
      ))
    ),
    mainPanel(
      plotOutput('graph', click = "plot_click"),
      fluidRow(
        column(width = 6,h4("Gleichgewichtswerte"), tableOutput('table'))
      ),
      tableOutput("info")
    )
  )
)
