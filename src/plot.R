suppressPackageStartupMessages({
  library("dplyr")
  library("ggplot2")
  library("scales")
  library("readr")
})

dat <- read_csv("address_rel_partition_size.csv") %>%
       mutate(currency = factor(currency,
                                levels = c("BTC", "BCH", "LTC", "ZEC"))) %>%
       group_by(currency) %>%
       mutate(index = seq(1, n())) %>%
       group_by(currency) %>%
       slice(1:50)

library("tikzDevice")
options(tikzLatexPackages = c(getOption("tikzLatexPackages"),
                              "\\usepackage{amsmath}"))
options(tikzDocumentDeclaration = "\\documentclass[crop,tikz]{standalone}")
options(tikzDefaultEngine = "pdftex")
options(tikzLatex = "/usr/bin/pdflatex")

p <- ggplot(data = dat) +
     geom_col(aes(x = index, y = count)) +
     facet_wrap(~ currency, scales = "free_y") +
     labs(x = "Index", y = "Partition Size") +
     scale_y_continuous(labels = comma) +
     theme_bw()
tikz("../figures/addr_rel_partition_size_distribution.tex",
     width = 6, height = 4, standAlone = FALSE,
     timestamp = FALSE)
print(p)
dev.off()
