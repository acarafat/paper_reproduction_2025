library(ggtree)
library(phangorn)
library(viridis)
library(ggplot2)
library(ggnewscale)

tree = read.tree('../Week_7/MLSA_viz/Phylogeny_module_example_data.fasta.aln.treefile')
#tree = read.iqtree('../Week_7/MLSA_viz/Phylogeny_module_example_data.fasta.aln.treefile')
meta = read.csv('../Week_7/MLSA_viz/Phylogeny_module_tutorial_meta_data.csv', header = TRUE)



tree = midpoint(tree)

tree$tip.label
head(meta)

# ggtree
t1 = ggtree(tree) %<+% meta +
  geom_tippoint(aes(color = Host)) 

t1



# Adding meta data layer

# Defining new meta layer
meta.water <- as.data.frame(meta[, 'Water'])
  
rownames(meta.water) = meta$Strain
colnames(meta.water) = 'Water'


# Add Country
# Defining new meta layer
meta.country <- as.data.frame(meta[, 'Country'])

rownames(meta.country) = meta$Strain
colnames(meta.country) = 'country'





# Plot the water layer
t2 = gheatmap(t1, meta.water, width = 0.1) + 
  scale_fill_viridis_d(option='A', name='Water') +
  new_scale_fill() 
  
t2
  
gheatmap(t2, meta.country, width = 0.1, offset=0.02) +
  scale_fill_viridis_d(option='D', name='Location')




# Community analysis
tree
head(meta)


community <- as.matrix(table(meta$Host, meta$Strain))
head(community)


pd.df <- pd(samp = community, 
   tree = tree, 
   include.root = FALSE)


plot(pd.df$PD, pd.df$SR)
