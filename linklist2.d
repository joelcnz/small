void main(string[] args) {
	class List(T) {
		class Node {
			T item;
			Node next;
			
			this(T item) {
				this.item = item;
			}
		}
		
		Node _head;

		auto append(T[] items...) {
			foreach(item; items) {
				this ~= item;
			}
			
			return this;
		}

		auto opOpAssign(string s)(T item) if (s == "~") {
			auto newNode = new Node(item);
			if (_head is null) {
				_head = newNode;
				return this;
			}
			auto current = _head;
			while(current.next) {
				current = current.next;
			}
			current.next = newNode;
			
			return this;
		}
		
		@property bool empty() { return _head is null; }
		@property void popFront() {
			_head = _head.next;
		}
		ref T front() { return _head.item; }
		auto save() {
			auto l = new List!T;
		
			l._head = _head;
		
			return l;
		}
	}
	
	import std.stdio;
	import std.algorithm;
	import std.range;
	
	auto intList = new List!int;
	
	void update() {
		intList.save.each!writeln;
		writeln("---");
	}
	intList.append([0,1,2]).append(3);
	update;
	intList.dropOne;
	update;
	writeln(intList);
}