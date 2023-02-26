library(tidyverse)
library(haven)
TEDS_2016 <-
  read_stata("https://github.com/datageneration/home/blob/master/DataProgramming/data/TEDS_2016.dta?raw=true")

TEDS_2016 |> ggplot(aes(x=Tondu)) + geom_bar() + scale_x_continuous(breaks=seq(1,9, by = 1))

TEDS_2016 |> count(Tondu) |> ggplot(aes(x=Tondu,y=n)) + 
  geom_bar() + scale_x_continuous(breaks=seq(1,9, by = 1))

TEDS_2016 |> ggplot(aes(x=Tondu)) + 
  geom_histogram() + scale_x_continuous(breaks=seq(1,9, by = 1))

TEDS_2016 |> ggplot(aes(x=Tondu)) + 
  geom_histogram() + 
  scale_x_continuous(breaks=seq(1,9, by = 1), 
                    labels=c('Unification now', 'Status quo, unif. in future', 'Status quo, decide later', 
                             'Status quo forever', 'Status quo, indep. in future', 
                             'Blank', 'Blank', 'Independence now', 'No response')) + 
  stat_bin(binwidth=.5) +
  theme_gray() + 
  theme(axis.text.x = element_text(angle = 30, hjust = 0.5, vjust = 0.5))


Tondu_labs <-as.numeric(TEDS_2016$Tondu,labels=c("Unification now”, “Status quo, unif. in future”, “Status quo, decide later", "Status quo forever", "Status quo, indep. in future", "Independence now”, “No response"))
Tondu_labs

TEDS_2016 |> count(Tondu) |> ggplot(aes(x=Tondu,y=n)) + geom_point()


library(janeaustenr)
library(dplyr)
library(stringr)

tidy_books <- austen_books() %>%
  group_by(book) %>%
  mutate(
    linenumber = row_number(),
    chapter = cumsum(str_detect(text, 
                                regex("^chapter [\\divxlc]", 
                                      ignore_case = TRUE)))) %>%
  ungroup() %>%
  unnest_tokens(word, text)


## Combine the lm, plot and abline functions to create a one step regression fit plot function
regplot=function(x,y){
  fit=lm(y~x)
  plot(x,y)
  abline(fit,col="red")
}
attach(TEDS_2016)
regplot(Price,Sales)

