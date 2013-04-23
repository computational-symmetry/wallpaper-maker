%   Script to test wallpaper group generation and tiling routines.
%   
%-------------------------------------------------------------------------
%
%   History
%
%   2013-04-21  rog wrote

%   Parameters

pix = 6;
im_mode = 'randn';
wp_group = 'p2';
rep_matrix = [ 4 4 ];
plot_rows = 3;
plot_cols = 3;

%   Generate three different tile types

tile_f = make_tile( pix, 'F', im_mode);
tile_l = make_tile( pix, 'L', im_mode);
tile_rand = make_tile( pix, 'rand', im_mode );

% Plot tile

fh = figure(1);

subplot(plot_rows, plot_cols, 1);
imagesc( tile_f );

subplot(plot_rows, plot_cols, 2);
imagesc( tile_l );

subplot(plot_rows, plot_cols, 3);
imagesc( tile_rand );

% Make motifs

motif_f = make_motif( tile_f, wp_group );
motif_l = make_motif( tile_l, wp_group );
motif_rand = make_motif( tile_rand, wp_group );

% Plot motifs

subplot(plot_rows, plot_cols, 4);
imagesc( motif_f );

subplot(plot_rows, plot_cols, 5);
imagesc( motif_l );

subplot(plot_rows, plot_cols, 6);
imagesc( motif_rand );

% Plot replications/tilings

subplot(plot_rows, plot_cols, 7);
imagesc( repmat( motif_f, rep_matrix ) );

subplot(plot_rows, plot_cols, 8);
imagesc( repmat( motif_l, rep_matrix ) );

subplot(plot_rows, plot_cols, 9);
imagesc( repmat( motif_rand, rep_matrix ) );

