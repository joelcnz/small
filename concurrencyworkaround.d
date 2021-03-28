//Org: http://forum.dlang.org/thread/k7orpj$1tt5$1@digitalmars.com
module toy;
import std.concurrency, std.stdio;

struct SImpl {
    string s;
    int i;
}
alias shared( SImpl ) S;

struct Msg { S s; }
struct Quit {}

S global = S( "global", 999 );

void main () {
    auto child = spawn( &task );
    S s = S( "abc", 42 );
    child.send( Msg( s ) );
    child.send( Msg( global ) );
    child.send( Quit() );
}

void task () {
    bool sentinel = true;
    while ( sentinel ) {
        receive(
            ( Msg msg  ) { writeln( msg.s.s, " -- ", msg.s.i ); },
            ( Quit msg ) { sentinel = false; }
        );
    }
}
