library(readr)
library(ggplot2)
library(dplyr)
library(xtable)

setwd("~/Desktop/UPC/StochasticProgramming/Project")

data = read_table2("solucion.txt", 
                    col_names = FALSE)

print(xtable(t(data.frame(data %>% filter(X1 == "nCUT") %>% dplyr::select(X3),
                        data %>% filter(X1 == "x") %>% dplyr::select(X3))),
             digits = 2, label = "tab:solution.",
             caption = "Evolution of variable through iterations."),
      caption.placement = "top", comment = FALSE, include.rownames = TRUE,
      include.colnames = FALSE)

data = data %>% dplyr::select(-X2)
data = data.frame(Cut = data %>% filter(X1 == "nCUT") %>% dplyr::select(X3),
                  Cost = data %>% filter(X1 == "z") %>% dplyr::select(X3),
                  Dual_cost = data %>% filter(X1 == "dual_cost") %>% dplyr::select(X3),
                  x = data %>% filter(X1 == "x") %>% dplyr::select(X3))
colnames(data) = c("Cut", "Primal", "Dual", "x")

data %>% gather(key = "Function", value = "Cost", -Cut, -x) %>%
  ggplot() + geom_line(aes(x = Cut, y = Cost, col = Function)) +
  theme_bw() + theme(text=element_text(size=15),legend.position="bottom") +
        labs(title="",x="Iteration", y = "Value") + labs(colour = "")

ggsave("Benders.png", width = 5, height = 4)
