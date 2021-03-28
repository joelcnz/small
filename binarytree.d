//#remove fail
import std.stdio;
import std.conv;
import std.string;

class BinaryTreeExample(T) {
	static class Node {
		Node left;
		Node right;
		T value;
		this(T value) {
			this.value = value;
		}

		override string toString() {
			return to!string(value);
		}
	}
	
	Node root;

	void insert(T[] values...) {
		foreach(value; values)
			insert(value);
	}

	void insert(T value) {
		if (root is null)
			root = new Node(value);
		else
			insert(root, value);
	}
	
	void insert(Node node, T value) {
		static T checkToLower(T val) {
			static if (is(T == string))
				return val.toLower;
			else
				return val;
		}
		if (checkToLower(value) > checkToLower(node.value)) {
			if (node.left !is null) {
				insert(node.left, value);
			} else {
				node.left = new Node(value);
				writeln("Place '", value, "' to the right of '", node.value, "'");
			}
		} else if (checkToLower(value) < checkToLower(node.value)) {
			if (node.right !is null) {
				insert(node.right, value);
			} else {
				node.right = new Node(value);
				writeln("Place '", value, "' to the left of '", node.value, "'");
			}
		}	
	}

	void printInOrder() {
		printInOrder(root);
	}

	void printInOrder(Node node) {
		if (node !is null) {
			printInOrder(node.left);
			writeln(node);
			printInOrder(node.right);
		}
	}
	
	string pnode(Node n) {
		return n !is null ? n.to!string : "";
	}

	//#remove fail
	/+
	void removeHead() {
		if (head !is null) {
			Node headNew = head.left;
			if (head.left !is null) {
				Node headNew = head.left;
				headNew.right = head.right;
				head = headNew;
				/+
				if (head.right !is null)
					headNew.right = head.right;
				head = headNew;
				+/
			} else if (head.right !is null) {
					Node headNew = head.right;
					headNew.left = head.left;
					head = headNew;
					/+
					if (head.left !is null)
						headNew.left = head.left;
					head = headNew;
					+/
				}
			} else head = null;
		}
	}
	+/
}

void main(string[] args) {
	auto intTree = new BinaryTreeExample!int();
//	foreach(number; [25,11,23,15,79,16])
//		intTree.insert(number);
	intTree.insert(25,11,23,15,79,16);
	writeln(typeof(intTree.root.value).stringof, "s:");
	intTree.printInOrder();
	writeln();

	import std.string: toLower;
	auto stringTree = new BinaryTreeExample!string();
	foreach(word; "House cat rocket Hamilton".split())
		stringTree.insert(word.toLower);
	writeln(typeof(intTree.root.value).stringof, "s:");
	stringTree.printInOrder();
	writeln();
}
