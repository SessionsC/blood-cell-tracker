Contained in the folder is the main code Sessions_Cullen_SuperPoints.m run that and it will display frame by frame the cells in wells clip with
the blood cells circled in red and a histogram of the displacements of the x and y axes. The histogram shows the frequency of how often the cells
displace a certain amount. also included is the actual movie clip, a jpeg of the final output if you dont want to wait until the program 
finishes (typically takes a few mins), and a pdf of my thoughts on how the histogram relates to the diffusion cofficient. the program should work for
any well but i made a change in calculating the displacement, i limited it to four to reduce amount of erronus 0's placed from miss identifed cells that
created a new column full of zeros the heavily influenced the histogram, for variable amount of cells replace the 4 with (cspan(1)-1).

Note: i thought about writing another part to this where it identifes good cells in green and bad cells in red, this could be done with the varying radi.
it seem as though cells with a radius smaller than 13 pixels is a bad cell most of the time. 