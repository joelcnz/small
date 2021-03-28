/**
 * The map isn't simply one bit per character ?
 * 
 * Org: Ben Russell showeed me it
 * 
 */

module genbt2;

pragma( lib, "liballegro5" );
pragma( lib, "libdallegro5" );
pragma( lib, "libjeca" );

import std.string;
import core.stdc.stdlib;
import std.stdio;
import core.stdc.time;
import std.conv;

//import jec2.all; // my library that uses DAllegro
import jeca.all;

int xrand()
{
	static int lr = 0;
	lr = rand();
	srand(lr);
	return lr;
}

bool[][] genbt(int w, int h)
{
	auto map = new bool[][]( h + 2, w + 2 );
	int x,y,v;
	char[] s1, s2;
	s1.length = s2.length = w;

	writef("+"); foreach (c; 0 .. w+1) write("-"); writeln("+");
	char[] g; g.length = w + 1;	g[]=' '; writeln("|"~g~"|");
	for(y = 0; y < h; y += 2 )
	{
		for(x = 0; x < w;)
		{
			v = (xrand()>>3)&1;
			s1[x] = '#';
			s2[x++] = v ? ' ' : '#';
			s1[x] = v ? '#' : ' ';
			s2[x++] = ' ';
		}
 		writef("| %s|\n| %s|\n", s1, s2);
		
		foreach (x1, s; s1)
			map[ 1 + y ][ 1 + x1 ] = s =='#';
		foreach( x1, s; s2 )
			map[ 1 + y + 1 ][ 1 + x1 ] = s =='#';
	}
	writef("+"); foreach (c; 0 .. w+1) write("-"); writeln( "+" );
	
//	foreach( i, ref b; map[ $ - 1 ] )
//			b = true;
	
	return map;
}

int main(string[] args)
{
	args ~= ["10", "10"];
	Init( args );
	scope( exit ) Deinit();

	srand(time(null));
	if(args.length <= 2) return 1;
	auto map = genbt(to!int(args[1]), to!int(args[2]));
	al_draw_filled_rectangle( 0,0 ,
	  (map[0].length + 2)*8+7, (map.length / 2 + 3)*8+7, Colour.blue );
	foreach (y, l; map)
		foreach (x, c; l)
			if (c == true)
				al_draw_filled_rectangle( x*8 + 8, y*8 + 8, x*8+6 + 8, y*8+6 + 8, Colour.blue );
			else
				al_draw_filled_rectangle( x*8 + 8, y*8 + 8, x*8+8 + 8, y*8+8 + 8, Colour.black );
	al_flip_display();
	poll_input_wait;

	return 0;
}
