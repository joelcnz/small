#!/usr/bin/env dub
/+ dub.sdl:
	name "hello"
 	dependency "arsd-official" version="~>4.0.1"
	
+/
import std.stdio;
void main()
{
    writeln(`Content-type: text/html`);
    writeln(``);
    writeln(`<body style="background: lightgreen">CGI D Example</body>`);


}
