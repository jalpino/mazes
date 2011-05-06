<!--- -----------------------------------------------------------------
	Justin Alpino - jalpino.com 
	2/16/2011 
	An implementation of a node that can be used for building 
	simple trees.
----------------------------------------------------------------- --->
<cfcomponent displayname="Node" output="false">
<cfscript>
	
	variables.value = "";
	variables.parent = {};
	variables.children = [];
	variables.equalsMethod = "";


	/**	
	 * Constructor
	 * @param value the payload of this node
	 * @return      a reference to this node
	 **/
	function init(any value){
	
		// Initially set the parent of this node to 'this', it implies
		// that 'this' is the root 
		variables.parent = this;
		
		// Define these static methods once
		var classLoader = getPageContext().getClass().getClassLoader();
		var objectClass = classLoader.loadClass("java.lang.Object");
		variables.equalsMethod = objectClass.getMethod("equals", [objectClass] );
		
		return this;
	}
	
	
	/**
	 * @return true if this node is the root of it's tree, false otherwise
	 **/
	function isRoot(){
		return variables.parent.isEqual( this );
	}
	
	
	/**
	 * @return the root of this node's tree
	 **/
	function getRoot(){ 
		return variables.isRoot() ? this : variables.parent.getRoot();
	}
	
	
	/**
	 * @param node a node to add as a child of this tree
	 **/
	function addChild( any node ){
		arguments.node.setParent(this);
		arrayAppend( variables.children, arguments.node );
	}
	
	/**	
	 * Determines if the supplied node shares the same root as this node's tree 
	 * @param node a node in the tree to compare
	 * @return     true if the supplied node shares the same root as this node's tree
	 **/
	function inSameTree( any node ){ 
		return variables.getRoot().isEqual( arguments.node.getRoot() );
	}
	
			
	/**
	 * Object comparison by value.
	 * Code from http://chris.m0nk3y.net, originated from Mark Mandrel http://www.compoundtheory.com
	 * @param node an instance of the tree node to compare for equality
	 * @return     true if the supplied node's value is equal to this node, false otherwise
	 **/
	function isEqual( any node ){
		return variables.equalsMethod.invoke( this ,[arguments.node]);
	}
		
	
	/**
	 * Generic getters and setters
	 **/
	function getValue(){ return variables.value; }
	function setValue( any value ){ variables.value = arguments.value; }
	function setParent( any parent ){  variables.parent = arguments.parent; }
	function getParent(){ return variables.parent; }
	function getChildren(){ return variables.children; }	
	
</cfscript>
</cfcomponent>