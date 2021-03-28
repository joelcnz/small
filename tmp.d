void main() {
    struct List(T) {
        class Node {
            T value;
            Node next;
            this(T value) {
                this.value = value;
            }
        }
        Node head;

        auto append(T value) {
            auto newNode = new Node(value);
            if (head is null) {
                head = newNode;

                return this;
            }
            auto node = head;
            while(node.next) {
                node = node.next;
            }
            node.next = newNode;
			
			return this;
        }

        bool empty() { return head is null; }
        @property {
            ref auto front() { return head.value; }
            void popFront() { head = head.next; }
        }
    }
    import std.stdio;
    import std.range;
    import std.algorithm;

    auto ints = List!int();
    ints.append(1).append(2).append(3).append(4);
    writeln(ints);
    ints.array.retro.writeln;
}

