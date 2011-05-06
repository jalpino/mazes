<cfcomponent displayName="Maze" output="false">
<cfscript>
	
	variables.width = 2;						// default width
	variables.height = 2;						// default height
	variables.grid = [];						// a grid to represent our maze
	variables.walls = {N=1, E=2, S=4, W=8};		// bits values to represent our walls
	variables.xOffset = {N=0, E=1, S=0, W=-1};	// grid offset for moving horizontaly
	variables.yOffset = {N=-1, E=0, S=1, W=0};	// grid offset for moving verticly
	variables.sllaw = {N=4, E=8, S=1, W=2}; 	// opposing bit values of adjacent walls
	
	variables.cellsize = 10;					// size of the cell (in pixels)
	
	variables.strategy = "";			// an implemetion of the maze generation algorithm
	
	/**
	 * Constructor
	 * @param algorithm the dot notation path to the maze generation algorithm strategy
	 */
	function init(string algorithm){
		variables.strategy = createObject("component", arguments.algorithm ).init( variables.walls, variables.xOffset, variables.yOffset, variables.sllaw );
		return this;
	}
	
	/**
	 * Generates the maze, then draws it to an image
	 * @param width    the width of the maze
	 * @param height   the height of the maze
	 * @param cellSize the size of an individual cell, in pixels
	 * @param filePath the absolute or relative path to the jpg to save the maze too
	 */ 
	function create( numeric width, numeric height, numeric cellSize, string filePath ){
		variables.width = arguments.width;
		variables.height = arguments.height;
		variables.cellsize = arguments.cellsize;
		
		// Initialize our grid with a default state of 0, meaning it has not been visited yet
		local.grid = [];
		local.cells = [];
		arraySet(local.cells, 1, arguments.width, 0);
		arraySet(local.grid, 1, arguments.height, local.cells);

		// Generate the maze
		local.grid = variables.strategy.create( width, height, local.grid );
				
		// Create the maze image		
		_drawMaze( local.grid, width, height, filePath );
	}
	
	
	/**
	 * Creates an image of the maze and saves it to specified path
	 */ 
	function _drawMaze( array grid, numeric width, numeric height, string filePath ){
		
		local.gridH = variables.cellsize * arguments.height;
		local.gridW = variables.cellsize * arguments.width;
		
		// Define the canvas to build the maze on
		local.maze = imageNew( "", local.gridW, local.gridH, "rgb", "FFFFFF" );
		
		// Set our line color
		imageSetDrawingColor( local.maze, "000000");
		
		// Start drawing the grid
		for( local.y=1; local.y <= arguments.height; local.y++){
			for( local.x=1; local.x <= arguments.width; local.x++){
					local.xRef = (local.x-1) * variables.cellsize;
					local.yRef = (local.y-1) * variables.cellsize;
					
					// draw out the walls of the cell by checking to see if the path
					// of the adjoining wall is non-existent
					local.cell = arguments.grid[local.y][local.x];
					
					// North
					if( NOT bitAnd( local.cell, variables.walls.N ) ){
						imageDrawLine( local.maze, local.xRef, local.yRef, local.xRef + variables.cellsize, local.yRef );
					}
					
					//South
					if( NOT bitAnd( local.cell, variables.walls.S ) ){
						imageDrawLine( local.maze, local.xRef, local.yRef + variables.cellsize, local.xRef + variables.cellsize, local.yRef + variables.cellsize );
					}
					
					// East
					if( NOT bitAnd( local.cell, variables.walls.E ) ){
						imageDrawLine( local.maze, local.xRef + variables.cellsize , local.yRef, local.xRef + variables.cellsize, local.yRef + variables.cellsize );
					}
					
					// West
					if( NOT bitAnd( local.cell, variables.walls.W ) ){
						imageDrawLine( local.maze, local.xRef, local.yRef, local.xRef, local.yRef + variables.cellsize );
					}
			}
		}
		
		// Outline the maze
		local.mX = (arguments.width * variables.cellsize) -1;
		local.mY = (arguments.height * variables.cellsize) -1;
		
		imageDrawLine( local.maze, 0,0, local.mX, 0 );
		imageDrawLine( local.maze, local.mX, 0, local.mX, local.mY );
		imageDrawLine( local.maze, local.mX, local.mY, 0, local.mY);
		imageDrawLine( local.maze, 0,0, 0,local.mY );
		
		// Save the maze
		imageWrite( local.maze, arguments.filepath, 1  );	
		
	}
	
</cfscript>
</cfcomponent>