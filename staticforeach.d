module valgen2;
import std.conv : to;

enum valMax = to!uint(import("val.cfg"));

static foreach(i; 0 .. valMax) 
{
    mixin("enum val" ~ to!string(i) ~ "=" ~ to!string(i) ~ ";");
}

void main() 
{
    import std.stdio : writeln;
    static foreach(i; 0 .. valMax) 
    {
        mixin("writeln(val" ~ to!string(i) ~ ");");
    }
}
