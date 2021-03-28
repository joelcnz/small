//http://www.java2novice.com/data-structures-in-java/linked-list/doubly-linked-list/ - edited 19 2 2018

void main() {
	import std.stdio, std.range, std.algorithm;
	class DoublyLinkedListImpl(E) {
 
	    private Node head;
	    private Node tail;
	    private int _size;
     
	    public this() {
	        _size = 0;
	    }
	    /**
	     * this class keeps track of each element information
	     * @author java2novice
	     *
	     */
	    private class Node {
	        E element;
	        Node next;
	        Node prev;
 
	        public this(E element, Node next, Node prev) {
	            this.element = element;
	            this.next = next;
	            this.prev = prev;
	        }
	    }
	    /**
	     * returns the size of the linked list
	     * @return
	     */
	    public int size() { return _size; }

	    /**
	     * return whether the list is empty or not
	     * @return
	     */
	    bool empty() { return size == 0; }
		/+
		ref auto front() { return head.element; }
		ref auto back() { return tail.element; }
		void popFront() { removeFirst; }
		void popBack() { removeLast; }
		auto save() { return new DoublyLinkedListImpl(); }
		+/

	    /**
	     * adds element at the starting of the linked list
	     * @param element
	     */
	    public void addFirst(E element) {
	        Node tmp = new Node(element, head, null);
	        if(head !is null ) {head.prev = tmp;}
	        head = tmp;
	        if(tail is null) { tail = tmp;}
	        _size++;
			writeln("adding: ", element);
	    }
     
	    /**
	     * adds element at the end of the linked list
	     * @param element
	     */
	    public void addLast(E element) {
         
	        Node tmp = new Node(element, null, tail);
	        if(tail !is null) {tail.next = tmp;}
	        tail = tmp;
	        if(head is null) { head = tmp;}
	        _size++;
			writeln("adding: ", element);
	    }
     
	    /**
	     * this method walks forward through the linked list
	     */
	    public void iterateForward(){
         
			writeln("iterating forward..");
	        Node tmp = head;
	        while(tmp !is null){
	            writeln(tmp.element);
	            tmp = tmp.next;
	        }
	    }
     
	    /**
	     * this method walks backward through the linked list
	     */
	    public void iterateBackward(){
         
	        writeln("iterating backword..");
	        Node tmp = tail;
	        while(tmp !is null){
	            writeln(tmp.element);
	            tmp = tmp.prev;
	        }
	    }
     
	    /**
	     * this method removes element from the start of the linked list
	     * @return
	     */
	    public E removeFirst() {
	        if (size == 0) throw new Exception("NoSuchElement exception");
	        Node tmp = head;
	        head = head.next;
	        head.prev = null;
	        _size--;
	        writeln("deleted: ", tmp.element);
	        return tmp.element;
	    }
     
	    /**
	     * this method removes element from the end of the linked list
	     * @return
	     */
	    public E removeLast() {
	        if (size == 0) throw new Exception("NoSuchElement exception");
	        Node tmp = tail;
	        tail = tail.prev;
	        tail.next = null;
	        _size--;
			writeln("deleted: ", tmp.element);
	        return tmp.element;
		}
		override string toString() {
			iterateForward;
			return "";
		}
	}
     
//	static assert(isBidirectionalRange!DoublyLinkedListImpl, "Not a isBidirectionalRange");

	auto dll = new DoublyLinkedListImpl!int();
    dll.addFirst(10);
    dll.addFirst(34);
    dll.addLast(56);
    dll.addLast(364);
    dll.iterateForward();
    dll.removeFirst();
    dll.removeLast();
    dll.iterateBackward();
	
	writeln(dll);
}
