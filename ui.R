shinyUI(pageWithSidebar(
  headerPanel("PugetSound PCBs data analysis"),
  sidebarPanel(
    helpText("Select data and parameters to build a bootstrap lowess regression model"),
    sliderInput("rangeN", 
                label = "Latitude Range:", 
                min = 47.12105, 
                max = 48.86602, 
                value = c(47.5,48.5)),
    sliderInput("rangeW", 
                label = "Longitude Range:", 
                min = -123.3807, 
                max = -122.2958, 
                value = c(-123.15,-122.5)),
    selectInput("var", 
                label = "Choose a variable to build the model",
                choices = c("depth","TOC","TF"),
                selected = "depth"),
    sliderInput("integer", 
                label = "Bootstrap times:", 
                min = 100, 
                max = 1000, 
                value = 500),
    actionButton("get", "GO"),
    br(),
    br(),
    helpText("Sample Maps"),
    img(src = "sample.png",height = 50, width = 500),
    br(),
    br(),
    img(src = "bigorb.png", height = 50, width = 50),
    "shiny is a product of ", 
    span("RStudio", style = "color:blue"),
    br(),
    img(src = "institution-logo-rcees.jpg", height = 50, width = 50),
    "This app is created by ", 
    span("yufree", style = "color:blue")
  ),
  mainPanel(
    p("Due to source pollution outfalls and legacy manufacturing sites, the
sediment in the Puget Sound were sampled in the summer of 2008 to get the 
concetration of a high-profile bioaccumulative contaminant, namely PCBs. 
This app used those data from U.S. EPA's website."),
    br(),
    p("The data were subset with each samples's longitude, latitude, sampling 
      depth, the amount of organic material (versus mineral) within that 
      sediment sample(TOC), The total silt and clay fraction (less than 230 
      microns in size)  within that sediment sample(TF) and the concentration of
      total PCBs(PCBs). There are 75 samples in this data set."),
    br(),
    p("This app is focused on the relationship between the concentration of
      total PCBs and the depth, TOC or TF. Bootstrap lowess regression model 
      was employed to show the relationship betweem PCBs and certain variables.
      By a overlay of light line the figure will show the data's quality and 
      “confidence interval” of the LOWESS fit. This will help researcher to 
      build a more specific model or find some thresholds in an intuitional 
      figure. In this app, the samples could be selected by latitude and 
      longitude range and user could explor the relationship between depth, TOC 
      and TF. Also the bootstrap times could be selected from 100 to 1000.JUST 
      click GO to begin you explore."),
    plotOutput("plot"),
    h5('Data were got from this webpages :'),a('http://www.epa.gov/pugetsound/bold.html')
    )
))