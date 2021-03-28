//Don - found in bug report

auto opIndex(R...)(R args) {
	foreach (arg; args) {
		static if (is(typeof(arg) : Range)) {
			// slice this dimension
		} else if (is(typeof(arg) : indexType)) {
			// index this dimension
		}
	}
}

class Foo 
{
   int x;
   this(int x0) {
	   x = x0;
   }
   int length() { return x; }
   alias length opDollar;
   int opIndex(int k) { return x*k; }  
}

void main()
{
   Foo foo = new Foo(7);
   int x = foo[$-5];
   assert(x== 2*7);
}
