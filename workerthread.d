module main;
import std.container;
import core.thread;
import core.sync.condition;
import std.stdio;

struct Worker
{
	alias void delegate() Task;
	Thread _worker = null;
	bool _run = true;
	bool _busy = false;
	Mutex _mutex;
	Condition _cond;
	DList!Task _tasks;

	@disable this(this);
	@disable this();

	this(int x)
	{
		_mutex = new Mutex();
		_cond = new Condition(_mutex);
		_worker = new Thread(&this.runLoop);
		_worker.start();
	}

	~this()
	{
		_run = false;
		_cond.notifyAll();
		_worker.join();
		_worker = null;
	}

	private void runLoop()
	{
		while(_run)
		{
			Task task = getTask();

			if(task)
				task();
		}
	}

	private Task getTask()
	{
		Task ret ;

		synchronized(_mutex)
		{
			if(_tasks.empty)
			{
				_busy = false;
				_cond.wait();
			}
			
			if(_run)
			{
				ret = _tasks.front;
				_tasks.removeFront();
			}
		}

		return ret;
	}

	void run(void delegate() task)
	{
		synchronized(_mutex)
		{
			_busy = true;
			_tasks.insertBack(task);
			_cond.notify();
		}
	}

	@property bool busy() const
	{
		synchronized(_mutex)
			return _busy;
	}
}


class Stuff
{
	string _stuff;

	this(string stuff) {
		this._stuff = stuff;
	}

	void waitAndPrint()
	{
		foreach(i; 0..3)
		{
			Thread.sleep(1.seconds);
			writeln(_stuff);
		}
	}
}

void main(string[] args)
{
	Stuff stuff = new Stuff("asdf");

	Worker worker = Worker(0);

	writeln("doing work");

	worker.run(&stuff.waitAndPrint);
	Thread.sleep(5.seconds);

	writeln("done");
}

