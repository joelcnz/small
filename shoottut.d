import main;

pragma(lib, "allegro");
pragma(lib, "allegro_acodec");
pragma(lib, "allegro_audio");
pragma(lib, "allegro_color");
pragma(lib, "allegro_dialog");
pragma(lib, "allegro_font");
pragma(lib, "allegro_image");
pragma(lib, "allegro_memfile");
pragma(lib, "allegro_physfs");
pragma(lib, "allegro_primitives");
pragma(lib, "allegro_ttf");
pragma(lib, "libdallegro5");
pragma(lib, "libjeca" );
pragma(lib, "libjext" );

import std.stdio;
import jeca.all;
import jext.all;

void main(string[] args) {
	Init(args);
	scope(exit) Deinit;
	
	while( !exitHandler.doKeysAndCloseHandling ) {
		
		al_clear_to_color( Colour.black );
		
		poll_input();
	}
}
