function new_tile = transform_tile( tile, transform )

% img       : sparse m,n matrix
% transform : type of transform {'none', 'mirror-h', 'mirror-v' }

% Test input types

if ~issparse( tile )
    error('Input image must be sparse matrix.');
end

if ~ischar( transform )
    error('Transform must be a string.');
end

% Extract i, j coordinates, s values
[ i, j, s ] = find( tile );
[ m, n ] = size( tile );

% Make coordinate matrix
ij = [ i j ];

% Center at origin
C = [ (m+1)/2*ones(size(i)) (n+1)/2*ones(size(i)) ];

ij_centered = ij - C;

% Specify transform matrix
switch transform
    case {'mirror-h', 'MIRROR-H'}
        T = [ 1 0; 0 -1 ];      
    case {'mirror-v', 'MIRROR-V'}
        T = [ -1 0; 0 1 ];
    case {'mirror-hv', 'MIRROR-HV', 'mirror-vh', 'MIRROR-VH'}
        T = [ -1 0; 0 -1 ];
    case {'rotate-90'}
        T = [ cos( pi/2 ) -sin(pi/2); sin( pi/2 ) cos( pi/2 ) ];
    case {'rotate-180'}
        T = [ cos(pi) -sin(pi); sin(pi) cos(p) ];
    case {'rotate-270'}
        T = [ cos(-pi/2) -sin(-pi/2); sin( -pi/2 ) cos( -pi/2 ) ];
    case {'rotate-60'}
        T = [ cos(pi/3) -sin(pi/3); sin( pi/3 ) cos( pi/3 ) ];
    case {'rotate-120'}
        T = [ cos(2*pi/3) -sin(2*pi/3); sin(2*pi/3) cos(2*pi/3) ];
    case {'rotate-240'}
        T = [ cos(-2*pi/3) -sin(-2*pi/3); sin(-2*pi/3) cos(-2*pi/3) ];
    case {'rotate-300'}
        T = [ cos(-pi/3) -sin(-pi/3); sin(-pi/3 ) cos(-pi/3) ];
    otherwise
        T = [ 1 0 ; 0 1 ];
        
end % switch transform

% transform coordinates, recenter
new_ij = ij_centered * T + C; % not integers, necessarily

new_tile = sparse( new_ij(:,1), new_ij(:,2), s, m, n );

return;



       