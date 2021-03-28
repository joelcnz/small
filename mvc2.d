//#dallegro mistake!
//#thing of note
version( Windows ) {
	pragma( lib, "liballegro5" );
	pragma( lib, "libdallegro5" );
	pragma( lib, "libjeca" );
}

import std.stdio;
import std.string;

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
	
	al_set_window_title( DISPLAY, "Model View Controller - mvc2" );
	
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
	auto jade = 0;
	int stage = textDrop;
	auto countDown = 20;
	auto angle = 0f, scale = 1f;
	auto pic = al_load_bitmap( "Jade.jpg".ptr );
	assert( pic !is null );
	auto music = new Snd( "agmnn01.ogg" );
	void drawText() {
		al_draw_text(
			FONT,
			Colour.amber,
			x, y,
			ALLEGRO_ALIGN_LEFT, " Happy Birthday Jade 5! ".ptr
		);
	}
	
	stage = textDrop; // release version
	//stage = fill;
//	stage = photoRotate;
	
	music.play();
	scope( exit ) {
		music.stop();
		clear( music );
	}
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
				al_clear_to_color( makecol( cast(ubyte)jade, cast(ubyte)jade, cast(ubyte)jade ) );
				jade += 3;
				if ( jade > 255 ) //#thing of note
					stage = fillPhoto, jade = 0;
				al_rest( 0.01 );
			break;
			case fillPhoto:
				al_clear_to_color( Colour.black );
				al_draw_bitmap( pic, 0, 25, 0 );
				al_rest( 0.2 );
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
				al_rest( 0.01 );
			break;
			default:
			break;
		}
		
		al_flip_display();
		
	} while( ! exitHandler.doKeysAndCloseHandling() );
}
