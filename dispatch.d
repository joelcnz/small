import std.stdio;

struct ufcs
{
     auto opDispatch(string name, T...)(T args) // appropriate if  compiles constraint here
     {
         mixin("return ." ~ name ~ "(this, args);");
     }
}

int foo(ufcs x, int y)
{
     writefln("it works! %d", y);
     return y+1;
}

void main()
{
     ufcs u;
     auto x = u.foo(1);
     assert(x == 2);
}
