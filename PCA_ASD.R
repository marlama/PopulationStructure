###Uma vez so!

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("SNPRelate")

install.packages("ggplot2")
install.packages("ggfortify")
install.packages("scales")                                         # Install scales package
library("scales")   
#################################################################

library(SNPRelate)

path.samples<-"C:/Users/M Mendes de Aquino/OneDrive - SickKids/Desktop/"

name.file<-"ASD_CaseControl_ReferenceData_LD0.4_Unrelated"


fam.file = read.table(paste0(path.samples,name.file,".fam"), stringsAsFactors = F)
colnames(fam.file) = c("FamilyID", "IndividualID", "PaternalID", "MaternalID", "Sex", "Phenotype")

popGroups = read.table(paste0(path.samples,"ASD_CaseControl_Reference_CorrespondentList.txt"), col.names=c("IndividualID", "PopGroup"), stringsAsFactors = F)

# acrescenta os dados das populações 
SNV.pop.ann = merge(fam.file, popGroups, by.x = "IndividualID", by.y = "IndividualID",
                    all.x = TRUE)

bed.fn <- paste0(path.samples,name.file,".bed")
bim.fn <- paste0(path.samples,name.file,".bim")
fam.fn <- paste0(path.samples,name.file,".fam")

snpgdsBED2GDS(bed.fn, fam.fn, bim.fn,"test.gds")
snpgdsSummary("test.gds")

(genofile <- snpgdsOpen("test.gds"))

snpset <- snpgdsLDpruning(genofile, ld.threshold=0.4) 
snpset.id <- unlist(unname(snpset))
head(snpset.id)

pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=4)

# variance proportion (%)

pc.percent <- pca$varprop*100
head(round(pc.percent, 2))
tab <- data.frame(sample.id = pca$sample.id,
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2= pca$eigenvect[,2],
                  EV3 = pca$eigenvect[,3],
                  EV4 = pca$eigenvect[,4],
                  EV5 = pca$eigenvect[,5],
                  stringsAsFactors = FALSE)

tab <- merge(tab, popGroups, by.x = "sample.id", by.y = "IndividualID", all.x = T)

tab = tab[,c("sample.id", "EV1", "EV2", "EV3", "EV4", "EV5", "PopGroup")]


color <- data.frame(Pop = c("African","EastAsia","European","NativeAmerican","SouthAsia","SSC","MSSNG"),
                    Color = c("blue","violet","red3","green4","darkorange1","gray70","gray0"),
                    alpha = c(1,1,1,1,1,0.5,0.5),
                    Sym=c(19,19,19,19,19,15,15))
color$Color = as.character(color$Color)


tab <- merge(tab, color, alpha, by.x = "PopGroup", by.y = "Pop", all.x = T)

write.table(tab,"/Users/M Mendes de Aquino/OneDrive - SickKids/Desktop/ASDCaseControl_pca.results.txt",
            col.names=T,row.names=T)

#tbl1 = read.table(file="/home/victor/LNCC/Exomes_zika/33_exomes/population_structure/admixture_results/toplot2/2escolhe/cases_controls_admixture.txt", header = T, sep = '\t', fill= TRUE)
#tbl1_2 <- tbl1[-grep('ID', colnames(tbl1))]

#tbl1_3 <- tbl1_2[-grep('POP', colnames(tbl1_2))]

#names(tbl1_3)
#nrow <- nrow(tbl1_3)
#nrow


pdf("/Users/M Mendes de Aquino/OneDrive - SickKids/Desktop/ASDCaseControl_PCA1_PCA3.pdf", width = 20, height = 15)

layout(matrix(c(1,1,1,2,2,2,3,3,3), byrow = TRUE, nrow = 3, ncol = 3),heights=c(3,1,1))

####################### PCA PLOT #######################
par(mar=c(8, 35, 6, 35),mgp=c(3.5,1,0), xpd=TRUE)
plot(tab$EV1, tab$EV3, main = "PCA ASD Case Control", col= tab$Color, 
     xlab = "PC1(4.13)", ylab = "PC3(0.56)",
     pch = tab$Sym, cex=1,cex.lab=1,cex.main=1.7, frame = FALSE)
box(lwd = 1)


legend("topright",inset=c(-0.37,-0.1),	pch = c(0,19,19,19,19,19,0,0,15,15),cex=1.6,
       col = c(0,"blue","violet","red3","green4","darkorange1",0,0,"gray70","gray0"),
       c(expression(bold("Refrence Populations")),"African","EastAsia","European","NativeAmerican","SouthAsia","",
         expression(bold("ASD Groups")),"Control(SSC)","Case(MSSNG)"), title = "", bty="n") 
  
####################### ADMIXTURE #######################

#par(mar = c(1,2,1,2)+0.1,mgp=c(3,1,0))
#barplot(t(as.matrix(tbl1_3)),yaxt='n',col = c("brown1","blue2","darkolivegreen2"),beside=F,border=NA, xlim=c(0,(  nrow+10)))
#legend(x =     nrow+8, y = 0.8, c("K=3"), bty = "n",cex=2)
#par(mar = c(0,2,0,2)+0.1,mgp=c(3,1,0))
#barplot(t(as.matrix(tbl1_3)),yaxt='n',col = c(0,0,0,0,0,0,0,0, 0,0,0,0),beside=F,border=NA, xlim=c(0,(nrow+10)))
#text(9,0.9,"Cases - RJ", las=1,cex=2,srt=0, col="black", adj=c(1,0))
#text(25,0.9,"Cases - PB", las=1,cex=2,srt=0, col="black", adj=c(1,0))
#text(42,0.9,"Controls - RJ",cex=2,srt=0, col="black", adj=c(1,0))
#text(51,0.9,"Controls - PB",cex=2,srt=0, col="black", adj=c(1,0))
#3text(250,0.9,"Africans",cex=2,srt=0, col="black", adj=c(1,0))

dev.off()







