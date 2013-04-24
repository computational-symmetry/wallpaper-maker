function tile_play( wp_group )
%-------------------------------------------------------------------------
%   tile_play( wp_group )
%
%   Function to test wallpaper group generation and tiling routines. 
%   Generates and plots motifs from a given wallpaper group.
%
%   wp_group    : character array, group type
%                   {'p1', 'p2', 'pm', 'cm', 'pmm', pmg', 'p4', 'p4m'}
%   
%   Written by Rick Gilmore, thatrickgilmore@gmail.com.
%
%   Based on code shared by Alasdair Clarke related to:
%   Clarke, A. D. F., Green, P. R., Halley, F., & Chantler, M. J. (2011). 
%   Similar Symmetries: The Role of Wallpaper Groups in Perceptual Texture 
%   Similarity. Symmetry, 3(2), 246–264. doi:10.3390/sym3020246
%
%   Released under GPLv3 (http://www.gnu.org/licenses/gpl.html)

%-------------------------------------------------------------------------
%
%   History
%
%   2013-04-21  rog wrote
%   2013-04-23  rog modified documentation, turned into a function.
%   2013-04-24  rog added titles, figure label. Fixed L tile problem

%-------------------------------------------------------------------------
%   
%   Development notes
%
%   2013-04-23  Fix centering of 'L' tile. Causing problems. FIXED

%-------------------------------------------------------------------------
%-------------------------------------------------------------------------

%   Parameter checking
if ~ischar( wp_group )
    error('Group must be character array.');
end

%   Add check for valid wallpaper group -- TO DO

%   Parameters

pix = 6;
im_mode = 'randn'; % {'randn', 'bw'}
%wp_group = 'pmm'; % {'p1', 'p2', 'pm', 'cm', 'pmm', pmg', 'p4', 'p4m'}
rep_matrix = [ 4 4 ];
plot_rows = 3;
plot_cols = 3;

%   Generate three different tile types

tile_f = make_tile( pix, 'F', im_mode);
tile_l = make_tile( pix, 'L', im_mode);
tile_rand = make_tile( pix, 'rand', im_mode );

% Plot tile

fh = figure(1);
set( fh, 'Name', ['Wallpaper Group: ' wp_group ]);

subplot(plot_rows, plot_cols, 1);
imagesc( tile_f );
axis square;
title('F tile');

subplot(plot_rows, plot_cols, 2);
imagesc( tile_l );
axis square;
title('L tile');

subplot(plot_rows, plot_cols, 3);
imagesc( tile_rand );
axis square;
title('Random tile');

% Make motifs

motif_f = make_motif( tile_f, wp_group );
motif_l = make_motif( tile_l, wp_group );
motif_rand = make_motif( tile_rand, wp_group );

% Plot motifs

subplot(plot_rows, plot_cols, 4);
imagesc( motif_f );
axis square;
title('F motif');

subplot(plot_rows, plot_cols, 5);
imagesc( motif_l );
axis square;
title('L motif');

subplot(plot_rows, plot_cols, 6);
imagesc( motif_rand );
axis square;
title('Random motif');

% Plot replications/tilings

subplot(plot_rows, plot_cols, 7);
imagesc( repmat( motif_f, rep_matrix ) );
axis square;
title('F tiling');

subplot(plot_rows, plot_cols, 8);
imagesc( repmat( motif_l, rep_matrix ) );
axis square;
title('L tiling');

subplot(plot_rows, plot_cols, 9);
imagesc( repmat( motif_rand, rep_matrix ) );
axis square;
title('Random tiling');


