void main() {
	import std.stdio;
	struct List(T) {
		class Node {
			T value;
			Node next, prev;
			this(T value) {
				this.value = value;
			}
		}
		
		Node head, foot;
		
		auto opOpAssign(string s)(T value) {
			append(value);
		}
		
		auto append(T[] values...) {
			import std.algorithm : each;
			
			values.each!(value => append(value));
			
			return this;
		}
		
		auto append(T value) {
			auto newNode = new Node(value);
			if (head is null) {
				head = foot = newNode;

				return this;
			}
			foot.next = newNode;
			foot.next.prev = foot;
			foot = foot.next;
			
			return this;
		}
		
		bool empty() { return head is null || foot is null; }
		@property {
			ref auto front() { debug writeln("front"); return head.value; }
			void popFront() { debug writeln("popFront"); head = head.next; }

			ref auto back() { debug writeln("back"); return foot.value; }
			void popBack() { debug writeln("popBack"); foot = foot.prev; }
			
			auto save() { debug writeln("save"); return this; }
		}
	}
	
	import std.algorithm : each, sum, map, sort;
	import std.conv : text;
	import std.range : array, retro, iota;
	
	auto listInts = List!int();
	
	listInts.append(iota(1,12).array);
	listInts.each!writeln;
	listInts.retro.writeln;
	listInts.sum.writeln;
	
	struct Person {
		string name;
		int age;
		
		this(string name, int age) {
			this.name = name;
			this.age = age;
		}
		
		auto toString() {
			return text("Name ", name, ", age ", age);
		}
	}
	auto people = List!Person();
	
	people.append(Person("Alan", 41), Person("Katherine", 39), Person("Emily", 3), Person("Oscar", 0));
	people.each!writeln;
	people.map!(person => person.age).sum.writeln;
	people.array.sort!"a.name < b.name".writeln;
	people.each!writeln;
}
