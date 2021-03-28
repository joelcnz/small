// From ng 26 Feb 2011

import std.stdio;
void main()
{
    int counter;
   
    alias jubyte = ubyte;
    jubyte index = 0; // =0 is a dummy

    auto cnter = () {
		if ( ! (counter % 8) )
			writeln;

        writef( "%4#.2x, ", index );
        counter++;
	};

	for( index = jubyte.min; index < jubyte.max; ++index )
		cnter();
	cnter();
}

