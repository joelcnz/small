/++
Copyright (C) 2012 Nick Sabalausky <http://semitwist.com/contact>

This program is free software. It comes without any warranty, to the extent
permitted by applicable law. You can redistribute it and/or modify it under
the terms of the Do What You Want To Public License, Version 2,
as shown below. Details are at: http://sam.zoy.org/wtfpl/

            DO WHAT YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT YOU WANT TO. 
+/

// Should work with DMD 2.059 and up

import core.thread;

class InputVisitor(Obj, Elem) : Fiber
{
	bool started = false;
	Obj obj;
	this(Obj obj)
	{
		this.obj = obj;
		super(&run);
	}

	private void run()
	{
		obj.visit(this);
	}
	
	private void ensureStarted()
	{
		if(!started)
		{
			call();
			started = true;
		}
	}
	
	// Member 'front' must be a function due to DMD Issue #5403
	private Elem _front;
	@property Elem front()
	{
		ensureStarted();
		return _front;
	}
	
	void popFront()
	{
		ensureStarted();
		call();
	}
	
	@property bool empty()
	{
		ensureStarted();
		return state == Fiber.State.TERM;
	}
	
	void yield(Elem elem)
	{
		_front = elem;
		Fiber.yield();
	}
}

template inputVisitor(Elem)
{
	@property InputVisitor!(Obj, Elem) inputVisitor(Obj)(Obj obj)
	{
		return new InputVisitor!(Obj, Elem)(obj);
	}
}
