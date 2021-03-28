import std;

struct List(T) {
	class Node {
		T data;
		Node next;
		this(T data) {
			this.data = data;
		}
		override string toString() {
			return data.to!string;
		}
	}
	Node head;
	typeof(this) add(T data) {
		auto node = new Node(data);
		if (head is null)
			head = node;
		else {
			auto current = head;
			while(current.next) {
				current = current.next;
			}
			current.next = node;
		}
		return this;
	}

	string total() {
		int total;
		auto current = head;
		while(current) {
			total += current.data.to!int;
			current = current.next;
		}
		
		return total.to!string;
	}

	string toString(string gap) {
		string result;
		auto current = head;
		while(current) {
			result ~= text(current, current.next ? gap : "");
			current = current.next;
		}
		return result;
	}
}

void main() {
	auto words = List!string();
	"I went for a walk and fell down a hole.".split.sort!q{a.toLower < b.toLower}.each!(word => words.add(word));
	writeln(words.toString("-"));

	auto nums = List!string();
	writeln("Nums:");
	iota(10).each!(a => nums.add(a.to!string));
	writeln(nums.toString("+"));
	writeln("Total: ", nums.total);
}
