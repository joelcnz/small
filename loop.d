//#funny place
//Org: dsimcha StackOverFlow - How to implement while loop in D?
void whileLoop(lazy bool cond, void delegate() loopBody) {
Begin:
    if(!cond) return;
    loopBody();
    goto Begin;
}

void whileLoop2(lazy bool condition,void delegate() fun) {
	startloop: if(!condition) goto endloop;
	fun();
	goto startloop;
	endloop:;
}

void whileLoop3( lazy bool cond, void delegate() fun){
    if(cond()){
        fun();
        whileLoop3(cond,fun);
    }
}

// Test it out.
void main() {
    import std.stdio; //#funny place

    int i;
    whileLoop(i < 10, {
        writeln(i);
        i++;
    });
    
    writeln();
    i = 0; whileLoop2( i < 3, { writeln( i ); ++i; } );
    
    writeln();
    i = 0; whileLoop3( i < 3, { writeln( i ); ++i; } );

    writeln();
}
