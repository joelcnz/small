import std.stdio;
import std.range;
import std.typetuple;
import std.traits;
import std.conv;

struct Foo { int i; }
struct Bar { int i; }
struct Baz { int i; }

void func(Foo foo = Foo(11), Bar bar = Bar(22), Baz baz = 
Baz(33)) {
    writeln("foo is ", foo);
    writeln("bar is ", bar);
    writeln("baz is ", baz);
}

void main() {
    kwargs!func(Bar(2), Baz(3), Foo(1)); //1, 2, 3
    kwargs!func(Baz(3), Foo(1)); //1, 22, 3
}

auto getStrArgs(alias F, T...)() {
    string[] strArgs;

    foreach(i, ParamType; ParameterTypeTuple!F) {
        enum index = staticIndexOf!(ParamType, T);

        static if(index != -1) {
            strArgs ~= "args[" ~ index.to!string ~ "]";
        } else {
            alias defaultValue = ParameterDefaultValueTuple!F[i];
            static if(is(defaultValue == void)) {
                strArgs ~= ParamType.stringof ~ ".init";
            } else {
                strArgs ~= defaultValue.stringof;
            }
        }
    }

    return strArgs;
}

auto kwargs(alias F, T...)(T args) {
    enum strArgs = getStrArgs!(F, T);
    mixin("return F(" ~ strArgs.join(",") ~ ");");
}
