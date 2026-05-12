install.packages(c("tidyverse", "ggplot2", "patchwork", "viridis"))
library(tidyverse)
library(ggplot2)
library(patchwork) 
library(viridis)   

#loading in data using github link, can replace with csv if needed
url <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-04-01/pokemon_df.csv"
pokemon_data <- read_csv(url)

#Data cleaning & organization
clean_pokemon <- pokemon_data %>%
  select(pokemon, type_1, hp, attack, defense, speed, height, weight) %>%
  drop_na() %>%
  mutate(total_stats = hp + attack + defense + speed)

#Descriptive stats 
stats_table <- clean_pokemon %>%
  filter(type_1 %in% top_types) %>%
  group_by(type_1) %>%
  summarise(
    Count = n(),
    Mean_Speed = mean(speed),
    SD_Speed = sd(speed),
    Mean_Attack = mean(attack),
    SD_Attack = sd(attack),
    Mean_Total = mean(total_stats)
  ) %>%
  arrange(desc(Mean_Total))

print("--- Descriptive Statistics: Pokémon Profiles ---")
print(stats_table)

#Visualization 1: group differences (Boxplot)
top_types <- clean_pokemon %>% 
  group_by(type_1) %>% 
  tally(sort = TRUE) %>% 
  head(8) %>% 
  pull(type_1)

p1 <- ggplot(clean_pokemon %>% filter(type_1 %in% top_types), 
             aes(x = reorder(type_1, speed), y = speed, fill = type_1)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Speed by Type", x = "", y = "Speed") +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1) # This angles the text
  )

#Visualization 2: correlation (scatter plot)
p2 <- ggplot(clean_pokemon, aes(x = log(weight), y = speed)) +
  geom_point(alpha = 0.3, color = "midnightblue") +
  geom_smooth(method = "lm", color = "red") +
  theme_minimal() +
  labs(title = "Weight vs. Speed", subtitle = "Log-transformed weight", x = "Weight", y = "Speed") +
  theme(
    axis.title.x = element_text(margin = margin(t = -5)) 
  )

#Visualization 3: Density plot (Distribution)
p3 <- clean_pokemon %>%
  filter(type_1 %in% c("psychic", "fighting")) %>%
  ggplot(aes(x = attack, fill = type_1)) +
  geom_density(alpha = 0.5) +
  theme_minimal() +
  scale_fill_manual(values = c("fighting" = "#C22E28", "psychic" = "#F85888")) +
  labs(title = "Attack Distribution", subtitle = "Psychic vs. Fighting", x = "Attack Stat", fill = "Type")

#Visualization 4: Heatmap (Correlation Matrix)
stats_corr <- clean_pokemon %>%
  select(hp, attack, defense, speed) %>%
  cor() %>%
  as.data.frame() %>%
  rownames_to_column(var = "var1") %>%
  pivot_longer(-var1, names_to = "var2", values_to = "correlation")

p4 <- ggplot(stats_corr, aes(x = var1, y = var2, fill = correlation)) +
  geom_tile() +
  scale_fill_viridis() +
  theme_minimal() +
  labs(title = "Stat Correlation Matrix", x = "", y = "") +
  theme(
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1) # This angles the text
  )

#to put all plots on one "page" together
final_plot <- (p1 | p2) / (p3 | p4)
print(final_plot)

#Statistical Test: Pearson correlation between attack and defense
cor_test <- cor.test(clean_pokemon$attack, clean_pokemon$defense)
print(cor_test)