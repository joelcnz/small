// dchar to char*
import std.c.stdio;

void main() {
	dchar dc = 'J';
	
	printf( "%s" "oel" "\n", dc.tocstr);
}

char* tocstr( dchar c ) {
	return cast(char*)(c ~ "\0"d).dup.ptr;
}
