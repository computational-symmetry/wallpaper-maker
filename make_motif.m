function motif = make_motif( tile, group )
% motif = make_wallpaper( tile, group )
%   Creates a 2D image wallpaper motif given an m x n image patch
%   and a specified wallpaper group type.
%
%   tile    : m x n sparse matrix
%
%   group   : character array specifying wallpaper group
%           
%               {'p1', 'p2', 'pm', 'cm', 'pmm', pmg', 'p4', 'p4m'}
%
%   Written by Rick Gilmore, thatrickgilmore@gmail.com.
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
%   2013-04-23 rog modified documentation, minor parameter fix.
%   2013-04-24 rog fixed bug in pm, pg, pmm, pmg, p4m

%--------------------------------------------------------------------------
%
%   Development notes
%
%   2013-04-21  Need to add and test code for complete set of 17 Wallpaper
%               groups.
%   
%   2013-04-24  Found bug in p4m. Need to modify for lattice structure.
%               FIXED.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


%   Input parameter checking
if ~ischar( group )
    error('Group must be a string.');
end

%   Test tile
if ~ issparse( tile )
    error('Tile must be a sparse matrix.');
end

% For each group, transform tile, then assemble motif from transformed
% components

switch group
    case {'p1', 'P1'}
        motif = tile;
    
    case {'p2', 'P2'} % Add Conway terms
        r180 = transform_tile( tile, 'rotate-180');
        
        motif = [ tile r180 ];
    
    case {'pm', 'PM'}
        mh = transform_tile( tile, 'mirror-h');
    
        motif = [ mh tile ];
    
    case {'pg', 'PG'}
        mv = transform_tile( tile, 'mirror-v');
    
        motif = [ tile mv ];
    
    case {'cm', 'CM'}
        mv = transform_tile( tile, 'mirror-v');
    
        motif = [ tile mv   tile  mv;
                  mv   tile mv    tile ];
    
    case { 'pmm', 'PMM' }
        mv = transform_tile( tile, 'mirror-v');
        mh = transform_tile( tile, 'mirror-h');
        mb = transform_tile( tile, 'mirror-hv');
        
        motif = [ tile mh;
                  mv   mb ];
              
    case { 'pmg', 'PMG' }
        mv = transform_tile( tile, 'mirror-v');
        mh = transform_tile( tile, 'mirror-h');
        mb = transform_tile( tile, 'mirror-hv');
       
        motif = [ tile mb;
                   mv mh ];
    
    case { 'p4', 'P4' }
        r270 = transform_tile( tile, 'rotate-270' );
        r180 = transform_tile( tile, 'rotate-180' );
        r90  = transform_tile( tile, 'rotate-90' );
        
        motif = [ tile r270;
                  r90  r180 ];
              
    case { 'p4m', 'P4M' }

          rot270 = transform_tile( tile, 'rotate-270');
          rot270mh = transform_tile( rot270, 'mirror-h');
          
          blank_tile = zeros( size( tile ) );
          
          sub_motif = [ tile    blank_tile;
                        blank_tile   rot270mh ];
                    
          motif = [ transform_tile( sub_motif, 'mirror-v' )    transform_tile( sub_motif, 'mirror-hv' );
                    sub_motif                                  transform_tile( sub_motif, 'mirror-h') ];
              
    otherwise
        error('Wallpaper group value not supported.');
end

return