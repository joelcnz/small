/++
 + Title: Linked list using the type 'Object'
 + Comment: Working version made on Ryan's Mac laptop
 + Date: 09/07/2011
 + asfdghf: cat
 +/
module linkedlistwithobject;

pragma( lib, "liballegro5" );
pragma( lib, "libdallegro5" );
pragma( lib, "libjeca" );

import std.stdio;
import std.string;
import std.conv;

import jeca.all;

void main( string[] args ) {
	Init( args );
	scope( exit )
		Deinit( "Exiting, wee!" );

	auto exit = false;
	while( ! exit ) {
		poll_input;
		
		if ( key[ ALLEGRO_KEY_ESCAPE ] ) exit = true;
		
		al_clear_to_color( Colour.black );
		
		al_draw_circle( 50, 50, 20, Colour.amber, 3 );
		
		al_flip_display;
		
		al_rest( 0.01 );
	}
	
	auto list = new List;

	with( list ) {
		pragma( msg, "Add some numbers the hard way." );
		
		add( new Number( 1979 ) );
		add( new Number( 6 ) );

		pragma( msg, "Generics" );
		void add1(T)( T data ) {
			static if ( is( T == string ) ) {
				add( new Text( data ) );
			}
			else {
				add( new Number( data ) );
			}
		}

		pragma( msg, "Add some numbers the easy way." );
		foreach( num; [ 0, 32, 10, 37, 7 ] ) {
			add1!int( num );
		}
		
		add( new Text( "And" ) );
		
		foreach( txt; "now some text".split ) {
			add1!string( txt );
		}
		
		add( new Text( "Mix numbers with the text" ) );
		add( new Number( 111 ) );
		add( new Text( "bucket" ) );
		add( new Number( 1234 ) );
	}
	writeln( list );
}

class Text {
	this( string txt ) {
		this.txt = txt;
	}

	override string toString() {
		return txt;
	}
	
	private string txt;
}

class Number {
	this( int num ) {
		this.num = num;
	}

	override string toString() {
		return to!string( num );
	}
	
	private int num;
}

class List {
	class Node {
		this( Object data ) {
			this.data = data;
		}

		Object data;
		Node next;
	}
	
	void add( Object data ) {
		auto node = new Node( data );
		if ( head is null ) {
			head = node;
		} else {
			auto current = head;
			while( current.next !is null ) {
				current = current.next;
			}
			current.next = node;
		}
	}
	
	override string toString() {
		string text;
		auto current = head;
		while( current !is null ) {
			text ~= to!string( current.data ) ~ " ";
			current = current.next;
		}

		return text == "" ? "Empty" : text;
	}

private Node head;
}
