import std.stdio;

void main() {
	Node!( string, int ) list;
	//donkey!
}

// I assume your data structure looks like this
class Node(Key, Data)
{
    Key k;
    Node!(Key, Data) left, right;
    int level;
    // ...

    bool opBinaryRight(string op)(Key k) if (op == "in") {
        if    (level == 0)    return    false;
        if    (k < key)       return    k in left;
        if    (key < k)       return    k in right;
        return    true;
    }
}
