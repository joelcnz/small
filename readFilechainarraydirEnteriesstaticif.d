//Org: Jul 18 2011 digitalmars.D forum - KennyTM~
import std.file, std.range, std.algorithm, std.stdio;

const WAY1 = true;
const WAY2 = false;

void main() {
	auto content = readText("readFilechainarraydirEnteriesstaticif.d");
	write(content);

	version( all ) {
		foreach( file; chain(
				array( filter!`endsWith( a.name, ".d" )`( dirEntries( ".", SpanMode.shallow ) ) )[ 0 .. 50 ],
				array( filter!`endsWith( a.name, ".txt" )`( dirEntries( ".", SpanMode.shallow ) ) )[ 0 .. 10 ]
			) ) {
			writeln( file.name );
		}
	}
    
    version( none ) {
		auto txtFiles = filter!`endsWith( a.name, ".txt" )`( dirEntries( ".", SpanMode.shallow ) );
		auto dFiles = filter!`endsWith( a.name, ".d" )`( dirEntries("testsuite", SpanMode.shallow ) );

		static if ( WAY1 ) {
			immutable list = "foreach (file; chain(txtFiles, dFiles) )
				writeln( file.name );";
		}
		static if ( WAY2 ) {
			immutable list = "foreach ( file; array( chain( txtFiles, dFiles ) )[ $ - 50 .. $ ] ) {
				writeln( file.name ); }";
		}
		mixin( list );
 	}
} 
