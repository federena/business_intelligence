
library(querychat)
library(shiny)
library(bslib)

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat(
  con, "listings",
  client   = client,
  tools    = c("filter", "query", "visualize"),  # visualize: charts in the chat (needs ggsql)
  greeting = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the twin cities.",
  data_description = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)


ui = page_sidebar(
  title   = "Midwest Airbnb Explorer",
  theme   = bs_theme(primary = "#C3142D",
                     base_font = font_google("Lato")),
  sidebar = qc$sidebar(width = 350),
  card(card_header(textOutput("title")),
       DT::DTOutput("table")),
  accordion(open = FALSE,
            accordion_panel("SQL", verbatimTextOutput("sql")),
            accordion_panel("This app uses 14,887 Airbnb listings from inside Airbnb. The data includes listings from Chicago(July 20, 2026), Columbus(July 23, 2026) and the Twin Cities(July 21,2026).", "Airbnb Listings; built by Nathan Federer"))
)

server = function(input, output, session) {
  vals = qc$server()
  output$title = renderText(vals$title() %||% "All postings")
  output$table = DT::renderDT(vals$df(),
                              options = list(pageLength = 10))
  output$sql   = renderText(vals$sql() %||%
                              "SELECT * FROM listings")
}

shinyApp(ui, server)





