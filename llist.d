import std.stdio, std.conv, std.string, std.algorithm, std.array;

struct List(T) {
    string banner;

    class Node {
        T data;
        Node next, prev;
        this(T data) {
            this.data = data;
        }
    }
    Node head, tail;
    void append(T data) {
        auto node = new Node(data);
        if (! head)
            head = tail = node;
        else {
            tail.next = node;
            tail.next.prev = tail;
            tail = node;
        }
    }
    void prepend(T data) {
        auto node = new Node(data);
        if (! head)
            head = tail = node;
        else {
            head.prev = node;
            head.prev.next = head;
            head = node;
        }
    }
    int opApply(int delegate(ref T) dg) {
        auto current = head;
        int result = 0;
        while(current) {
            auto t = current.data;
            if((result = dg(t)) != 0) break;
            current = current.next;
        }
        return result;
    }
    string toString() {
        string result = banner;
        auto current = head;
        while(current) {
            result ~= text(current.data, "\n");
            current = current.next;
        }
        return result;
    }
}

void main() {
    auto list = List!string();
    list.banner = "\nBackward list:\n";
    "I went for a walk and fell down a hole".split.each!(e => list.prepend(e));
    auto list2 = List!string();
    list2.banner = "\nBack forward list:\n";
    foreach(word; list) {
        list2.prepend(word);
    }
    write(list);
    write(list2);

    auto list3 = List!string();
    list3.banner = "\nAppend list:\n";
    "I went for a walk and fell down a hole".split.each!(e => list3.append(e));
    write(list3);
}
