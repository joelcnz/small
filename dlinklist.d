//#working
import std.stdio, std.conv;

struct List(T) {
	struct Item {
		T item;
		Item* next, prev;
		this(T item) {
			this.item = item;
		}
		
		string toString() {
			return item.to!string;
		}
	}
	
	Item* head, tail;
	
	this(T[] items...) {
		add(items);
	}
	
	void add(T[] items...) {
		foreach(item; items)
			add(item);
	}
	
	void add(T item) {
		auto newItem = new Item(item);
		if (head is null || tail is null) {
			head = tail = newItem;
			return;
		}
		tail.next = newItem;
		tail.next.prev = tail;
		tail = tail.next;
	}
	
	//#working
	void addAt(size_t pos, T item) {
		auto current = head;
		size_t index;
		while(current) {
			if (pos == index) {
				current.prev = new Item(item);
				head = current.prev;
				break;
			}
			current = current.next;
			index += 1;
		}
		
		throw new Exception(index.to!string ~ " index not exist");
	}
	
	
	void print() {
		auto current = head;
		while(current) {
			writeln(current.toString);
			current = current.next;
		}
	}
	
	void print_reverse() {
		auto current = tail;
		while(current) {
			writeln(current.toString);
			current = current.prev;
		}
	}
}

/+
struct Range(list) {
	bool empty() { return (list.head is null || list.tail is null); }
	void popFront() { list.head = list.head.next; list.head.next.prev = list.head; }
	ref list front() { return list.head; }
}
+/

void main() {
	auto list = List!int(1979,4,30);
	list.print;
	list.print_reverse;
	
	auto list2 = List!string("year", "month", "day");
	auto cur = list.head;
	auto cur2 = list2.head;
	while(cur !is null && cur2 !is null) {
		writeln(cur.toString, " - ", cur2.toString);
		cur = cur.next;
		cur2 = cur2.next;
	}

/+	
	auto range = Range!(List);
	foreach(item; range)
		writeln(item);
+/
}
