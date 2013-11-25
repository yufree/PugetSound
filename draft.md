Bootstrap重采样技术在环境污染调查中的应用
========================================================

环境污染调查所得到的数据在可靠性上容易被质疑，这种质疑一方面来自于小样本数据中异常值的解释而另一方面则来自于数据分析所采用模型背后的假设。Bootstrap重采样技术在统计学领域常用来解决小样本无分布假设问题，具有良好的鲁棒性与预测性能。通过将样本看作总体进行有放回的多次重采样并进行模拟求解，在不清楚样本所符合的分布条件下可以给出可靠性更高的中位数95%置信区间估计值，这使得对现实环境污染物污染水平的描述更准确。此外，结合局部加权回归散点平滑法（LOESS算法）与可视化技术，采用Bootstrap重采样技术可更好的讨论环境变量间的关系，挖掘数据背后的规律。通过对EPA公开的普吉特海湾多氯联苯（PCBs）调查数据的Bootstrap模拟分析发现：PCBs浓度随深度增加而增加的线性模型受采样点设置的影响而并不稳健，深度0~200米PCBs浓度随深度增加而增加，在300米附近浓度呈稳定趋势，而深度400米之后的浓度波动较大。

数据分析


```r
rawdata <- read.csv("2008_BOLD_Survey_of_Puget_Sound_Levels_for_PCB_Congeners_Raw_Data.csv")
# 查看列名 colnames(rawdata) 观察总浓度与深度关系
plot(rawdata$Depth..feet., rawdata$Total.PCBs..0.DL..pg.g)
```

![plot of chunk rawdata](figure/rawdata1.png) 

```r
# bootstrap重采样
Total.PCBs <- rawdata$Total.PCBs..0.DL..pg.g
Depth <- rawdata$Depth..feet.
data <- cbind(Total.PCBs, Depth)
data <- data.frame(data)
plot(data)
```

![plot of chunk rawdata](figure/rawdata2.png) 

```r
b <- c(0)
c <- c(0)

# 总体取样30进行区间估计
a <- sample(75, 30)
subdatatest <- data[a, ]

for (i in 1:1000) {
    a <- sample(30, replace = T)
    sub <- subdatatest[a, ]
    b[i] <- mean(sub$Total.PCBs)
    c[i] <- median(sub$Total.PCBs)
}

cib <- quantile(b, probs = c(0.025, 0.975))
cic <- quantile(c, probs = c(0.025, 0.975))
cip <- quantile(data$Total.PCBs, probs = c(0.025, 0.975))
cis <- quantile(subdatatest$Total.PCBs, probs = c(0.025, 0.975))

# 绘制区间估计图
hist(data$Total.PCBs, breaks = 20)
abline(v = cip, col = "red", lwd = 2)
abline(v = cic, col = "green", lwd = 2)
abline(v = cis, col = "blue", lwd = 2)
abline(v = mean(data$Total.PCBs), col = "black")
abline(v = median(data$Total.PCBs), col = "yellow", , lwd = 3)
```

![plot of chunk rawdata](figure/rawdata3.png) 

```r

# 与深度关系

fit <- lm(data$Total.PCBs ~ data$Depth)
plot(data$Total.PCBs ~ data$Depth)
lines(data$Depth, fit$fitted)
```

![plot of chunk rawdata](figure/rawdata4.png) 

```r

# p值0.001525 r^2 0.1294

fit2 <- loess(data$Total.PCBs ~ data$Depth)
plot(data$Total.PCBs ~ data$Depth)
lines(lowess(data$Depth, fit2$fitted))
```

![plot of chunk rawdata](figure/rawdata5.png) 

```r

# 局部加权回归散点平滑法

plot(data$Total.PCBs ~ data$Depth, pch = 20, col = rgb(0, 0, 0, 0.5))
for (i in 1:300) {
    idx = sample(75, replace = TRUE)
    lines(lowess(data$Depth[idx], data$Total.PCBs[idx]), col = rgb(0, 0, 0, 
        0.05), lwd = 1.5)
}
lines(data$Depth, fit$fitted)
```

![plot of chunk rawdata](figure/rawdata6.png) 


