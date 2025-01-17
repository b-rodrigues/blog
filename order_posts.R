library(stringr)
html <- readLines("_site/index.html")

links <- grep("<a href=.*posts.*\\d{4}", html, value = TRUE)

links_positions <- grepl("<a href=.*posts.*\\d{4}", html)

# Extract the dates from the href attributes
dates <- as.Date(str_match(links, "\\d{4}-\\d{2}-\\d{2}")[, 1])

# Sort the links by descending date
sorted_links <- links[order(dates, decreasing = TRUE)]

counter <- 1
for (i in seq_along(html)) {
  if (links_positions[i]) {
    html[i] <- sorted_links[counter]
    counter <- counter + 1
  }
}

writeLines(html, "_site/index.html")
