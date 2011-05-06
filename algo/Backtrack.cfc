<!--- ----------------------------------------------------------------------- --->
<!--- Backtrack.cfc --->
<!--- Performs an iterative depth-first search to build a tile based maze. --->
<!--- ----------------------------------------------------------------------- --->
<cfcomponent displayName="Backtrack" extends="Algorithm">
<cfscript>

	variables.stack = []; 
	
	/**
	 * Builds a maze using Backtracking
	 *
	 * @param width  the width of the maze grid
	 * @param height the height of the maze grid
	 * @param grid   a two-dimensional array representing 
	 *               the maze grid.
	 * @return       a completed maze grid
	 */ 
	function create( numeric width, numeric height, array grid ){
		variables.width = arguments.width;
		variables.height = arguments.height;
		variables.grid = arguments.grid;
		
		// begin creating a path through our tiles
		arrayAppend(variables.stack,{x=1,y=1});
		
		do{
			
			// Pop the last cell from the stack
			local.xy = variables.stack[ arraylen(variables.stack) ];
			arrayDeleteAt( variables.stack, arraylen(variables.stack) );
			
			// Create a path to a random neighbor
			createPath( local.xy.x, local.xy.y );
			
		}while( variables.stack.size() );
		
		
		// return the generated maze		
		return variables.grid;
	}
	
	
	/**
	 * The recursive backtracking algorithm to randomly create paths between neighboring 
	 * cells.
	 * @param x the x coordinate of the cell to inspect
	 * @param y the y coordinate of the cell to inspect
	 */
	function createPath( numeric x, numeric y  ){
		var local = {};
		
		// Randomly sort our directions
		local.dirs = [ variables.walls.N, variables.walls.E, variables.walls.S, variables.walls.W ];
		local.dirs = shuffle( local.dirs );
		
		// Look for neighboring cells that have not been visited yet
		for( local.i=1; local.i <= local.dirs.size(); local.i++ ){
			
			local.bearing = local.dirs[local.i];
			
			// Get the location of a new neighbor
			local.nX = x + variables.xOffset[ getDirection(local.bearing) ];
			local.nY = y + variables.yOffset[ getDirection(local.bearing) ];
			
			// Makes sure our new neighbor isn't outside of the grid or has already been visited
			if( local.nX < 1 || local.nX > variables.width 
			    || local.nY < 1 || local.nY > variables.height 
			    || val( variables.grid[local.nY][local.nX]) ){
				continue;		
			}
			
			// Open the adjoining walls to this neighbor
			variables.grid[y][x] += local.bearing;
			variables.grid[local.nY][local.nX] += variables.sllaw[ getDirection(local.bearing) ];
	
			// Move onto this new neighbor
			// **If we didn't take the iterative approach, we would call createPath()
			// again passing the coords to our new neighbor**
			// createPath( local.nX, local.nY );
			arrayAppend( variables.stack, {x=x,y=y} );
			arrayAppend( variables.stack, {x=local.nX, y=local.nY} );
			break;
			
		}
		
	}

</cfscript>
</cfcomponent>