@('c', 123, "hey") string s;
pragma(msg, __traits(getAttributes, s)); // prints tuple('c')

void main() {}
