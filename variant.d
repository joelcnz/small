/**
	Date: 5 Sep '10
*/
import std.stdio;
import std.variant;
import std.string;

void bioinfornatics(){
	writeln("bioinfornatics:");
    Variant[] array = [ Variant(1u) , Variant("hi"),
Variant(-2), Variant('5') ]; 
    foreach( var; array )
        writefln( "type: %s, value: %s", var.type, var );

	writeln("Dejan Lekic:");
	Variant[] arr = variantArray(0, "aa", 2.4);
    foreach( var; arr )
        writefln( "type: %s, value: %s", var.type, var );

}

void main() {
	bioinfornatics;

	Variant a;
	a=3.14;
	assert(a == 3.14);
	writeln(a*2);
	a="House";
	writeln(a);
	a~=" cat";
	assert(a == "House cat");
	writeln(a);
	
	Variant[] arr;
	arr.length+=1; // 'arr.length++;' not work, 'Error: arr.length is not an lvalue'
	arr[$-1]=3.14;
	arr.length=1;
	arr[$-1]="House cat";
	foreach (d; arr)
		writeln(d);
	// fails at the moment
	Variant b = new int[10];
	b[5] = 42;
	b[5] += 8;
	//assert(b[5] == 50); // fails D2.048, D2.049, & D2.057 - see alt way just below

	Variant[] c;
	c.length = 3;
	c[2] = 42;
	c[2] += 8;
	assert(c[2] == 50);
	writeln("42 + 8 = ", c[2]);
}
