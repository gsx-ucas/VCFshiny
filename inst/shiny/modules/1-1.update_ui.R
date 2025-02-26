tabItem(
  tabName = "datainput",
  fluidPage(
      box(
        title = "Data Input", width = 3, status = "info", collapsible = T,
        selectInput(
          inputId = "Species",
          label = "Choose your Species:",
          c("Human" = "hg38",
            "Mouse" = "mm10",
            "Rat" = "rn6",
            "Sus scrofa" ="susScr11",
            "Dog" = "canFam4",
            "others" = "others"),
          selected = "Human",
          multiple = F
        ),
        uiOutput(outputId = "chrom_data"),
        radioGroupButtons("use_example", "Use example data ?", c("No" = "FALSE","Yes" = "TRUE"),
                          justified = T, checkIcon = list(yes = icon("ok",lib = "glyphicon"))),
        fileInput(

          inputId = "input_file",label = "Upload your data:",
          multiple = F, accept = c("gz/zip")
        ),
        selectInput("separator", "TXT Separator:",
                    c("Tab" = "\t",
                      "Comma" = ",",
                      "Semicolon" = ";",
                      "Space" = " "),
                    selected = "Tab"),
        actionButton("sample_data","Upload Data !", width = "100%", class = "btn-upload")
      ),
      box(
        title = "Data Display", width = 9, status = "primary", collapsible = T,
        uiOutput("sample_id"),
        shinycssloaders::withSpinner(DT::dataTableOutput("sample"))
      ),
      column(
          12,
          wellPanel(
          tags$h3("Explanation of input data and example data !"),
          tags$h4("Requirements for input data:"),
          p("Before using, first read the Introduction to understand the file requirements named format, and then confirm that your input file is WGS analysis generated file, can be TXT file, VCF file or VCF. Gz file, and ensure that the input file is stored all data compressed folder"),
          tags$li("Requirements for VCF input data:"),
          p("The Variant Call Format (VCF) is used to record gene sequence variations.
             It is also the first file format to be understood for genome population correlation analysis.
             The file is divided into two main parts: the Header comment section, which begins with #, and the body section.
            "),
          tags$li("Requirements for TXT input data:"),
          p("TXT files are one of several output formats annotated by Annovar, which is able to analyze genetic variations in various genomes using the latest data.
             Since the input data VCF file of Annovar software only contains the starting position of the mutation, it is necessary to adjust the input data before using, and add the end position of the mutation after the actual position of the mutation.
             Gene-based annotations reveal variant's direct relationship with known genes and its functional impact, while region-based annotations reveal Variant's relationship with specific segments of different genomes"),
          tags$h4("The source of example data:"),
          p("Sample data are reported from AGBE, published in Nucleic Acids Res:A dual deaminase-mediated base editor by fusing CGBE with ABE for creating a saturated mutant population with multiple editing patterns.
            The author has participated in the analysis of the relevant data in the paper, so three of the five data samples are selected as example data.")
        )
      )
  )
)
