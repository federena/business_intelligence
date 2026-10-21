penguins = readr::read_csv("https://raw.githubusercontent.com/fmegahed/isa401/main/data/penguin_captures.csv")


d <- read.csv('penguin_captures.csv')
print(names(d))
print(table(d$species, useNA='ifany'))
print(nrow(d))


library(jsonlite)
library(dplyr)
library(purrr)

# Read the campus JSON file
campus_data <- fromJSON("https://isa401-find-your-seat.vercel.app/campus.json")

# Filter for Farmer School of Business and extract floor 1 sections
fsb_data <- campus_data$buildings %>%
  filter(name == "Farmer School of Business")

# Unnest floors and rooms to count total class sections on floor 1
floor1_rooms <- fsb_data$floors[[1]] %>%
  filter(floor == 1)

total_sections <- sum(sapply(floor1_rooms$rooms[[1]]$sections, length))
print(total_sections)




library(jsonlite)

campus <- fromJSON("https://isa401-find-your-seat.vercel.app/campus.json")

farming_school <- campus$buildings[
  vapply(campus$buildings, function(b) b$name == "Farmer School of Business", logical(1))
][[1]]

floor_1 <- farming_school$floors[
  vapply(farming_school$floors, function(f) as.character(f$floor) == "1", logical(1))
][[1]]

sum(vapply(floor_1$rooms, function(room) {
  length(room$sections)
}, integer(1)))


campus$Farmer$floors[["1"]]$sections






library(httr2)

resp <- request("https://data.cincinnati-oh.gov/resource/rvmt-pkmq.json") |>
  req_url_query(
    `$select` = "count(*) AS n",
    `$where` = "crashdate >= '2026-07-01T00:00:00' AND crashdate < '2026-08-01T00:00:00'"
  ) |>
  req_perform() |>
  resp_body_json()

as.integer(resp[[1]]$n)



library(rvest)

url <- "https://isa401-salvage.vercel.app/exam/registry?start=1"

page <- read_html(url)

# Inspect the page's HTML structure
page |> html_elements("a") |> html_attr("href")
page |> html_elements("table") |> html_text2()







library(rvest)

starts <- c(1, 41, 81, 121, 161, 201, 241, 281, 321)

classes <- unlist(lapply(starts, function(s) {
  url <- paste0("https://isa401-salvage.vercel.app/exam/registry?start=", s)
  page <- read_html(url)
  
  page |>
    html_elements("table tbody tr td:nth-child(2)") |>
    html_text2()
}))



sum(classes == ".Dreadnought")


page <- read_html("https://isa401-salvage.vercel.app/exam/registry?start=1")

page |> 
  html_elements("table") |> 
  html_text2()


page |> html_elements("body") |> html_text2()

#Starts here
starts <- seq(1, 321, by = 40)

classes <- unlist(lapply(starts, function(s) {
  page <- read_html(
    paste0("https://isa401-salvage.vercel.app/exam/registry?start=", s)
  )
  
  texts <- html_text2(html_elements(page, "body"))
  unlist(regmatches(texts, gregexpr("Class [A-Za-z]+", texts)))
}))
length(classes)


texts <- html_text2(html_elements(page, "body"))
classes <- unlist(regmatches(texts, gregexpr("Class [A-Za-z]+", texts)))

classes


sum(classes == "Class Dreadnought")







starts <- seq(1, 321, by = 40)

classes <- unlist(lapply(starts, function(s) {
  page <- read_html(
    paste0("https://isa401-salvage.vercel.app/exam/registry?start=", s)
  )
  
  texts <- html_text2(html_elements(page, "body"))
  unlist(regmatches(texts, gregexpr("Class [A-Za-z]+", texts)))
}))





ncse_tbl = readr::read_csv("https://raw.githubusercontent.com/fmegahed/isa401/main/data/ncse_endowment_us_and_canada_2025.csv")
dplyr::glimpse(ncse_tbl)


jobs |>
  dplyr::group_by(location_state) |>
  dplyr::summarise(postings = dplyr::n())

## Q11
library(ellmer)

# 1. Create a chat object
chat <- ellmer::chat_openai(
  model = "gpt-5.6-luna"
)

# 2. Define the Airbnb listing description
description <- "This one of a kind, turn of the century, fully restored mansion is just waiting for you to come and enjoy the vast amenities this house offers! This historic Victorian Mansion was built in the last 1800's and has been fully restored and updated with one thing in mind--luxury! We boast a slate pool table, 10 person hot tub, a custom made fire table, a built in giant projector screen for streaming, arcade games, and much much more! We comfortably sleep 19 guests with 9 dedicated bedrooms."

# 3. Define the structured output schema
schema <- ellmer::type_object(
  property_type = ellmer::type_string(),
  max_guests = ellmer::type_integer(),
  num_bedrooms = ellmer::type_integer(),
  key_amenities = ellmer::type_string(
    "List key amenities separated by |"
  )
)

# 4. Extract structured information
result <- chat$chat_structured(
  description,
  type = schema
)

# 5. Display results
print(result)


#


