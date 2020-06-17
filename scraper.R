require(rvest)
url <- "http://en.wikipedia.org/wiki/List_of_Michelin_starred_restaurants_in_New_York_City"
doc <- read_html(url)
col_names <- doc %>% html_nodes("#mw-content-text > table > tr:nth-child(1) > th") %>% html_text()
tbody <- doc %>% html_nodes("#mw-content-text > table > tr:not(:first-child)")

extract_tr <- function(tr){
  scope <- tr %>% html_children()
  c(scope[1:2] %>% html_text(),
    scope[3:length(scope)] %>% html_node("img") %>% html_attr("alt"))
}

res <- tbody %>% sapply(extract_tr)
res <- as.data.frame(t(res), stringsAsFactors = FALSE)
colnames(res) <- col_names