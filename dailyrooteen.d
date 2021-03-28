// Compile: dmd dailyrooteen looseterm.def
//#Get trouble with large font settings

import std.stdio; // for debugging and File
import std.string;
import std.conv;
import std.algorithm;
import std.array;
import std.datetime;

import jeca.all;

mixin(Jeca.pragmalibs);

void main() {
	Init();
	scope(exit) Deinit();

	int fontSize = 22;
	void reSizeFont( int newSize = fontSize ) {
		if ( FONT )
			al_destroy_font( FONT );
		FONT = al_load_font( `data\DejaVuSans.ttf`, newSize, 0);
	}
	
	reSizeFont();
	
	string[] items;

	foreach( line; File( "dailyrooteen.txt", "r" ).byLine )
		items ~= line.idup;
	
	auto win = new Window(items);
	bool done = false; // set to true to quit
	do {
		poll_input();
		
		if ( key[ ALLEGRO_KEY_UP ] )
			reSizeFont( fontSize++ ),
			win = new Window(items);

		if ( key[ ALLEGRO_KEY_DOWN ] )
			reSizeFont( fontSize-- ),
			win = new Window(items);
		
		al_clear_to_color( Colour.black );
		win.draw();
		al_flip_display();

		al_rest( 0.01 );

		done = key[ ALLEGRO_KEY_ESCAPE ] || exitHandler.doKeysAndCloseHandling;
	} while(!done);
}

class Window {
	class Item {
		float m_xpos, m_ypos;
		string m_item;
		int m_width, m_height;
		ALLEGRO_COLOR m_colour;
		
		this( string item, ALLEGRO_COLOR colour ) {
			m_item = item;
			m_width = al_get_text_width( FONT, toStringz(m_item) );
			m_height = al_get_font_line_height( FONT );
			m_colour = colour;
		}
		
		void setPos( float x, float y ) {
			m_xpos = x;
			m_ypos = y;
		}
		
		void draw() {
			al_draw_text(
				FONT,
				m_colour,
				m_xpos, m_ypos,
				0,
				toStringz( m_item )
			);
		}
	} // class item
	
	int w, h;
	Item[] items;
	this( string[] items0 ) {
		w = DISPLAY_W;
		h = DISPLAY_H;
		foreach( i, item; items0 ) {
			if ( !find(item, "Focus").empty )
				items ~= new Item( item, Colour.green );
			else
				items ~= new Item( item, i % 2 ? Colour.amber : Colour.red );
		}
	}
	
	void draw() {
		float x = 0f, y = 0f;
		bool left = true;
		foreach( i, item; items ) {
			with( item ) {
				if ( left )
					setPos( x, y );
				else
					setPos( w - m_width, y );
				draw();
				y += m_height;
				if ( y + item.m_height > h )
					y = 0,
					left = false;
			}
		}
	}
}
