// Forum answer - ajusted by Joel (JEC) - Wednesday 16 Feb 2011
// Didn't realize you could use mixin as a argument
import std.stdio;

enum FileName : string
{
	file1 = "mud.ext",
	file2 = "dirt.ext"
}

void main()
{
	import std.conv;
    foreach( a; __traits( allMembers, FileName ) )
	{
        writeln( a, " - ", mixin( "FileName." ~ cast(string)a ) );
	}
}
