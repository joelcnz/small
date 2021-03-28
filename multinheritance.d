//Org: based on page 232 (6.13.1) in The D Programming Language book
//#save(); without storeShape does not work
import std.stdio;

class Shape {
	void shape() {
		writeln( "Shape" );
	}
}

class DataBase {
	void save() {
		writeln( "I'm the top - save" );
	}
}

class StoreShape : Shape {
	private class MyDataBase : DataBase {
		override void save() {
			super.save();
			writeln( "Data base: save" );
		}
	}
	
	private MyDataBase _store;
	alias _store this;
	
	this() {
		_store = this.new MyDataBase;
	}
}

void main() {
	auto storeShape = new StoreShape;
	
	with( storeShape ) {
		shape();
		storeShape.save(); //#save(); without storeShape. does not work
	}
}
