//Org: Siedge Lord, looks like he used my code
import std.stdio;
import std.c.string; //: cmem = memmove;

import jeca.all;

void main() {
	Init([]);
	writeln( "Enter text" );
	
	//clear_keybuf;
	//readkey;
	//poll_input_wait;
    int c = 0, t = 0;
    while(c >> 8 != ALLEGRO_KEY_ESCAPE)
    {
        c = readkey();
        if(c)
        {
            char[1] str;
            str[0] = c & 0xff;
			if ( c >> 8 == ALLEGRO_KEY_BACKSPACE )
				write( " \b" );
            write( str ~ '#' ~ '\b' );
        }
        
		//al_rest( 0.1 );
		/+
        t++;
        if ( t > 100_000 )
			t = 0,
			write( '.' );
		+/
		stdout.flush;
    }
	writeln( "See you later!" );	
}
