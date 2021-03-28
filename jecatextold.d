//#slower than a slippery snail!
//#need this, or crashes
//#Aaar, now this stopped it crashing (1 of 2 clears to stop the crashing) I dont think I memory stuff properly
//#ALLEGRO_PIXEL_FORMAT_ANY undefined
/**
 * This program uses:
 * 
 * DAllegro5:  https://github.com/SiegeLord/DAllegro5  
 * 
 * JECA: (thin DAllegro wrapper)  https://github.com/joelcnz/Jeca
 */

version( Windows ) {
	pragma( lib, "liballegro5" );
	pragma( lib, "libdallegro5" );
	pragma( lib, "libjeca" );
}

import std.stdio, std.string, std.conv, std.file;

import jeca.all;

/**
 * Program entry point
 */
void main( string[] args ) {
	//Init( args ~ "-mode opengl -wxh 640 480".split() );
	Init( args ~ "-wxh 640 480".split() );
	scope( exit ) Deinit();
	setUpGlobalFont();
	
	auto text = new LetterManager(
		//Square( 20, 10, 200, 0 ),
		Square( 0, 0, 640, 480 ),
		to!(dchar[])( (	cast(char[])std.file.read( "jecatext.d" )[ 0 .. 1_000 ] ) )
		//"I went for a walk and fell down a hole!" 
	);
	auto input = new LetterInput( text );

	while( ! exitHandler.doKeysAndCloseHandling ) {
		al_clear_to_color( Colour.black );

		input.doInput();
		text.update();
		text.draw();
		
//		al_flip_display();
		
//		al_rest( 0.01 );
	}
}

/**
 * Setup font for text
 */
void setUpGlobalFont() {
	FONT = al_load_font( "DejaVuSans.ttf", 18 , 0); // 18 seemed nice, (but small)
}

char* jtoCharPtr( dchar d ) {
	return cast(char*)to!(char[])(d ~ "\0"d).dup.ptr;
}

struct Square {
	int xpos, ypos, width, height;
}

class LetterManager {
public:
	@property ref auto letters() { return  m_letters; }
	@property ref auto stamp() { return m_stamp; }
	@property ref auto square() { return m_square; }

	this( Square square, in dchar[] stringLetters ) {
		this.square = square;
		with( square )
			stamp = new Bmp( width, height );
		//#slower than a slippery snail!
		double bar = stringLetters.length;
		auto countDown = 10;
		foreach( i, ref dchar l; stringLetters ) {
			if ( --countDown == 0 )
				al_draw_filled_rectangle( 0, 0, i * ( 640 / bar ), 8, Colour.green ),
				countDown = 10,
				al_flip_display();
			letters ~= new Letter( l );
		}
		placeLetters();
	}
	
	void popBack() {
		clear( letters[ $ - 1 ] ); //#Aaar, now this stopped it crashing (1 of 2 clears to stop the crashing) I dont think I memory stuff properly
		letters = letters[ 0 .. $ - 1 ];
	}
	
	void placeLetters() {
		with( square ) {
			auto inword = false;
			auto startWordIndex = -1;
			int x = xpos, y = ypos;
			void startNewLine( int i ) {
				foreach( ref l; letters[ i .. $ ] ) {
					x = xpos;
					l.setPostion( x, y );
					x += al_get_text_width( FONT, jtoCharPtr( l.letter ) );
				}
			}
			foreach( i, ref l; letters ) {
				auto let = jtoCharPtr( l.letter );
				if ( x + al_get_text_width( FONT, let ) > xpos + width ) {
					x = xpos;
					y += al_get_font_ascent( FONT ) +  al_get_font_descent( FONT );
					if ( y + al_get_font_ascent( FONT ) +  al_get_font_descent( FONT ) > ypos + height)
						break;
				}
				l.setPostion( x, y );
				l.update();
				x += al_get_text_width( FONT, let );
			}
		}
	}
	
	void update() {
		foreach( l; letters )
			l.update();
	}
	
