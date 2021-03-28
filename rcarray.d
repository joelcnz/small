void main() {}

struct RCArray(E) {

    this(E[] a)
    {
        array = a.dup;
        start = 0;
        end = a.length;
        count = new int;
        *count = 1;
    }

    ~this()
    {
        if (count && --*count == 0)
            delete array;
    }

    this(this)
    {
        if (count)
            ++*count;
    }

    size_t length()
    {
        return end - start;
    }

    ref E opIndex(size_t i) return // here's the magic
    {
        return array[start + i];
    }

    RCArray opSlice(size_t lwr, size_t upr)
    {
        RCArray result = this;
        result.start = start + lwr;
        result.end = start + upr;
        return result;
    }

  private:
    E[] array;
    size_t start, end;
    int* count;
}

unittest
{
    static int[3] s = [7, 6, 4];
    auto r = RCArray!int(s);
    assert(r.length == 3);
    assert(r[0] == 7);
    assert(r[1] == 6);
    assert(r[2] == 4);
    assert(*r.count == 1);

    {
        auto r2 = r;
        assert(r2[0] == 7);
        assert(r2[1] == 6);
        assert(r2[2] == 4);
        assert(*r.count == 2);

        r[1] = 3;
        assert(r2[0] == 7);
        assert(r2[1] == 3);
        assert(r2[2] == 4);
    }
    assert(*r.count == 1);

    auto r3 = r[1 .. 3];
    r[2] = 9;
    assert(r3[0] == 3);
    assert(r3[1] == 9);

  /+
    ref int test(ref RCArray!int rr)
    {
        return rr[1]; // this gives error
    }
   +/
}
