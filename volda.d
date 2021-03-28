//not work!
// Org: Voldemort http://forum.dlang.org/thread/CALBgG1XRAnHx+U6afFffMF4d5rXM04Uxm5DELR9a3bjjyaf7_w@mail.gmail.com#post-mailman.2060.1335120199.4860.digitalmars-d:40puremagic.com
module volda;

class Set(T)
{
public:
   auto opIndex(T datum_)
   {
       struct Command
       {
       public:
           alias _datum this;

           bool contains() @property
           {
               return (_datum in _set) !is null;
           }

           void add()
           {
               _set._data[_datum] = false;
           }

           void remove()
           {
               _set._data.remove(_datum);
           }

       private:
           Set _set;
           T _datum;
       }
   }

private:
  bool[T] _data;
}

void main() {
	auto s = new Set!int;
	assert(!s[6].contains);
	s[6].add();
	assert(s[6].contains);
	s[6].remove();
	assert(!s[6].contains);
}