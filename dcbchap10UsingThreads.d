// notice atomicOp!"+="(shareCount, 1);

import core.thread;
import core.atomic;
import std.stdio;

int count = 0;
shared(int) sharedCount = 0;

// this is the function that will run in our threads
void threadedFunction() {
  foreach(i; 0 .. 5) {
    writeln("thread running ", count++, " global: ", sharedCount);
    Thread.sleep(1.seconds);
    atomicOp!"+="(sharedCount, 1);
  }
}

void main() {
  auto thread = new Thread(&threadedFunction);
  thread.start();

  Thread.sleep(1500.msecs);

  auto thread2 = new Thread(&threadedFunction);
  thread2.start();
}

