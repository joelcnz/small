//#draw letter
//#to stop bouncing
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

Bmp[] g_bmpLetters;
int g_width = 16,
	g_height = 25;

/**
 * Program entry point
 */
void main( string[] args ) {
	//Init( args ~ "-mode opengl -wxh 640 480".split() );
	Init( args ~ "-wxh 640 480".split() );
	scope( exit ) Deinit();

	auto fonts = "ddrolive.bmp ddrocr.bmp".split;
	int fontIndex = 1;
	auto lettersSource = Bmp.loadBitmap( fonts[ fontIndex ] );
	al_convert_mask_to_alpha( lettersSource, al_get_pixel( lettersSource, 1, 0 ) );
	if ( fontIndex == 1 )
		al_convert_mask_to_alpha( lettersSource, al_get_pixel( lettersSource, 17, 0 ) );
	g_bmpLetters = getLetters(
		lettersSource, null, g_width + 1);
	
	auto text = new LetterManager(
		Square( 0, 0, 640, 480 ),
		to!(dchar[])( (	cast( char[] )std.file.read( "jecatext.txt" ) ) )
	);
	
	scope( exit )
		std.file.write( "jecatext.txt", text.getString() );
	
	auto input = new LetterInput( text );
	Bmp stamp = new Bmp( 640, 480 );

	while( ! exitHandler.doKeysAndCloseHandling ) {
		//#ALLEGRO_PIXEL_FORMAT_ANY undefined
		al_lock_bitmap( stamp.bitmap,
			al_get_bitmap_format( stamp.bitmap ),
			ALLEGRO_LOCK_WRITEONLY );
		al_clear_to_color( Colour.amber );
		al_set_target_bitmap( stamp.bitmap );

		text.draw();
		input.draw();
		
		al_set_target_bitmap( al_get_backbuffer( DISPLAY ) );
		al_draw_bitmap( stamp.bitmap, 0, 0, 0 );
		al_unlock_bitmap( stamp.bitmap );

		al_flip_display();
		
		input.doInput();
		text.update();
	}
	
	clear( stamp );
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
	@property ref auto area() { return m_area; }
	@property ref auto square() { return m_square; }
	
	Letter opIndex( int pos ) {
		return letters[ pos ];
	}

	this( Square square, in dchar[] stringLetters ) {
		this.square = square;
		with( square )
			area = new Bmp( width, height );
		double bar = stringLetters.length;
		auto countDown = 10;
		auto udtimes = 1;
		foreach( i, ref dchar l; stringLetters ) {
			if ( --countDown == 0 )
				al_draw_filled_rectangle( 0, 0, i * ( 640 / bar ), 8, Colour.green ),
				countDown = 10,
				al_flip_display();
			letters ~= new Letter( l );
			foreach( upd; 0 .. udtimes )
				letters[ $ - 1 ].update();
			++udtimes;
			if ( udtimes == 5 )
				udtimes = 1;
		}
		placeLetters();
	}
	
	string getString() {
		char[] str;
		foreach( l; letters ) {
			str ~= cast(char)l.letter;
		}

		return str.idup;
	}
	
	void popBack() {
		//clear( letters[ $ - 1 ] ); //#Aaar, now this stopped it crashing (1 of 2 clears to stop the crashing) I dont think I memory stuff properly
		letters = letters[ 0 .. $ - 1 ];
	}
	
	void placeLetters() {
		with( square ) {
			auto inword = false;
			auto startWordIndex = -1;
			int x = xpos, y = ypos;
			foreach( i, ref l; letters ) {
				auto let = jtoCharPtr( l.letter );
				if ( x + g_width > xpos + width || let[0] == 13 ) {
					x = ( let[0] == 13 ? xpos - g_width : xpos);
					y += g_height;
					if ( y + g_height > ypos + height)
						break;
				}
				l.setPostion( x, y );
				l.update();
				x += g_width;
			}
		}
	}
	
	void update() {
		foreach( l; letters )
			l.update();
	}
	
	void draw() {
		if ( letters.length > 0 ) {
			auto bmp = al_get_target_bitmap();
			al_set_target_bitmap( area.bitmap );
			al_clear_to_color( Colour.amber );
			foreach( l; letters )
				l.draw();
			al_set_target_bitmap( bmp );
			with( square )
				al_draw_bitmap( area.bitmap, xpos, ypos, 0 );
		}
	}
private:
	Bmp m_area;
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
		
		pos = letterManager.letters.length - 1;
	}
	
	void doInput() {
		int c = 0;
		c = readkey();

		void directional() {
			poll_input();

			if ( key[ ALLEGRO_KEY_LEFT ] ) {
				--pos;
				if ( pos == -1 )
					pos = 0;
			}

			if ( key[ ALLEGRO_KEY_RIGHT ] ) {
				++pos;
				if ( pos >= letterManager.letters.length  )
					--pos;
			}
			
			if ( key[ ALLEGRO_KEY_HOME ] )
				pos = 0;

			if ( key[ ALLEGRO_KEY_END ] )
				pos = letterManager.letters.length - 1;
			
			poll_input_wait();
		}
		directional();

		if ( c ) {
			if ( ( c & 0xFF ) >= 32 || c >> 8 == ALLEGRO_KEY_ENTER ) {
				with( letterManager ) {
					//insert letter
					// abD (ab#d) press c -> abcD (abc#d)
					letters = letters[ 0 .. pos + 1 ] ~
						new Letter( c & 0xFF ) ~ letters[ pos + 1 .. $ ];
					++pos;
					placeLetters();
				}
			}
			
//			mixin( trace( "pos" ) );
			
			if ( c >> 8 == ALLEGRO_KEY_BACKSPACE && letterManager.letters.length > 0 ) {
				write( " \b" );
				with( letterManager )
					letters = letters[ 0 .. pos ] ~ letters[ pos + 1 .. $ ];
				--pos;
				letterManager.placeLetters();
			}
			write( cast(char)c ~ "#\b" ); std.stdio.stdout.flush;
		}
	}
	
	void draw() {
		double xpos;
		double ypos;
		if ( letterManager.letters.length > 0 ) {
			xpos = letterManager[ pos ].xpos;
			ypos = letterManager[ pos ].ypos;
		} else {
			xpos = letterManager.square.xpos - g_width;
			ypos = letterManager.square.ypos;
		}
		if ( xpos + g_width >= 640 )
			xpos = -g_width,
			ypos += g_height;
		
		al_draw_filled_rectangle(
			xpos + g_width, ypos,
			xpos + g_width * 2, ypos + g_height, Colour.bluba );
	}
	
	@property ref auto pos() { return m_pos; }