	void draw() {
		//#ALLEGRO_PIXEL_FORMAT_ANY undefined
		al_lock_bitmap( stamp.bitmap,
			al_get_bitmap_format( stamp.bitmap ),
			ALLEGRO_LOCK_WRITEONLY );
		al_set_target_bitmap( stamp.bitmap );
		foreach( l; letters )
			l.draw();
		al_set_target_bitmap( al_get_backbuffer( DISPLAY ) );
		al_draw_bitmap( stamp.bitmap, 0, 0, 0 );
		al_unlock_bitmap( stamp.bitmap );

		al_flip_display();
	}
private:
	Bmp m_stamp;
	Letter[] m_letters;
	Square m_square;
}

class LetterInput {
public:
	@property ref auto letterManager() { return m_letterManager; }

	this( LetterManager letterManager ) {
		this.letterManager = letterManager;
		foreach( l; letterManager.letters )
			write( l.letter );
		std.stdio.stdout.flush;
	}
	
	void doInput() {
		int c = 0;
		c = readkey();
		if ( c ) {
			if ( ( c & 0xFF ) >= 32 ) {
				letterManager.letters ~= new Letter( c & 0xFF );
				letterManager.placeLetters();
			}
			
			if ( c >> 8 == ALLEGRO_KEY_BACKSPACE && letterManager.letters.length > 0 ) {
				write( " \b" );
				letterManager.popBack;
				letterManager.placeLetters();
			}
			write( cast(char)c ~ "#\b" ); std.stdio.stdout.flush;
		}
	}
private:
	LetterManager m_letterManager;
}

class Letter {
	@property ref auto xpos() { return m_xpos; } // ( 0<, 0 )
	@property ref auto ypos() { return m_ypos; } // ( 0, >0 )
	@property ref auto letter() { return m_letter; } // "c"
	
	void setPostion( double x, double y ) { xpos = x; ypos = y; }
	
	this( dchar letter ) {
		m_colour = Colour.amber;

		bmp = new Bmp(
			al_get_text_width( FONT, jtoCharPtr( letter ) ),
			al_get_font_ascent( FONT ) +  al_get_font_descent( FONT )
		);
		al_set_target_bitmap( bmp.bitmap );
		al_clear_to_color( al_map_rgba( 0, 0, 0, 0 ) );
		al_draw_text(
			FONT,
			m_colour,
			0, 0,
			ALLEGRO_ALIGN_LEFT, jtoCharPtr( letter )
		);
		al_set_target_bitmap( al_get_backbuffer( DISPLAY ) );
		
		this.letter = letter;
		m_xdir = 0;
		m_ydir = -1;
		m_roof = -1;
		m_floor = 0;
		m_height = 3;
		m_xoff = m_yoff = 0;
		m_shade = 0;
	}
	
	~this() {
		clear( bmp ); //#need this, or crashes
	}
	
	void update() {
		if ( m_roof == -1 ) {
			m_roof = ypos - m_height, m_floor = ypos;
		} else {
			m_yoff += m_ydir;
			if ( ypos + m_yoff < m_roof || ypos + m_yoff < m_floor )
				m_ydir *= -1;
		}
		//mixin( trace( "m_yoff m_ydir".split ) );
		m_yoff = 0;
		m_colour = makecol( m_shade, m_shade, m_shade );
		m_shade += 5;
	}
	
	void draw() {
		al_draw_tinted_bitmap( bmp.bitmap, m_colour, xpos, ypos, 0 );
	}
private:
	Bmp bmp;

	double m_xpos, m_ypos,
		m_xdir, m_ydir, m_width, m_height, m_roof, m_floor, m_xoff, m_yoff;
	dchar m_letter;
	ALLEGRO_COLOR m_colour;
	ubyte m_shade;
}

//version = SomeKindOfWrap;
version( SomeKindOfWrap ) {
/+
		if ( l.letter != 32 && inword == false )
			startWordIndex = i, inword = true;
		else if ( x > xpos + width && l.letter == 32 && inword == true ) {
				//startNewLine( startWordIndex ), inword = false;
				x = xpos;
				y += al_get_font_ascent( FONT ) +  al_get_font_descent( FONT );
				inword = false;
			}
+/
}
