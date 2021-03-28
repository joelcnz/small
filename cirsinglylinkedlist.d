// Started: 18 2 2018 - I got ideas from looking up singly linked lists yesterday
enum whileCondition = "true";
//enum whileCondition = "node !is head";

void main() {
    class Node(T) {
        T value;
        Node!T next;
        this(T value0) {
            value = value0;
        }
    }

	import std.conv;
	alias intNode = Node!int;
	static foreach(num; 1 .. 4 + 1) {
		mixin("auto node" ~ num.to!string ~ " = new intNode(" ~ num.to!string ~ ");\n"); // the '\n' isn't needed
	}
	/+
    auto node1 = new intNode(1);
    auto node2 = new intNode(2);
    auto node3 = new intNode(3);
    auto node4 = new intNode(4);
	+/
    node1.next = node2;
    node4.next = node1;   node2.next = node3;
    node3.next = node4;

    import std.stdio;
	import core.thread;

    auto node = node1;
    do {
        writeln(node.value);
		Thread.sleep(200.msecs);
        node = node.next;
	} while( mixin(whileCondition) );
}
