//Org: ng d.D.learn - 16 Aug 7:19 - Vijay Nayar
import std.stdio;

void main() {
    // Reference data to play with.
    immutable(byte)[] data = [0, 1, 2, 3, 4, 5, 6, 7];

    // These two lines simulate having an immutable byte pointer.
    immutable(byte)* ptr = data.ptr;
    auto ptr_len = data.length;

    // Making an immutable copy is easy, 'auto' works here too.
    immutable(byte)[] immutableCopy = ptr[2 .. 6];

    // Error!  Cannot implicitly convert to immutable.
    //byte[] badMutableCopy = ptr[2 .. 6]; 
    byte[] goodMutableCopy = immutableCopy.dup;

    // Make a simple edit to our mutable copy.
    foreach (ref b; goodMutableCopy) {
        b++;
    }

    // Output is: 2,3 3,4 4,5 5,6
    for (auto i=0; i < immutableCopy.length; i++) {
        writeln(immutableCopy[i], ',', goodMutableCopy[i]);
    }
}
