class C
{
    int i;

    this(int i)
    {
        this.i = i;
    }
}

enum E : C
{
    one = new C(1),
    two = new C(2),
}

void foo(ref E e)
{
    e = E.two;
}

void main()
{
    auto e = E.one;
    foo(e);
    assert(e == E.two);
}
