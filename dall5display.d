/+
version( Windows ) {
	pragma( lib, "liballegro5" );
	pragma( lib, "libdallegro5" );
	pragma( lib, "libjeca" );
}

import jeca.all;

void main( string[] args ) {
	Init( args );
	scope( exit )
		Deinit( "Thanks for using dall5display!" );
	
	auto exitHandling = new KeyHandling;
	
	float gx = 0f, gy = 0f;
	ALLEGRO_BITMAP* stamp = al_create_bitmap( 800, 600 );
	auto exit = false;
	do {
		exit = exitHandling.doKeysAndCloseHandling;
		
		al_set_target_bitmap( stamp );
		al_clear_to_color( Colour.black );
		
		foreach( ypos; 0 .. 600 ) {
			foreach( xpos; 0 .. 800 ) {
				al_draw_filled_triangle(
					gx + xpos + 4, gy + ypos, gx + xpos + 8, gy + ypos + 8, gx + xpos, gy + ypos + 8, Colour.white );
				xpos += 19;
			}
			ypos += 19;
		}
		++gx;
		gy += 0.2;
		
		al_set_target_bitmap( al_get_backbuffer( DISPLAY ) );
		al_draw_bitmap( stamp, 0.5, 0.5, 0 );
		
		al_flip_display;
	} while( ! exit );
}

class KeyHandling {
private:
	ALLEGRO_EVENT event;
	bool getNextEvent() {
		return al_get_next_event( QUEUE, &event );
	}
public:
	auto doKeysAndCloseHandling() {
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
}
+/
