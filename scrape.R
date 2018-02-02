library(tidyverse)
library(stringr)
library(rvest)
library(dobtools)
library(tidytext)

# Safe reading -- don't error if we've got a bad URL, just tell us, don't exit the loop
read_url <- function(url) {
  page <- read_html(url)
}

## Our course homepage
# url <- read_url("https://github.com/jennybc/what-they-forgot")
# text <- url %>% html_nodes(".entry-content") %>% html_text()


# View source -> find this url 
lobby_url <- read_url("https://gitter.im/what-they-forgot/Lobby/~chat")
  
text <- lobby_url %>% html_nodes(".js-chat-item-text") %>% html_text()

text_tidied <- text %>% as_tibble() %>% 
  unnest_tokens(word, value) %>% 
  anti_join(stop_words) %>%       # remove stopwords
  filter(! grepl("\\d+", word))   # remove numbers

# Add counts
text_tidied_counts <- text_tidied %>% count(word, sort = TRUE)

text_tidied_counts %>% bind_tf_idf(words, text_tidied_counts, n)


names <- lobby_url %>% html_nodes(".js-chat-item-from") %>% html_text()

library(testthat)
expect_equal(length(names), length(text))

handles <- names %>% str_extract_all("@[a-zA-Z]+") %>% as_vector()

names[which(handles %in% names)]



