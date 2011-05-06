<cfcomponent displayname="Kruskal" extends="Algorithm">
<cfscript>

	variables.sets = [];

	/**
	 * Builds a maze grid using Kruskal's algorithm. 
	 * @param width  the width of the maze grid
	 * @param height the height of the maze grid
	 * @param grid   a two-dimensional array representing the maze grid.
	 * @return       a completed maze grid
	 */ 
	function create( numeric width, numeric height, array grid ){
		var eg = {};
		var nX = 0;
		var nX = 0;
		var set1 = "";
		var set2 = "";
		var direction = "";
		var grid = arguments.grid;
		

		// Build a list of all edges between the cells in our grid. We could either
		// take just the South and East walls of all rows and columns except for the last row and column,
		// or just the North and West walls except for the first row and column
		var edges = [];
		for( var y = 1; y <= arguments.height; y++ ){
			for( var x = 1; x <= arguments.width; x++ ){	
			
				// Each cell starts with it's own tree
				variables.sets[y][x] = createObject("component","Node").init({x=x, y=y});
				
				// We are choosing to keep track of just the North and West walls
				// of each cell, except for the first row and first column				
				if( y > 1 )
					arrayAppend( edges , {x=x, y=y, d=variables.walls.N} );
				if( x > 1)	
					arrayAppend( edges , {x=x, y=y, d=variables.walls.W} );
			}
		}
		
		// Randomize the list of edges
		edges = shuffle(edges);
		
		// Iterate over all of the edges until there are none left in our list
		while( edges.size() ){
			
			// pop an edge off of the list
			eg = edges[ arraylen(edges) ];
			arrayDeleteAt( edges, arraylen(edges) );
			
			// get the (grid) location of the cell that is connected by our edge
			nY = eg.y + variables.yOffset[getDirection(eg.d)];
			nX = eg.x + variables.xOffset[getDirection(eg.d)];
			
			// for readability, create reference to the two trees
			local.set1 =  variables.sets[eg.y][eg.x];
			local.set2 =  variables.sets[nY][nX];
			
			// If the cells are not in the same tree, connect them and then knock 
			// down the wall between them
			if( ! local.set1.inSameTree( local.set2 ) ){
				
				// Connect the disjointed trees
				local.set1.addChild( local.set2.getRoot() );
				
				// Indicate in our cell that we are removing the connecting edge(wall), North or West
				if( bitXor( eg.d, grid[eg.y][eg.x]) )
					grid[eg.y][eg.x] += eg.d;
				
				// Indicate in our adjoining cell that we are removing the connecting edge(wall), South or East
				if( bitXor( variables.sllaw[getDirection(eg.d)], grid[nY][nX] ) )
					grid[nY][nX]  += variables.sllaw[getDirection(eg.d)];
			}
			
		};
		
		
		// return the generated maze		
		return grid;
	}
	
</cfscript>
</cfcomponent>