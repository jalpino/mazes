<cfcomponent displayname="Algorthim" output="false">
<cfscript>

	variables.width=0;
	variables.height=0;
	variables.grid = [];
	variables.walls = {};
	variables.xOffset = {};
	variables.yOffset = {};
	variables.sllaw = {};

	/**
	 * Constructor
	 */
	function init( struct walls, struct xOffset, struct yOffset, struct sllaw ){
		
		variables.walls = walls;
		variables.xOffset = xOffset;
		variables.yOffset = yOffset;
		variables.sllaw = sllaw;
		
		return this;
	
	}
	
	/**
	 * @param width  the width of the maze grid
	 * @param height the height of the maze grid
	 * @param grid   a two-dimensional array representing the maze grid.
	 * @return       a completed maze grid
	 */ 
	function create( numeric width, numeric height, array grid ){
		writeDump("Implement the 'create()' method.");
		exit();
	}
	
	/**
	 * @param bearing the bit value for an associated direction
	 * @return        the key value of the bearing, ie. N, S, E, W
	 */ 
	function getDirection( numeric bearing ){
		for(var key in variables.walls ){
				if( variables.walls[key] == bearing )
					return key;
		}
		return "";
	}
	
	
	/**
	 * Railo safe way to randomly sort items in an array. java.util.Collections.shuffle() returns dupes in Railo
	 * @param arr the array to shuffle
	 * @return    the array with randomly sorted items
	 */
	function shuffle( array arr ){
		var retarr = [];
		var j=0;
		for(var i=arr.size(); i>0; i-- ){
			j = randrange(1,i);
			arrayAppend( retarr, arr[ j ] );
			arrayDeleteAt( arr, j);
		}
		return retarr;
		
	}

</cfscript>
</cfcomponent>