//#dallegro mistake?
//#thing of note
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

/**
 * Title: Main program entry
 * 
 * Init JECA, run main class
 */
void main( string[] args ) {
	//#Note: args[ 0 .. $ ] gets all, args[ 1 .. 3 ] gets 1, & 2
	args = args[ 0 ] ~ "-m opengl -wxh 640 480".split() ~ args[ 1 .. $ ]; //#Split isn't clear this way ("foo bar".split), I think. Less typing though
	
	// JECA init
	//#Note immutable I think is for concurrancy(sp)
	immutable succeed = 0;
	if ( Init( args, ALLEGRO_INIT | TIMER | KEYBOARD | SOUND | GRAPHICS ) != succeed ) { // No mouse
		return;
	}
	scope( exit )
		Deinit;
	
	setUpGlobalFont();
	
	// create and launch main class object, then start main loop
	try {
		run();
	} catch( Exception e ) {
		writeln( "Got to main: ", e.toString() );
	}
}

/**
 * Setup font for text
 */
void setUpGlobalFont() {
	FONT = al_load_font( "DejaVuSans.ttf", 50, 0); // 18 seemed nice, (but small)
}

void run() {
	double x, y;
	x = y = 0f;
	enum {textDrop, fill, fillPhoto, pause, photoRotate };
	auto fade = 0;
	int stage = textDrop;
	auto countDown = 20;
	auto angle = 0f, scale = 1f;
	auto pic = al_load_bitmap( toStringz( "Sean.jpg" ) );
	void drawText() {
		al_draw_text(
			FONT,
			Colour.amber,
			x, y,
			ALLEGRO_ALIGN_LEFT, toStringz( format( "Happy Birthday Sean 7!" ) )
		);
	}
	
//	stage = textDrop; // release version
	//stage = fill;
	stage = photoRotate;
	
	do {
		switch( stage ) {
			case textDrop:
				al_clear_to_color( Colour.black );
				drawText();
				y += 8;
				if ( y == 480 ) {
					stage = fill;
					y = 0;
				}
				al_rest( 0.05 );
			break;
			case fill:
				al_clear_to_color( makecol( cast(ubyte)fade, cast(ubyte)fade, cast(ubyte)fade ) );
				fade += 3;
				if ( fade > 255 ) //#thing of note
					stage = fillPhoto, fade = 0;
				al_rest( 0.005 );
			break;
			case fillPhoto:
				al_draw_bitmap( pic, 0, 0, 0 );
				al_rest( 0.1 );
				--countDown;
				if ( countDown == 0 )
					stage = photoRotate, countDown = 20;
			break;
			case photoRotate:
				al_clear_to_color( Colour.black );
				al_draw_scaled_rotated_bitmap(
					pic, 320, 240, 320, 240, scale, scale, angle ,0 ); //#dallegro mistake!
				angle += ALLEGRO_PI / 50;
				if ( scale < 0.04 )
					scale -= 0.002;
				else
					scale -= 0.02;
				if ( scale < 0.0001 )
					stage = textDrop, angle = 0, scale = 1;
			break;
			default:
			break;
		}
		
		al_flip_display();
		
	} while( ! exitHandler.doKeysAndCloseHandling() );
}
