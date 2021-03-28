import std.stdio;
import std.conv;

void main(string[] args) {
	struct List(T) {
		class Node {
			T data;
			Node next;

			this(T item) {
				data = item;
			}

			override string toString() {
				return data.to!string;
			}
		}

		auto add(T item) {
			auto newNode = new Node(item);
			if (head is null) {
				head = newNode;
				return this;
			}
			Node current = head;

			while(current.next !is null) {
				current = current.next;
			}
			current.next = newNode;

			return this;
		}

		Node head;

		string toString() {
			string result;
			Node current = head;
			while(current !is null) {
				result ~= current.to!string ~ (current.next is null ? "" : ", ");
				current = current.next;
			}
			return result;
		}
	}

	auto nums = List!int();
	nums.add(1).add(2).add(3);
	writeln(nums);
}
