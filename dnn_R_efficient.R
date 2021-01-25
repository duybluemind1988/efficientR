install.packages("microbenchmark")

library(microbenchmark)
df = data.frame(v = 1:4, name = letters[1:4])
df
microbenchmark(df[3, 2], df[3, "name"], df$name[3])

df[3, 2]
df[3, "name"]
df$name[3]

library("profvis")
profvis(expr = {

  # Stage 1: load packages
  # library("rnoaa") # not necessary as data pre-saved
  library("ggplot2")

  # Stage 2: load and process data
  out = readRDS("extdata/out-ice.Rds")
  df = dplyr::rbind_all(out, id = "Year")

  # Stage 3: visualise output
  ggplot(df, aes(long, lat, group = paste(group, Year))) +
    geom_path(aes(colour = Year))
  ggsave("figures/icesheet-test.png")
}, interval = 0.01, prof_output = "ice-prof")