private:
	int m_pos;
	LetterManager m_letterManager;
}

class Letter {
	@property ref auto xpos() { return m_xpos; } // ( 0<, 0 )
	@property ref auto ypos() { return m_ypos; } // ( 0, >0 )
	@property ref auto letter() { return m_letter; } // "c"
	
	void setPostion( double x, double y ) { xpos = x; ypos = y; }
	
	this( dchar letter ) {
		m_id = m_idCurrent;
		++m_idCurrent;
		m_colour = Colour.amber;

		this.letter = letter;
		m_xdir = 0;
		m_ydir = -1;
		m_roof = -999;
		m_floor = 0;
		m_height = 3;
		m_xoff = m_yoff = 0;
		m_shade = 0;
		
		acol = Colour.red, bcol = Colour.blue, abcol =  0.0;
	}
	
	~this() {
		//clear( bmp ); //#need this, or crashes
	}
	
	void update() {
		if ( m_roof == -999 ) {
			m_roof = -3, m_floor = 0;
		} else {
			m_yoff += m_ydir;
			dub tmp = m_ydir;
			if ( m_yoff < m_roof )
				m_ydir = 1;

			if ( m_yoff > m_floor )
				m_ydir = -1;

			if ( tmp != m_ydir )
				 m_yoff -= m_ydir;
		}
		//if ( m_id == 0 )
		//	mixin( traceLine( "m_yoff m_ydir".split ) );
		//m_yoff = 0; //#to stop bouncing
		m_colour = makecol( m_shade, m_shade, m_shade );
		m_shade += 5;
		
		abcol += 256 / 100 * 3;
		if ( abcol > 100.0 )
			abcol = 0.0;
	}
	
	//#draw letter
	void draw() {
		if ( (letter & 0xFF) != 13 )
			al_draw_bitmap( g_bmpLetters[ letter & 0xFF ].bitmap,
				xpos, ypos, 0 );
			/+
			al_draw_tinted_bitmap( g_bmpLetters[ letter & 0xFF ].bitmap,
				getBlend( acol, bcol, abcol ),
			xpos + m_xoff, ypos + m_yoff, 0 );
			+/
	}
private:
	static int m_idCurrent = 0;
	int m_id;
//	Bmp bmp;

	double m_xpos, m_ypos,
		m_xdir, m_ydir, m_width, m_height, m_roof, m_floor, m_xoff, m_yoff,
		abcol;
	dchar m_letter;
	ALLEGRO_COLOR m_colour, acol, bcol;
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

Bmp[256] getLetters( ALLEGRO_BITMAP* bmp, in string order, int step ) {
	Bmp[256] letters;
	foreach( i; 0 .. 256 ) {
		if ( i >= 33 && i < 128 ) {
			letters[ i ] = Bmp.getBmpSlice(
				bmp,
				(i - 33) * step, 1,
				step, g_height - 1,
				0, 0,
				0
			);

			al_set_target_backbuffer( DISPLAY );
			al_draw_bitmap( bmp, 0, 0, 0 );
			al_draw_bitmap( letters[ i ].bitmap, (i - 33) * step, 32, 0 );
		} else {
			letters[ i ] = new Bmp( step, step );
		}
	}
	al_flip_display();
	//poll_input_wait();
	
	return letters;
}
