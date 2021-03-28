import std.stdio, std.conv;

pragma(msg, "Hello compile time! -------------------------------------");

void main() {
	writeln("Hello runtime!");
	auto strList=new List!string;
	with(strList) {
		add("-=MacBook Pro 13 Mid 2009 addition=-").add("Is the Mac much good for programming on?").print();
	}
	
	auto numWordList=new List!NumWord;
	numWordList.add(NumWord(2,"laptops")).devide.gap.devide.add(NumWord(3, `Apple MacBook Pro's 13", 15", & 17"`)).print();
}

struct NumWord {
	int num;
	string word;
	this(int num0, string word0) {
		num=num0;
		word=word0;
	}

	string toString() {
		return to!string(num)~'-'~word;
	}
}

class List(T) {
	Node head;
	class Node {
		T data;
		Node next;
		this(T newNode) {
			data=newNode;
		}
	}

	auto add(T newNode) {
		if (head is null)
			head=new Node(newNode);
		else {
			auto node=head, last=head;
			while(node !is null) {
				last=node;
				node=node.next;
			}
			last.next=new Node(newNode);
		}
		return this;
	}
	
	auto gap() {
		writeln;

		return this;
	}
	
	auto devide() {
		import std.range;
		import std.algorithm;
		writeln("-".replicate(40));
		
		return this;
	}

	auto print() {
		auto node=head;
		while(node !is null) {
			writeln(node.data);
			node=node.next;
		}
		return this;
	}
}
