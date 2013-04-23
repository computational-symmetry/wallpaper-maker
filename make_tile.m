function tile = make_tile( pix, type, mode )
% tile = make_tile( pix, type, mode )
%   Creates a 2D image wallpaper tile given a patch size in pixels, a
%   type of tile shape and a mode for the pixel values.
%
%   pix     : m x n sparse matrix
%
%   type    : character string, specifies Wallpaper group type
%
%   motif   : character string, specifies pixel distribution
%
%   Written by Rick Gilmore, thatrickgilmore@gmail.com
%
%   Released under GPLv3

%--------------------------------------------------------------------------
%
%   History
%
%   2013-04-21 rog wrote

%--------------------------------------------------------------------------
%
%   Development notes
%
%   2013-04-21  Need to add and test code for complete set of 17 Wallpaper
%               groups.

%   Define defaults if unspecified

if nargin > 3
    error('Too many input arguments.');
elseif nargin == 2
    mode = 'randn';
elseif nargin == 1
    type = 'L';
    mode = 'randn';
elseif nargin < 1
    pix = 7;
    type = 'L';
    mode = 'randn';
end

%   Check parameters
[ nx, ny ] = size( pix );

if ( nx > 2 ) || ( ny > 2 )
    error('Pix must be scalar or vector.');
end

if ~ischar( type )
    error('Type must be character array.');
end

if ~ischar( mode )
    error('Mode must be character array.');
end

%   Initialize tile

if isscalar( pix )
    tile = zeros( pix, pix );
end

if ( nx == 1 ) && ( ny == 2 )
    tile = zeros( pix(1), pix(2) );
end

if ( nx == 2 ) && ( ny == 1 )
    tile = zeros( pix(1), pix(2) );
end

[ tile_h, tile_v ] = size( tile );

%   Determine center coords
center_v = round( (pix+1)/2 );
center_h = round( (pix+1)/2 );

%   Make initial pattern i, j coordinates
switch type
    case {'L'}  % Minimal L shape has 3 pix on long and 2 pix on short
        
        % Long segment
        i1 = (center_v - 1) : (center_v + 1);
        j1 = ones( 1, length( i1 ) ) * center_h;
        
        % Short segment
        i2 = center_v + 1;
        j2 = center_h + 1;
        
        % Combine
        i = [ i1 i2 ];
        j = [ j1 j2 ];
        
    case {'F'} % Minimal F is 4 pix long x 2 pix wide
        % Long segment
        i1 = (center_v - 2) : (center_v + 1);
        j1 = ones( 1, length( i1 ) ) * ( center_h - 1);
        
        % Short segment top
        i2 = center_v - 2;
        j2 = center_h;

        % Short segment middle
        i3 = center_v;
        j3 = center_h;

        % Combine
        i = [ i1 i2 i3 ];
        j = [ j1 j2 j3 ];
        
    case {'rand', 'RAND'}
        % Want 'sparsity' to be comparable to 'F' and 'L' so
        
        n_pts = 6;
        
        i = round( rand(1,6)*( pix(1) - 1) + 1 );
        j = round( rand(1,6)*( pix(1) - 1) + 1 );
        
    otherwise
        error('Type value not supported.');
end

%   Make value array for image coordinates

switch mode
    case {'randn'}
        s = randn(1, length( i ) );
    case {'bw', 'bw'}
        s = ones( 1, length( i ) );
    otherwise
        error('Image mode not supported.');
end

%   Generate tile as sparse matrix

tile = sparse( i, j, s, tile_h, tile_v );

return;



