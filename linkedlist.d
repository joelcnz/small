//#under construction
// 8 August 2010
// Bombed out! :-/
// Are, but now look (21 June 2011)
import std.stdio: writeln, write;
import std.conv: to;

void main() {
	auto list = new LinkedList!int;
	with( list ) {
		add( 1948, 64, 6 );
		add( 79 );
		add( 32 );
		add( 6 );
		writeln( list ); // list -> to!string( list )
		list.printReverse; // not work!
		writeln;
	}
}

class LinkedList(T) {
	private class Node {
		this( T item ) {
			data = item;
		}
		
		override string toString() {
			return to!string( data );
		}
		
		T data;
		Node next, prev;
	}
	
	void add( T[] items... ) {
		foreach( item; items ) {
			add( item );
		}
	}
	
	void add( T item ) {
		auto newNode = new Node( item );
		if ( m_tail is null ) {
			m_head = m_tail = newNode;
			return;
		}
		
		m_tail.next = newNode;
		m_tail.prev = m_tail;
		m_tail = newNode;
	}
	
	//#under construction
	//override typeof( this ) reverse() {
	void printReverse() {
		writeln( "In reverse:" );
		auto current = m_tail;
		while( current !is null ) {
			write( current, ' ' );
			current = current.prev; 
		}
	}
	
	override string toString() {
		string result;
		auto current = m_head;
		while( current !is null ) {
			result ~= to!string( current ) ~ ' ';
			current = current.next;
		}
		return result ~ '\n';
	}
	
	private Node m_head, m_tail;
}
