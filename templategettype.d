// Org: d.D forum 7/21/11 7:27 PM, Simen Kjaeraas

version = NotWork;

import std.stdio;
import std.conv;
import std.typecons;
import std.typetuple;

version = Original;

template getType( alias A ) {
	alias typeof( A ) getType;
}

template getType( T ) {
	alias T getType;
}

version( Original )
{
	@property
	auto unpack( T... )( Tuple!( staticMap!( getType, T ) ) args ) {
		foreach ( i, e; T ) {
			T[i] = args.field[i];
		}
	}
}
else
{
	void unpack( T... )( Tuple!( staticMap!( getType, T ) ) args ) {
		foreach ( i, e; T ) {
			T[i] = args.field[i];
		}
	}
}

void main() {
	int num;
	string str;

	unpack!(num,str) = tuple(4, "O HAI");

	assert(num == 4);
	assert(str == "O HAI");
	
	
	version(NotWork) {
		auto stk = new Stack;
		
		stk.Push(1);
		stk.Push("two");
		stk.Push(3.5);
		
		auto f = stk.Pop;
		auto s = stk.Pop;
		auto i = stk.Pop;
		
		writeln(i, '\n', s, '\n', f);
	}
}

version(NotWork) {
class List {
	class Node {
		
	}
}

struct Obj {
	int i;
	string s;
	float f;
	string type;
	
	string toString() {
		//final switch(sel) {
		final switch(type) {
			case "int": return text(i);
			case "immutable(char)[]": return s;
			case "float": return text(f);
		}
	}
	
	//int sel;
	this(T)(T obj) {
		type = T.stringof;
		final switch(type) {
			case "int": i = obj; break;
			case "string": s = obj; break;
			case "float": f = obj; break;
		}
	}
}

public class Stack
{
   const int m_Size; 
   int m_StackPointer = 0;
   Obj[] m_Items;
   public this()
   { m_Size = 100; }
   public this(int size)
   {
      m_Size = size;
      //m_Items = new Obj[m_Size];
   }
   public void Push(T)(T item)
   {
      if(m_StackPointer >= m_Size) {
         writeln("too much");
         return;

	 }
      m_Items ~= Obj(item);
      m_StackPointer++;
   }
   public Obj Pop()
   {
      m_StackPointer--;
      if(m_StackPointer >= 0)
      {
         return m_Items[m_StackPointer];
      }
      else
      {
         m_StackPointer = 0;
         throw new Exception("Cannot pop an empty stack");
      }
   }
}
} // version
