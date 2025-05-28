library(ggplot2)
library(tidyverse)
library(ggrepel)

df = read.csv("DEG_Analysis/whole_data.csv", header = T)
df$label = ifelse(df$q_value<0.05,"adjust P-val<0.01","adjust P-val>=0.01")

top10sig0 = filter(df,cluster=="0") %>% distinct(geneID,.keep_all = T) %>% top_n(10,abs(log2FC))
head(top10sig0)
top10sig1 = filter(df,cluster=="1") %>% distinct(geneID,.keep_all = T) %>% top_n(10,abs(log2FC))
head(top10sig1)
top10sig2 = filter(df,cluster=="2") %>% distinct(geneID,.keep_all = T) %>% top_n(10,abs(log2FC))
head(top10sig2)

top10sig = rbind(top10sig0,top10sig1,top10sig2)
df$size = case_when(!(df$geneID %in% top10sig$geneID)~ 1,
                    df$geneID %in% top10sig$geneID ~ 2)
dt <- filter(df,size==1)
head(dt)

p = ggplot()+
geom_jitter(data = dt,
aes(x = cluster, y = log2FC, color = label),
size = 0.85,
width =0.4)

p <- ggplot()+
geom_jitter(data = dt,
aes(x = cluster, y = log2FC, color = label),
size = 0.85,
width =0.4)+
geom_jitter(data = top10sig,
aes(x = cluster, y = log2FC, color = label),
size = 1,
width =0.4)

dfbar<-data.frame(x=c(0,1,2),
y=c(5,10,15,20,25,30))
dfbar1<-data.frame(x=c(0,1,2),
y=c(-30,-25,-20,-15,-10,-5))
p1 <- ggplot()+
geom_col(data = dfbar,
mapping = aes(x = x,y = y),
fill = "#dcdcdc",alpha = 0.6)+
geom_col(data = dfbar1,
mapping = aes(x = x,y = y),
fill = "#dcdcdc",alpha = 0.6)

p2 <- ggplot()+
geom_col(data = dfbar,
mapping = aes(x = x,y = y),
fill = "#dcdcdc",alpha = 0.6)+
geom_col(data = dfbar1,
mapping = aes(x = x,y = y),
fill = "#dcdcdc",alpha = 0.6)+
geom_jitter(data = dt,
aes(x = cluster, y = log2FC, color = label),
size = 0.85,
width =0.4)+
geom_jitter(data = top10sig,
aes(x = cluster, y = log2FC, color = label),
size = 1,
width =0.4)
