// http://forum.dlang.org/thread/hiuhqdxtpifhzwebewjh@forum.dlang.org
// I don't know what this file for
import std.traits;
import std.range;

struct Index(T = size_t) if (isUnsigned!T)
{
    this(T ix) { this._ix = ix; }
    T opCast(U : T)() const { return _ix; }
    private T _ix = 0;
}

mixin template genOps(T)
{
    auto ref opIndex(T i) inout { return _r[cast(size_t)i]; }
    auto ref opIndexAssign(V)(V value, T i) { return _r[cast(size_t)i] 
= value; }
    static if (hasSlicing!R)
    {
        auto ref opSlice(T i, T j) inout { return _r[cast(size_t)i ..
                                                     cast(size_t)j]; }
        auto ref opSliceAssign(V)(V value, T i, T j) { return 
_r[cast(size_t)i ..

cast(size_t)j] = value; }
    }
}

struct IndexedBy(R, string I = "Index") if (isArray!R)
{
    mixin(q{ struct } ~ I ~
          q{ {
                  alias T = size_t;
                  this(T ix) { this._ix = ix; }
                  T opCast(U : T)() const { return _ix; }
                  private T _ix = 0;
              }
          });
    mixin genOps!(mixin(I));
    R _r;
    alias _r this; // TODO Use opDispatch instead; to override only opSlice and opIndex
}

void main()
{
    auto i = IndexedBy!(int[])();
}
