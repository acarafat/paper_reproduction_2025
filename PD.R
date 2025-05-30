library(ape)
library(picante)

tree <- read.tree('../Week_7/MLSA_viz/Phylogeny_module_example_data.fasta.aln.treefile')

meta <- read.csv('../Week_7/MLSA_viz/Phylogeny_module_tutorial_meta_data.csv', header=T)

rownames(meta) <- meta$Strain

# Make community matrix
community <- as.matrix(table(meta$Host, meta$Strain))

class(community)

# Cleaning
cleanTree <- drop.tip(phy = tree, 
                      tip = setdiff(tree$tip.label, colnames(community)),)


PD <- pd(samp = community,
         tree = tree,
         include.root = FALSE)
