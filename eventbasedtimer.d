//#My add
// I don't know how to use this..

// Implementation of timer wheel algorithm
// More info: http://www.ibm.com/developerworks/aix/library/au-lowertime/index.html
//
// License: public domain
//
// "Params" is an argument list for timeout callback function
module timeouts;
 
import std.datetime;
import core.thread, core.sync.mutex, core.sync.condition;

//#My add
void main() {
	auto tow = new TimeoutWorker!(int);
	with(tow) {
		tow.run = true;
		start;
		Thread.sleep(1.seconds);
		stop;
	}
}
 
class TimeoutWorker(Params...)
{
    private alias void function(Params) TimeoutCallback;
    
    private struct Timeout
    {
        size_t rounds;
        int slot;
        TimeoutCallback callback;
        static if (Params.length)
            Params params;
        
        Timeout* prev;
        Timeout* next;
        bool waiting;
    }
 
    this()
    {
        thread = new Thread(&worker);
        c = new Condition(new Mutex(this));
    }
    
    void start()
    {
        thread.start();
        //c.wait();
    }
 
    void stop()
    {
        run = false;
        thread.join();
    }
    
    void* addTimeout(int interval, TimeoutCallback callback, Params params)
    in
    {
        assert(interval >= 0);
    }
    body
    {
        Timeout* timeout = new Timeout;
        timeout.callback = callback;
        static if (Params.length)
            timeout.params = params;
        
        restartTimeout(timeout, interval);
        
        return timeout;
    }
    
    void cancelTimeout(void* handle)
    {
        restartTimeout(handle, -1);
    }
    
    void restartTimeout(void* handle, int interval)
    {
        Timeout* timeout = cast(Timeout*)handle;
        
        synchronized (this)
        {
            if (timeout.waiting)
            {
                Timeout* prev = timeout.prev;
                Timeout* next = timeout.next;
                
                if (prev)
                    prev.next = next;
                else
                    timeouts[timeout.slot] = next;
                
                if (next)
                    next.prev = prev;
                
                timeout.waiting = false;
            }
            
            if (interval < 0)
                return;
            
            size_t newSlot = (currentSlot + (interval / 10)) % 100;
            size_t rounds = (currentSlot + (interval / 10)) / 100;
 
            Timeout* list = timeouts[newSlot];
            
            timeout.rounds = rounds;
            timeout.slot = cast(int)newSlot;
            timeout.next = list;
            timeout.prev = null;
            
            if (list)
                list.prev = timeout;
            
            timeout.waiting = true;
            timeouts[newSlot] = timeout;
        }
    }
    
    void setCallback(void* handle, TimeoutCallback callback)
    {
        Timeout* timeout = cast(Timeout*)handle;
 
        synchronized (this)
        {
            timeout.callback = callback;            
        }
    }
    
    static if (Params.length)
    {
        void setParams(void* handle, Params params)
        {
            Timeout* timeout = cast(Timeout*)handle;
 
            synchronized (this)
            {
                timeout.params = params;
            }
        }
        
        void setCallbackAndParams(void* handle, TimeoutCallback callback, Params params)
        {
            Timeout* timeout = cast(Timeout*)handle;
 
            synchronized (this)
            {
                timeout.callback = callback;
                timeout.params = params;
            }
        }
    }
    
private:
    
    Thread thread;
    Timeout*[100] timeouts;
    size_t currentSlot;
    bool run;
    Condition c;
    
    void worker()
    {
        currentSlot = 0;
        long lastTicks = Clock.currStdTime;
        run = true;
        
        c.notify();
        
        while (run)
        {
            Timeout* callList = null;
            long newTicks;
            
            synchronized (this)
            {
                newTicks = Clock.currStdTime;
                long interval = newTicks - lastTicks;
                
                long wheelTicks = interval / 100000;
                
                foreach (i; 0 .. wheelTicks)
                {
                    Timeout* list = timeouts[currentSlot];
                    
                    while (list)
                    {
                        if ((*list).rounds == 0)
                        {
                            Timeout* prev = (*list).prev;
                            Timeout* next = (*list).next;
                            
                            if (prev)
                                (*prev).next = next;
                            else
                                timeouts[currentSlot] = next;
                            
                            if (next)
                                (*next).prev = prev;
 
                            if (callList)
                                (*list).prev = callList;
                            else
                                (*list).prev = null;
                            
                            callList = list;
                        }
                        else
                            (*list).rounds--;
                        
                        list = (*list).next;
                    }
                    
                    currentSlot = (currentSlot + 1) % 100;
                }
                
                lastTicks += wheelTicks * 100000;
            }
            
            while (callList)
            {
                callList.waiting = false;
                
                static if (Params.length)
                    (*callList).callback((*callList).params);
                else
                    (*callList).callback();
                    
                callList = (*callList).prev;
            }
            
            long sleep = 100000 - (Clock.currStdTime - newTicks);
            if (sleep > 0)
                Thread.sleep(sleep.msecs);
        }
    }
}
