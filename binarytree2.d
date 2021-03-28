// Binary tree: 18 Feb 2012
//#I'm not sure on 'parent' 31 October 2014
// Got good help from: http://www.roseindia.net/java/java-get-example/java-binary-tree-code.shtml
import std.stdio;
import std.range;

class BinaryTree(T) {
	static class Node {
		T value;
		this(T value0) {
			value = value0;
		}
		Node left, right, parent; //#I'm not sure on 'parent'
	}
	
	Node head;

	void insert(T[] values...) {
		for( ; !values.empty; values.popFront() )
			insert(values.front);
	}

	void insert(T value) {
		if (head is null)
			head = new Node(value);
		else
			insert(head, value);
	}

	void insert(Node node, T value) {
		if (value < node.value) {
			if (node.left !is null)
				insert(node.left, value);
			else
				node.left = new Node(value);
		}
		else if (value > node.value) {
			if (node.right !is null)
				insert(node.right, value);
			else
				node.right = new Node(value);
		}
	}
	
	void printInOrder() {
		printInOrder(head);
	}
	
	void printInOrder(Node node) {
		if (node !is null) {
			printInOrder(node.left);
			writeln(node.value);
			printInOrder(node.right);
		}
	}
}

void main() {
	auto intTree = new BinaryTree!int();
	with(intTree) {
		insert(1, 8, 5, 2);
		printInOrder();
		writeln();
	}

	auto doubleTree = new BinaryTree!float();
	with(doubleTree) {
		insert(51.2, 24.3, 97.5, 3.8);
		writeln(typeof(head.value).stringof, "s:");
		printInOrder();
		writeln();
	}
}

version(Other) {
	void main() {
		Node!( string, int ) list;
		//donkey!
	}

	// I assume your value structure looks like this
	class Node(Key, value)
	{
		Key k;
		Node!(Key, value) left, right;
		int level;
		// ...

		bool opBinaryRight(string op)(Key k) if (op == "in") {
			if    (level == 0)    return    false;
			if    (k < key)       return    k in left;
			if    (key < k)       return    k in right;
			return    true;
		}
	}
}
