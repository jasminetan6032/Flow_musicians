% Interpolation and polynomials.
%
% Data interpolation.
%   pchip       - Piecewise cubic Hermite interpolating polynomial.
%   interp1     - 1-D interpolation (table lookup).
%   interp1q    - Quick 1-D linear interpolation.
%   interpft    - 1-D interpolation using FFT method.
%   interp2     - 2-D interpolation (table lookup).
%   interp3     - 3-D interpolation (table lookup).
%   interpn     - N-D interpolation (table lookup).
%   griddata    - Data gridding and surface fitting.
%   griddata3   - Data gridding and hyper-surface fitting for 3-dimensional data.
%   griddatan   - Data gridding and hyper-surface fitting (dimension >= 2).
%   TriScatteredInterp - Scattered data interpolant
%   griddedInterpolant - Interpolant for gridded data
%
% Spline interpolation.
%   spline      - Cubic spline interpolation.
%   ppval       - Evaluate piecewise polynomial.
%
% Geometric analysis.
%   delaunay    - Delaunay triangulation.
%   delaunay3   - 3-D Delaunay triangulation.
%   delaunayn   - N-D Delaunay triangulation.
%   dsearch     - Search Delaunay triangulation for nearest point.
%   dsearchn    - Search N-D Delaunay triangulation for nearest point.
%   tsearch     - Closest triangle search.
%   tsearchn    - N-D closest triangle search.
%   convhull    - Convex hull.
%   convhulln   - N-D convex hull.
%   voronoi     - Voronoi diagram.
%   voronoin    - N-D Voronoi diagram.
%   inpolygon   - True for points inside polygonal region.
%   rectint     - Rectangle intersection area.
%   polyarea    - Area of polygon.
% 
% Triangulation Representation.
%   TriRep                    - A Triangulation Representation
%   TriRep/baryToCart         - Converts the coordinates of a point from barycentric to cartesian
%   TriRep/cartToBary         - Converts the coordinates of a point from cartesian to barycentric
%   TriRep/circumcenters      - Returns the circumcenters of the specified simplices
%   TriRep/edges              - Returns the edges in the triangulation
%   TriRep/edgeAttachments    - Returns the simplices attached to the specified edges
%   TriRep/faceNormals        - Returns the normals to the specified triangular simplices
%   TriRep/featureEdges       - Returns the sharp edges of a surface triangulation
%   TriRep/freeBoundary       - Returns the facets that are referenced by only one simplex
%   TriRep/incenters          - Returns the incenters of the specified simplices
%   TriRep/isEdge             - Tests whether a pair of vertices are joined by an edge
%   TriRep/neighbors          - Returns the simplex neighbor information
%   TriRep/size               - Returns the size of the Triangulation matrix
%   TriRep/vertexAttachments  - Returns the simplices attached to the specified vertices
%   
% Delaunay Triangulation.
%   DelaunayTri                 - Creates a Delaunay triangulation from a set of points
%   DelaunayTri/convexHull      - Returns the convex hull
%   DelaunayTri/inOutStatus     - Returns the in/out status of the triangles in a 2D constrained Delaunay
%   DelaunayTri/nearestNeighbor - Search for the point closest to the specified location
%   DelaunayTri/pointLocation   - Locate the simplex containing the specified location
%   DelaunayTri/voronoiDiagram  - Returns the Voronoi diagram
%
% Polynomials.
%   roots       - Find polynomial roots.
%   poly        - Convert roots to polynomial.
%   polyval     - Evaluate polynomial.
%   polyvalm    - Evaluate polynomial with matrix argument.
%   polyfit     - Fit polynomial to data.
%   polyder     - Differentiate polynomial.
%   polyint     - Integrate polynomial analytically.
%   conv        - Multiply polynomials.
%   deconv      - Divide polynomials.

% Utilities.
%   xychk       - Check arguments to 1-D and 2-D data routines.
%   xyzchk      - Check arguments to 3-D data routines.
%   xyzvchk     - Check arguments to 3-D volume data routines.
%   automesh    - True if inputs should be automatically meshgridded.
%   mkpp        - Make piecewise polynomial.
%   unmkpp      - Supply details about piecewise polynomial.
%   splncore    - N-D Spline interpolation.
%   qhullmx     - Gateway function for Qhull.
%   qhull       - Copyright information for Qhull.

%   Copyright 1984-2011 The MathWorks, Inc.
%   $Revision: 5.27.4.10 $  $Date: 2011/04/16 06:39:50 $
