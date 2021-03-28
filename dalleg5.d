/**
 * D Allegro 5.0 tests
 */
module dalleg5;

version( Windows ) {
	pragma( lib, "liballegro5" );
	pragma( lib, "libdallegro5" );
	pragma( lib, "libjeca" );
}

version( linux ) {
	pragma( lib, "allegro" );
	pragma( lib, "allegro_primitives" );
	pragma( lib, "allegro_ttf" );
	pragma( lib, "allegro_font" );
	pragma( lib, "allegro_image" );
	pragma( lib, "allegro_audio" );
	pragma( lib, "allegro_acodec" );

	pragma( lib, "jeca" );

	pragma( lib, "dallegro5" );
}

import std.stdio;
import std.string;
import algo = std.algorithm;
import std.typetuple;
import std.file;
import std.path;

import jeca.all;

ALLEGRO_FONT* g_font= null;

/**
 * Learn more:
 * 
 * http://stackoverflow.com/questions/5630137/for-and-foreach-statements-in-d
 */
static this() {
	foreach( type; TypeTuple!( int, long, short, string ) ) {
		pragma(msg, type);
	}
}

void main( string[] args ) {
	scope( exit ) { // try {} finally {}
		writeln( "Program exit" );
	}

	// JECA init
	immutable succeed = 0;
	if ( Init( args ) != succeed ) {
		return;
	}
	
	someMixinsCalls( args );

	string[ ALLEGRO_COLOR ] colourLabel = [
		Colour.red: "Red",
		Colour.blue: "Blue",
		Colour.black: "Black"
	];
	
	//#doesn't draw strait onto bmp
	al_clear_to_color( Colour.black );
	al_put_pixel( 1, 0, Colour.red );
	al_put_pixel( 2, 0, Colour.blue );
	
	ALLEGRO_BITMAP* bmp = al_get_backbuffer( DISPLAY );
	
	mixin( test( `colourLabel[ al_get_pixel( bmp, 1, 0 ) ] == "Red"`, `colour is red` ) );
	mixin( test( `colourLabel[ al_get_pixel( bmp, 2, 0 ) ] == "Blue"`, `colour is blue` ) );
	
	mixin( test( `colourLabel[ al_get_pixel( bmp, 3, 0 ) ] == "Black"`, `background colour is black` ) );


	auto b = new Test( "mysha.pcx" );
	clear( b ); //#this is a problem, and the dumbest kind of crash (exiting though), doesn't seem to always happen though
	clear( b );
	writeln( "lets eat strawberries!" );

	// loop through functions and calling them - font and display icon
	foreach( call; [ &setUpGlobalFont, &setUpIcon ] )
		*call;
	
	al_set_window_title( DISPLAY, toStringz( "D Allegro 5.0 testing" ) );
	
	ALLEGRO_EVENT event;
	bool getNextEvent() {
		return al_get_next_event( QUEUE, &event );
	}
	
	bool doKeysAndCloseHandling() {
		auto
			exitFalse = false,
			exitTrue = true;
		
		poll_input; //#may be not needed after a library fix
		
		if ( key[ ALLEGRO_KEY_ESCAPE ] )
			return exitTrue;
		
		// keep going through current events till none left, in which case contiune
		while( getNextEvent() )
		{
			switch( event.type )
			{
				// close button includes Alt + F4 etc
				case ALLEGRO_EVENT_DISPLAY_CLOSE:
					return exitTrue;
					
				default:
				break;
			}
		}
		
		return exitFalse;
	}

	b = new Test( "mysha.pcx" );

	alias doKeysAndCloseHandling exit;
	while( ! exit() ) {
		
		b.draw();
	
		al_flip_display();
		al_rest( 0.01 );
	}
}


class Test {
	this( string file ) {
		if ( exists( file ) ) {
			_name = file;
			_bmp = Bmp.loadBitmap( _name );
			writeln( _name, " loaded" );
		} else {
			writeln( "Warning: ", _name, " doesn't exist" );
		}
	}
	~this() {
		writeln( '"', _name, '"' ~ " deconstructor called {" ); // Name gets wiped out
		scope( exit )
			writeln( '}' );
		auto notNull = _bmp !is null;
		if ( notNull ) {
			al_destroy_bitmap( _bmp );
			writeln( "Bitmap destroyed." );
		} else {
			writeln( "Bitmap is already null." );
		}
	}
	
	void draw() {
		al_draw_bitmap( _bmp, /* xpos: */ 0, /* ypos: */ 0, 0 );
	}
	
private:
	ALLEGRO_BITMAP* _bmp;
	string _name;
}

/**
 * Some mixin calls using the arguments
 */
void someMixinsCalls( string[] args ) {
	mixin( trace( "args" ) );
	mixin( test( `algo.find( args[0], "dalleg5.exe" )`, `finds "dalleg5.exe"` ) );
}

/**
 * Make an array of fonts - the last one is set as the main one
 */
void setUpGlobalFont() {
	g_font = al_load_font( "DejaVuSans.ttf", 36, 0); // 18 seemed nice, (but small)
}

/**
 * Set icon for the window
 */
void setUpIcon() {
	al_set_display_icon( DISPLAY, Bmp.loadBitmap( "abc.png" ) );
}
