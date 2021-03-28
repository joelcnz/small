mixin template CompareStructs() {
    int opCmp(const typeof(this) rhs) {
        foreach(ti, elem; this.tupleof) {
            if(elem < rhs.tupleof[ti]) {
                return -1;
            } else if(elem > rhs.tupleof[ti]) {
                return 1;
            }
        }
        return 0;
    }
}

struct Foo {
    uint first;
    uint second;

    mixin CompareStructs;
}

void main() {  // Test it out.
    Foo small = Foo(10, 20);
    Foo large = Foo(20, 10);

    assert(small < large);
    assert(large > small);
}
