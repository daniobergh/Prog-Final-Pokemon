# Prog-Final-Pokémon
The objective of this project is to analyze the relationship between Pokémon types, physical characteristics (weight), and combat statistics. This project utilizes the April 2025 [TidyTuesday](data/2025/2025-04-01/pokemon_df.csv) Pokémon dataset.

This analysis demonstrates:
1. *Group Differences:* Box plot and distribution plot to compare trait distributions across species categories
2. *Correlational Research:* Examines the relationship between physical constraints and performance metrics.
3. *Descriptive & Inferential Statistics:* Generates group means, standard deviations, and Pearson's correlation coefficients. 

## Repository Contents
- `Pokemon_Analysis.R`: The primary script containing data cleaning, statistical testing, and visualization code.
- `Pokemon_Plots.pdf`: Plot visualizations from the analysis script for reference. 
- `pokemon_df.csv`: CSV file containing primary dataframe from TidyTuesday repository.
- `README.md`: Project documentation and summary.

## How to Run
1. Open RStudio (version 4.0+).
2. Dependencies: Ensure the `tidyverse`, `ggplot2`, `patchwork`, and `viridis` packages are installed via `install.packages()`.
3. Run the `Pokemon_ Analysis.R` script. The script fetches data directly from the official GitHub source. The `pokemon_df.csv` file is available for download and can be read in as the data frame if preferred. 

## Results
*Visualization Highlights*
1. **Speed by Type (Boxplot):** Identifies which categories possess the highest "reaction time" equivalents.
2. **Weight vs. Speed (Scatter):** A regression analysis checking for physical constraints on speed.
3. **Attack Distribution (Density):** A direct comparison of trait variance between "Psychic" and "Fighting" types.
4. **Correlation Matrix (Heatmap):** An overview of how defensive and offensive traits co-vary.

*Descriptive & Inferential Statistics*
- **Descriptive Profile:** A summary of the top 8 most frequent Pokémon types revealed significant variance in traits:
1. Speed: Electric-type Pokémon exhibited the highest average speed (*M* = 87.2, *SD* = 24.0), while Grass-types were the slowest among the top groups (*M* = 60.3).
2. Overall Power: Rock-type Pokémon showed the highest overall composite score (*M* = 314), despite having lower average speed than many other groups.

*Statistical Analysis:*
1. Combat Trade-offs: Pearson's product-moment correlation confirmed a **significant** positive relationship between Attack and Defense stats (*r* = 0.44, *p* < .001). This suggests that offensive and defensive capabilities tend to scale together within the ecosystem.
2. Physical Constraints: Scatter plot analysis of Weight vs. Speed (log-transformed) confirms a negative trend, supporting the hypothesis that increased mass is generally associated with decreased speed.
3. Group Comparison: The density plots revealed that "Fighting" types have a more skewed distribution toward higher Attack values compared to "Psychic" types.
