function tile = make_tile( pix, type, mode )
% tile = make_tile( pix, type, mode )
%   Creates a 2D image wallpaper tile given a patch size in pixels, a
%   type of tile shape and a mode for the pixel values.
%
%   pix     : vector 1x2 or 2x1 or scalar indicating size of tile in pixels
%
%   type    : character string, specifies shape type {'F', 'L', 'rand'}
%
%               'F' :   An F shape centered in the tile region.
%               'L' :   An L shape centered in the tile region.
%               'rand': A random array of pixels with the same density as
%                           the F or L pattern.
%
%   mode   : character string, specifies pixel distribution type
%           
%               'randn' :   Pixel value chosen from random normal
%                           distribution.
%               'bw'    :   Black/white distribution, pattern coordinates
%                           are 1, all other pixels are 0.
%
%   Written by Rick Gilmore, thatrickgilmore@gmail.com
%
%   Based on code shared by Alasdair Clarke related to:
%   Clarke, A. D. F., Green, P. R., Halley, F., & Chantler, M. J. (2011). 
%   Similar Symmetries: The Role of Wallpaper Groups in Perceptual Texture 
%   Similarity. Symmetry, 3(2), 246–264. doi:10.3390/sym3020246
%
%   Released under GPLv3 (http://www.gnu.org/licenses/gpl.html)

%--------------------------------------------------------------------------
%
%   History
%
%   2013-04-21 rog wrote
%
%   2013-04-23 rog fixed documentation.
%   2013-04-24 rog changed shape of L to address asymmetry problem.

%--------------------------------------------------------------------------
%
%   Development notes
%
%   2013-04-23  Consider adding uniform random pixel value mode.
%               Consider adding feature to select tile from input.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


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
    case {'L', 'l'}  % Minimal L shape has 4 pix on long and 2 pix on short
        
        % Should scale shape to size of patch in pixels
        
        vert_seg_length = 4;
        if pix(1) < vert_seg_length
            error('Patch size in pixels must be > vertical segment length.');
        end
        
        % Long segment 1
        vert_margin = round( ( pix(1) - vert_seg_length )/2 );
        i1 = (1 + vert_margin):(1 + vert_margin) + vert_seg_length -1;
        j1 = ones( 1, length( i1 ) ) * (center_h - 2);

        % Long segment 2
        i2 = i1;
        j2 = ones( 1, length( i1 ) ) * (center_h - 1);

        % Short segment
        i3 = [ max( i1 ) max( i1 )];
        j3 = [ center_h center_h+1 ];   
        
        % Combine
        i = [ i1 i2 i3 ];
        j = [ j1 j2 j3 ];
        
    case {'F', 'f'} % Minimal F is 4 pix long x 2 pix wide
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
        % Want 'sparsity' to be comparable to 'F' and 'L' so fix n_pts
        % Should be more generic.
        
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



