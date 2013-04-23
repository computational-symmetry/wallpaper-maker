# README.md #

This is a README file for the wallpaper group Matlab (.m) code written by Rick Gilmore (thatrickgilmore@gmail.com).

This code is based on ideas and code shared by Alasdair Clarke and used to generate displayed in this paper:

Clarke, A. D. F., Green, P. R., Halley, F., & Chantler, M. J. (2011). Similar Symmetries: The Role of Wallpaper Groups in Perceptual Texture Similarity. Symmetry, 3(2), 246–264. doi:10.3390/sym3020246


## Components ##

- tile_play.m

	- This script generates a few tiles using make_tile, creates a repeating motif using make_motif. The tile_plane function is at present just a skeleton. Eventually, it will include a more generic means of tiling the plane using a set of base vectors. 

	- Start with tile_play to see what's going on.- make_tile.m

	- Makes an elemental "tile" region that is replicated to create a wallpaper "motif"

	- Tile regions can be a centered "F" or "L" pattern or a random set of pixels. Soon to be added will be a specific image patch.

	 - make_motif.m

	- Makes a repeating wallpaper "motif" based on a series of translations, reflections, and rotations of the basic tile pattern.
- tile_plane.m- transform_im.m- transform_tile.m