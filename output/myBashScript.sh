#!/bin/bash
R --slave << EOF
x <- rnorm(100)
mean(x)
png('my_plot.png', height = 400, width = 800)
par(mfrow=c(1,2))
hist(x)
qqnorm(x)
dev.off()
EOF
