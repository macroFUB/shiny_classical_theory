library(shiny)
library(ggplot2)

server <- function(input, output){
  dat <- reactive({
    r<-seq(0,input$b_0/(input$b_1)+0.05,0.001)

    I<-input$b_0_base-input$b_1_base*r
    Y<-(input$K_base)^(input$alpha) * (input$L_base)^(1-input$alpha)
    S<-Y-input$c_0_base-input$c_1_base*(Y-input$T_base)-input$G_base
    r_star<-(input$b_0_base-S)/input$b_1_base
    I_star<-input$b_0_base-input$b_1_base*r_star

    I_2<-input$b_0-input$b_1*r
    Y_2<-(input$K)^(input$alpha) * (input$L)^(1-input$alpha)
    S_2<-Y_2-input$c_0-input$c_1*(Y-input$T)-input$G
    r_star_2<-(input$b_0-S_2)/input$b_1
    I_star_2<-input$b_0-input$b_1*r_star_2


    data_table <- data.frame(r,I,Y,S,I_2,Y_2,S_2,r_star,I_star,r_star_2,I_star_2)
    data_table
  })
  output$graph <- renderPlot({
    ggplot(data = dat(), aes(x = I, y=r)) + coord_cartesian(xlim=c(0, 1500))+ labs(x="I, S")+
      geom_line(aes(x = I_2, colour = "I2"), size = 1)+
      geom_line(aes(x = S_2, colour = "S2"), size = 1)+
      geom_line(aes(x = I, colour = "I1"), size = 1)+
      geom_line(aes(x = S, colour = "S1"), size = 1)+
      geom_segment(
        aes(x = I_star_2, y = 0, xend = I_star_2, yend = r_star_2),
        linetype = "dashed", colour = "black"
      ) +
      geom_segment(
        aes(x = 0, y = r_star_2, xend = I_star_2, yend = r_star_2),
        linetype = "dashed", colour = "black"
      ) +
      geom_point(aes(x=I_star_2, y=r_star_2), size=2)+
      geom_segment(
        aes(x = I_star, y = 0, xend = I_star, yend = r_star),
        linetype = "dashed", colour = "black"
      ) +
      geom_segment(
        aes(x = 0, y = r_star, xend = I_star, yend = r_star),
        linetype = "dashed", colour = "black"
      ) +
      geom_point(aes(x=I_star, y=r_star), size=2)
      })
  output$table <- renderTable({
    tmp <- dat()
    equil <- data.frame(
      "Y" = tmp$Y,
      "S" = tmp$S,
      "I_star" = tmp$I_star,
      "r_star" = tmp$r_star,
      "Y_2"=tmp$Y_2,
      "S_2"=tmp$S_2,
      "I_star_2" = tmp$I_star_2,
      "r_star_2" = tmp$r_star_2
    )[1, ]
  })
}
