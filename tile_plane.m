function tiling = tile_plane( tile, lattice, R )
% tiling = tile_plane( tile, lattice )
%   Tiles a plane with an image tile, given an n x 2 lattice matrix, and R

% Input parameter testing

% tile is sparse matrix?

% lattice must be n x 2
[ v, w ] = size( lattice );
if ( w ~= 2 ) || ( v <= 0 )
    error('Lattice must be n x 2');
end

% Extract coords of sparse matrix tile

[ i, j, s ] = find( tile );
[ m, n ] = size( tile );

% How many replications in tiling?

% Dimensionality of lattice?


% For quadrilateral (square, rectangular, trapezoidal) lattices

% for r = 1:R
%     transform_tile( tile, 'translate', r*lattice(1,:) );
%     transform_tile( tile, 'translate', r*lattice(2,:) );
% end