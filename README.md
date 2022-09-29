# PopulationStructure
Pipeline including Quality Control and steps to run PCA (SNPRelate (doi: 10.1093/bioinformatics/bts606)) and ADMIXTURE (DOI: 10.1101/gr.094052.109)

## Filter just SNPs common with  Reference data
### For Positions
awk '{print "chr"$1"\t"$4}' FileReference.bim > File_UpdateID_POS.txt
 
for chr in (1..22) ; do  vcftools --gzvcf TargetFile_chr${chr}.vcf.gz --positions File_UpdateID_POS.txt --recode --stdout | gzip -c > TargetFile_SNPsReference_chr${chr}.vcf.gz ; done

## Merged chr and filter Biallelic Only

bcftools concat TargetFile_SNPsReference_chr${chr}.vcf.gz  | bcftools view --max-alleles 2 -Oz -o TargetFile_ReferenceSNPs_BiallelicOnly.vcf.gz

## Transform to bfile
plink2 --vcf TargetFile_ReferenceSNPs_BiallelicOnly.vcf.gz --make-bed --out TargetFile_ReferenceSNPs_BiallelicOnly

## Run SmartQC
https://github.com/ldgh/Smart-Cleaning
- Remove chr 0
- Remove duplicate data
- Remove missing data
- Infer individual sex
- Remove A|T and C|G variants
- Remove 100% heterozigotes variants
- dbSNPname
- liftOver

## Maybe will need add Case/Control information and update rs IDs before merge

## Merge
https://github.com/ldgh/MergedCleanData
But you can also use plink --bmerge

python3 mergeCleanData.py -d Target_Referencia_Database.txt -p programas.txt -f /folder/ -o Target_ReferenceData

## Make a list of SNPs in LD to be removed for each pop separatedly
for pop in African EastAsia European NativeAmerican SouthAsia ; do plink --bfile Target_Reference --indep-pairwise 100 10 0.4 --out ${pop}_Target_Reference_LD0.4 ; done

cat *Target_Reference_LD0.4.prune.out > List_LD0.4_All.prune.out

awk '!visited[$0]++' List_LD0.4_All.prune.out > List_LD0.4_All_noduplicates.prune.out

## Remove LD
plink --bfile Target_ReferenceData  --exclude List_LD0.4_All_noduplicates.prune.out --make-bed --out Target_ReferenceData_LD0.4

## Filter Relatdness

### Estimate relatdenss with King
plink2 --bfile Target_ReferenceData_LD0.4 --make-king-table --out Target_ReferenceData_LD0.4

### Used NaToRa (doi: 10.1016/j.csbj.2022.04.009)
https://github.com/ldgh/NAToRA_Public

perl KING2NAToRA.pl -i Target_ReferenceData_LD0.4.kin0 -o Target_ReferenceData_LD0.4_King

python NAToRA_Public.py --input Target_ReferenceData_LD0.4_King -c 0.1 -e 1 -o Natora_king_Target_Reference_LD0.4

### Formated NAToRA output
python FormatedNatora.py

### Exclude related samples
plink --bfile Target_ReferenceData_LD0.4 --remove Target_Reference_NatoraKing2Remove_LD0.4_Formated.txt --make-bed --out Target_ReferenceData_LD0.4_Unrelated

## PCA

### Make Correspondent List
awk '{print $2"\t"$1}' Target_ReferenceData_LD0.4_Unrelated.fam > Target_Reference_CorrespondentList.txt

### Run PCA
PCA.R 

## ADMIXTURE
### to Run
cd /folder/ADMIXTURE/

for K in {3..9}; do for J in bed bim fam; do cp Target_ReferenceData_LD0.4_Unrelated.${J} /folder/ADMIXTURE/ccc1_K${K}.${J}; done ; done

for K in {3..9}; do for rep in {1..15} ; do admixture -j512 -s time --cv /folder/ADMIXTURE/ccc1_K${K}.bed ${K} | tee /folder/ccc1_K${K}_replicate_${rep}.log; mv /folder/ADMIXTURE/ccc1_K${K}.${K}.P /folder/ADMIXTURE/ccc1_K${K}_replicate_${rep}.P ; mv /folder/ADMIXTURE/ccc1_K${K}.${K}.Q /folder/ADMIXTURE/ccc1_K${K}_replicate_${rep}.Q; done ; done


### Select Best Runs
for K in (3..9); do grep "^Loglikelihood" /folder/ADMIXTURE/ccc1_K${K}_replicate_*.log |sort -k2 -n | cut -d"." -f1-2 | tail -1 >> list_tplot_TargetReference.txt ; done

cp best runs to runs_toplot/

### Managing Data. Used scripts from https://github.com/ldgh/ that needed to be requested for academic pourpose. scripts nedded: 
- automatiza.pl
- ordenador_10.pl
- escolheCores2.pl

cd /folder/ADMIXTURE/runs_toplot/

for K in (3..9); do perl automatiza.pl -input Target_ReferenceData_LD0.4_Unrelated.fam -lista Target_Reference_CorrespondentList.txt -q /folder/ADMIXTURE/runs_toplot/ccc1_K${K}_replicate_*.Q; sed 's/ /\t/g' InputGrafico.txt > /folder/ADMIXTURE/runs_toplot/toplot2/InputGrafico_${K}.txt ; done

cd /folder/ADMIXTURE/runs_toplot/toplot2/

for i in (3..9); do printf "ID\tPOP" > line_head_${i}.txt ; for j in $(seq 1 $i); do printf "\tC$j" >> line_head_${i}.txt; done ; printf "\n" >> line_head_${i}.txt; done ; for i in (3..9); do cat line_head_${i}.txt InputGrafico_${i}.txt > 2sort_${i}.txt; done

for i in (3..9); do perl ordenador_10.pl -lista ListaOrdemPop.txt -input 2sort_${i}.txt; cat OrdenadaoDaMassa_1.txt > 2escolhe_K${i}.txt; rm -f OrdenadaoDaMassa_1.txt; done

perl escolheCores2.pl -cores Cores -input ListaFilesInput.txt -output plotADMIXTURE_Rscript

### Plot ADMIXTURE

plotADMIXTURE_Rscript.R

# Please Cite:
Borda V, Alvim I, Mendes M, Silva-Carvalho C, Soares-Souza GB, Leal TP, Furlan V, Scliar MO, Zamudio R, Zolini C, Araújo GS. The genetic structure and adaptation of Andean highlanders and Amazonians are influenced by the interplay between geography and culture. Proceedings of the National Academy of Sciences. 2020 Dec 22;117(51):32557-65.
