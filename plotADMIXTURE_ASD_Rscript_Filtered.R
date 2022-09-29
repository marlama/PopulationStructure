tbl0 = read.table(file="2escolhe_K2_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl0_2 <- tbl0[-grep('ID', colnames(tbl0))]
names(tbl0_2)
tbl0_3 <- tbl0_2[-grep('POP', colnames(tbl0_2))]
names(tbl0_3)
nrow <- nrow(tbl0)
nrow
tbl1 = read.table(file="2escolhe_K3_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl1_2 <- tbl1[-grep('ID', colnames(tbl1))]
names(tbl1_2)
tbl1_3 <- tbl1_2[-grep('POP', colnames(tbl1_2))]
names(tbl1_3)
nrow <- nrow(tbl1)
nrow
tbl2 = read.table(file="2escolhe_K4_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl2_2 <- tbl2[-grep('ID', colnames(tbl2))]
names(tbl2_2)
tbl2_3 <- tbl2_2[-grep('POP', colnames(tbl2_2))]
names(tbl2_3)
nrow <- nrow(tbl2)
nrow
tbl3 = read.table(file="2escolhe_K5_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl3_2 <- tbl3[-grep('ID', colnames(tbl3))]
names(tbl3_2)
tbl3_3 <- tbl3_2[-grep('POP', colnames(tbl3_2))]
names(tbl3_3)
nrow <- nrow(tbl3)
nrow
tbl4 = read.table(file="2escolhe_K6_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl4_2 <- tbl4[-grep('ID', colnames(tbl4))]
names(tbl4_2)
tbl4_3 <- tbl4_2[-grep('POP', colnames(tbl4_2))]
names(tbl4_3)
nrow <- nrow(tbl4)
nrow
tbl5 = read.table(file="2escolhe_K7_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl5_2 <- tbl5[-grep('ID', colnames(tbl5))]
names(tbl5_2)
tbl5_3 <- tbl5_2[-grep('POP', colnames(tbl5_2))]
names(tbl5_3)
nrow <- nrow(tbl5)
nrow
tbl6 = read.table(file="2escolhe_K8_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl6_2 <- tbl6[-grep('ID', colnames(tbl6))]
names(tbl6_2)
tbl6_3 <- tbl6_2[-grep('POP', colnames(tbl6_2))]
names(tbl6_3)
nrow <- nrow(tbl6)
nrow
tbl7 = read.table(file="2escolhe_K9_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl7_2 <- tbl7[-grep('ID', colnames(tbl7))]
names(tbl7_2)
tbl7_3 <- tbl7_2[-grep('POP', colnames(tbl7_2))]
names(tbl7_3)
nrow <- nrow(tbl7)
nrow

tbl8 = read.table(file="2escolhe_K10_Filtered.txt", header = T, sep = '\t', fill= TRUE)
tbl8_2 <- tbl8[-grep('ID', colnames(tbl8))]
names(tbl7_2)
tbl8_3 <- tbl8_2[-grep('POP', colnames(tbl8_2))]
names(tbl8_3)
nrow <- nrow(tbl8)
nrow

TABLE=read.table(file="CrossValidation.txt",head = F)
minplotX=3
maxplotX=10

minplotY=0.1357
maxplotY=0.1382

pdf("plotADMIXTURE_ASD_Filtered.pdf", width = 30, height = 20)
par(mfrow=c(10,1), mar = c(1,1,1,1)+0.1,mgp=c(3,3,2))
#barplot(t(as.matrix(tbl0_3)),yaxt='n',col = c("blue","violet"),beside=F,border=NA, xlim=c(0,(  nrow+300)))
#legend(x =     nrow+260, y = 0.8, c("K=2"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl1_3)),yaxt='n',col = c(names(tbl1_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=3"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl2_3)),yaxt='n',col = c(names(tbl2_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=4"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl3_3)),yaxt='n',col = c(names(tbl3_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=5"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl4_3)),yaxt='n',col = c(names(tbl4_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=6"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl5_3)),yaxt='n',col = c(names(tbl5_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=7"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl6_3)),yaxt='n',col = c(names(tbl6_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=8"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl7_3)),yaxt='n',col = c(names(tbl7_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=9"), bty = "n",cex=1.8)
barplot(t(as.matrix(tbl8_3)),yaxt='n',col = c(names(tbl8_3)),beside=F,border=NA, xlim=c(0,(  nrow+2100)))
legend(x =     nrow+2000, y = 0.8, c("K=10"), bty = "n",cex=1.8)


####CROSS VALIDATION
par(mar=c(1,60,1,60),mgp=c(2,2,0), xpd=TRUE)
plot(0,25,xaxt='n',xlab="",ylab="",main=" ",type="n",las = 1, cex.axis = 1.5, pch=20,xlim=c(minplotX,maxplotX),ylim=c(minplotY,maxplotY))
points(TABLE[,1],TABLE[,2],pch=1,col=1)  
axis(side=1,at=3:9, lwd=1, cex.axis=1.5)  
lines(TABLE[,1],TABLE[,2],xlim=c(3,9),ylim=c(minplotY,maxplotY),col=1,lwd=2)
mtext(side=1, text="K", line=5,cex=1.5)
mtext(side=2, text="Cross-validation\nError", line=9,cex=1.5)

dev.off()

