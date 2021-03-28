//#Not working..
module opapplytest;

struct List(T) {
    class Node {
        Node next;
        T data;
        this(T data) {
            this.data = data;
        }
    }
    Node head;
    void append(T data) {
        auto newNode = new Node(data);
        if (head is null) {
            head = newNode;
            return;
        } else {
            auto current = head;
            while(current.next) {
                current = current.next;
            }
            current = newNode;
        }
    }
    int opApply(int delegate(ref T) dg) {
        int result;
        auto current = head;
        while(current) {
            if ((current.data = dg()) != 0)
                break;
            current = current.next;
        }
    }
}

void main() {
    auto list = List!string;
    import std.stdio, std.string, std.conv;
    foreach(a; list) {
        a.data.writeln;
    }
}
