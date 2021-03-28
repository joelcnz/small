struct Test {
     int a;
	string b;
}
   
void test(int a, string b) {
     import std.stdio;
     writeln(a, " ", b);
}

void main() {
     Test t;
     t.a = 10;
     t.b = "cool";
     // test(t); // won't compile, Test is not int, string
     test(t.tupleof);// WILL compile!
}
