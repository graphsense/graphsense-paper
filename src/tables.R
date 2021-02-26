suppressPackageStartupMessages({
  library("dplyr")
  library("readr")
  library("xtable")
})

dat <- read_csv("data_summary.csv")
table_dir <- "../tables"


dat1 <- dat %>%
        select(currency,
               date,
               no_blocks,
               no_transactions,
               no_addresses,
               no_tags) %>%
        mutate(date = format(date))
xt1 <- xtable(dat1,
              align = c("l",
                        "l",
                        rep("@{\\extracolsep{\\fill}}r", ncol(dat1) - 1)),
              digits = rep(0, ncol(dat1) + 1))
names(xt1) <- c("Currency",
                "Date",
                "#Blocks",
                "#Transactions",
                "#Addresses",
                "#Tags")
print(xt1,
      file = file.path(table_dir, "data_summary.tex"),
      floating = FALSE,
      latex.environments = "center",
      include.rownames = FALSE,
      comment = FALSE,
      booktabs = TRUE,
      tabular.environment = "tabular*",
      width = "\\textwidth",
      format.args = list(big.mark = ",", decimal.mark = "."))


dat2 <- dat %>%
        select(currency,
               no_addresses,
               no_address_relations,
               no_clusters,
               no_cluster_relations)
xt2 <- xtable(dat2,
              align = c("l",
                        "l",
                        rep("@{\\extracolsep{\\fill}}r", ncol(dat2) - 1)),
              digits = rep(0, ncol(dat2) + 1))
names(xt2) <- c("Currency", "#Nodes", "#Edges", "#Nodes", "#Edges")
print(xt2,
      file = file.path(table_dir, "graph_summary.tex"),
      floating = FALSE,
      latex.environments = "center",
      include.rownames = FALSE,
      comment = FALSE,
      hline.after = c(0, nrow(dat2)),
      booktabs = TRUE,
      tabular.environment = "tabular*",
      add.to.row = list(
        pos = list(-1, -1, -1),
        command = c("\\toprule\n",
                    paste("&",
                          "\\multicolumn{2}{c}{Address Graph} &",
                          "\\multicolumn{2}{c}{Entity Graph}\\\\\n"),
                    paste("\\cline{2-3}",
                          "\\cline{4-5}\n"))),
      width = "\\textwidth",
      format.args = list(big.mark = ",", decimal.mark = "."))
