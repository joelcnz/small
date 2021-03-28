//./cf linkedlist2
//#for isIntegral
//#what about '~='
import std.stdio;

import jmisc;

//A Forward range
class LList(T) {
private:
	class Node {
		T data;
		Node next;
		
		this(T data0) {
			data = data0;
		}
	}
	Node _head;
public:
	@property {
		auto head() { return _head; }
		void head(Node head0) { _head = head0; }
	}
	
	void add(T data0) { //#what about '~=' - I couldn't get it working. :-\
		this ~= data0;
	}
		
	void add(T[] data0) {
		foreach(d; data0)
			this ~= d;
	}

	void opOpAssign(string op)(T data0) if (op == "~") {
		if (_head is null) {
			_head = new Node(data0);
			return;
		}
		
		Node current = _head;
		while(current.next !is null) {
			current = current.next;
		}
		current.next = new Node(data0);
	}
		
	import std.traits : isNumeric;
	int total()() if (isNumeric!T) {
		import std.algorithm.iteration;

		return this.reduce!"a + b"; // add all the numbers up.
	}
	
	/+
	version(none) {
		addBefore(3, 2);
		[1]->[3]->[4]
		->
		[1]->[2]->[3]->[4]
	}
	+/
	
	void addBefore(T target, T data) {
		Node current = _head, last = _head;
		
		if (_head.data == target) {
			_head = new Node(data);
			_head.next = last;
			
			return;
		}
		
		while(current.next !is null) {
			if (current.data == target) {
				last.next = new Node(data);
				last.next.next = current;
			}
			last = current;
			current = current.next;
		}
	}
	
	auto count(T data) {
		int count;

		foreach(d; this) {
			if (d == data) {
				count += 1;
			}
		}
		
		return count;
	}
	
	void clear() {
		_head = null;
	}
	
	@property {
		bool empty() { return _head is null; }
		auto ref front() { return _head.data; }
	}

	void popFront() {
		_head = _head.next;
		debug(5) writeln("popFront");
	}

	auto save() {
		auto l = new LList!T;
		
		l.head = _head;
		
		return l;
	}
}

void main() {
	auto list = new LList!int;
	foreach(n; [99,4,10,25,99,30,79,99])
		list ~= n;
	
	writeln(list.save);

	writeln("How many 99's: ", list.save.count(99));

	writeln("And again:");
	writeln(list.save);
	
	void seperater() {
		import std.array;
		writeln("-".replicate(7));
	}

	seperater;
	foreach(n; [1, 3, 4])
		list ~= n;
	writeln(list.save);
	list.addBefore(3, 2);
	writeln(list.save);

	seperater;
	foreach(n; [2, 3, 4])
		list ~= n;
	writeln(list.save);
	list.addBefore(2, 1);
	writeln(list);

	seperater;
	foreach(n; [1, 2, 3])
		list ~= n;
	writeln(list.save);
	list ~= 4;
	writeln(list);

	seperater;
	foreach(n; [4,10,25,30,79])
		list ~= n;
	writeln(list.save);
	writeln("Total: ", list.save.total);	
	import std.algorithm.iteration;
	
	writeln("Total: ", list.save.reduce!((a, b) => a + b));
	writeln("Times: ", list.save.reduce!((a, b) => a * b));
	
	auto list2 = new LList!string;
	
	import std.string;
	foreach(d; "Aa Bb Cc Dd".split)
		list2 ~= d;
	writeln(list2.save);
	writeln(list2);
	seperater;

	// Rhondda Rhondda   J       T           R   T           A
	// i             l Rhondda   i           i   i   A   J   l
	// a             a   e       m     Rhondda   m   l Rhondda
	//               n   l     Rhondda i       Rhondda i e   n
	//                           t     a       i t   n a l
	//                           h             a h    
	//                           y               t
	//
	//    y                     
	//    h                       T
	//    t J       J          Neville
	//  J o o   J   o             m
	//  o mAe   o RAe     R       o
	// Neville Neville Neville    t
	//  l Ta    l aa      a       h
	//     n       n              y
	list2.clear;
	foreach(name; "Neville Rhondda Ria Alan Joel Timothy".split)
		list2 ~= name;
	import std.algorithm.iteration;
	list2.
	each!writeln;

	//   A    J       A  R      RiA
	//   l Timothy Joel Timothy   l
	// Ria    e       a  a        a
	//   n    l       n           n
	foreach(name; "Ria Alan Joel Timothy".split)
		list2 ~= name;
	writeln(list2.save);
	
	auto list2b = new LList!char;
	foreach(s; list2.save)
		foreach(c; s)
			list2b ~= c;
	int getTotal(T)(T c) {
		return list2b.save.count(c);
	}
	with(list2b)
		writeln("How many 'a's + 'l's + 'o's + 'A': ", getTotal('A') + //save.count('A') +
												       getTotal('l') + // save.count('l') +
												       getTotal('a') + //save.count('a') +
												       getTotal('o')); //save.count('o') );

	import std.range;
	foreach(i, name; list2.save.enumerate(1))
		writeln(i, ". ", name);
	
	seperater;
	auto list3 = new LList!char;
	foreach(c; "abcd".dup)
		list3 ~= c;
	writeln(list3.save);
	foreach(i, c; list3.enumerate(1))
		writefln("%s. %s", i, c);

	seperater;
	struct Person {
		string name;
		int age;
	}
	auto list4 = new LList!Person;
	Person[] people = [{"Ria", 42}, {"Alan", 39}, {"Joel", 37}, {"Timothy", 33}];
	foreach(p; people)
		list4 ~= p;
	foreach(i, p; list4.save.enumerate(1))
		writefln("%s. Name: %7s, Age: %s", i, p.name, p.age);
	writeln("drop first two:");
	writeln(list4.drop(2));
	
	int sum;
	mixin(jecho(q{
	import std.range;
	int[] arr = iota(11 + 1).array; //[ 1, 2, 3, 4 etc. ];
	// Sum all elements (all do the same)
	writeln(`Sum: `, reduce!((a,b) => a + b)(0, arr));
	writeln(`Sum: `, sum = reduce!((a,b) => a + b)(arr));
	sum = arr.reduce!`a + b`;
	assert(sum == 66);
	}));
}
