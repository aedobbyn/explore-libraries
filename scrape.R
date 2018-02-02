library(tidyverse)
library(stringr)
library(rvest)
library(dobtools)
library(tidytext)

# Safe reading -- don't error if we've got a bad URL, just tell us, don't exit the loop
read_url <- function(url) {
  page <- read_html(url)
}

lobby_url <- read_url("https://gitter.im/what-they-forgot/Lobby/~chat#initial")
  
get_recipe_content <- function(page) {
  recipe <- page %>% 
    html_nodes(".checkList__line") %>% 
    html_text() %>% 
    str_replace_all("ADVERTISEMENT", "") %>% 
    str_replace_all("\n", "") %>% 
    str_replace_all("\r", "") %>% 
    str_replace_all("Add all ingredients to list", "")
  return(recipe)
}

lobby_url %>% html_nodes(".chat-item__details") %>% html_table()
lobby_url %>% html_nodes(".div.chat-item__text.js-chat-item-text") %>% html_text()
lobby_url %>% html_nodes(".js-chat-item-text") %>% html_text()


# url <- read_url("https://github.com/jennybc/what-they-forgot")
# text <- url %>% html_nodes(".entry-content") %>% html_text()

text_tidied <- text %>% as_tibble() %>% unnest_tokens(words, value)

text_tidied_counts <- text_tidied %>% count(words)

text_tidied_counts %>% bind_tf_idf(words, text_tidied_counts, n)
