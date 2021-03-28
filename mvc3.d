//#not right (two sets of 'display')
import std.stdio, std.string, std.conv, std.typecons;

string getWriteToString(T...)(T args) {
	string result = "";
	foreach( e; tuple( args ).expand )
		result ~= to!string( e );
	return result;
}

void main() {
	float a = 0.33;
	string str = getWriteToString( 1, " ", a, " ", "hay" );
	writeln( str );
	
	auto model = new Model();
	auto view = new View();
	auto controller = new Controller( model, view );
	model.setup( controller );
	view.setup( controller );
	
	controller.run();
}

class Model {
	void setup( Controller controller ) {
		m_controller = controller;
	}
	
	/// Do commands
	///
	/// return true if exit requested
	bool getInput() {
		auto newline = "\n";
		
		m_controller.displayln( "Enter 'h' for help" );
		auto input = readln.chomp;
		switch( input ) {
			case "exit", "q":
			return true;
			case "h":
				m_controller.displayln(
					  "Usage help" ~ newline
					~ "exit/q - quit out" ~ newline 
					~ "add - then eg: 37 3");
			break;
			case "add":
				add();
			break;
			default:
				m_controller.displayln( "No action made." );
			break;
		}
		return false;
	}
	
	void add() {
		int[] nums;
		scope( success ) {
			auto total = 0;
			import std.algorithm;
			total = reduce!"a + b"(0, nums);
			m_controller.displayln( "Total: ", total );
		}
		try {
			m_controller.display( "Enter numbers: " ); stdout.flush; nums =  readln.chomp.split.to!(int[]);
		} catch( Exception e ) {
			m_controller.displayln( "Invalid: ", e );
		}
	}
private:
	Controller m_controller;
	string m_command;
}

class View {
	void setup( Controller controller ) {
		m_controller = controller;
	}
	
	void display(T...)( T str ) {
		write( tuple( str ).expand );
	}
	
	void displayln(T...)( T str ) {
		writeln( tuple( str ).expand );
	}
private:
	Controller m_controller;
}

class Controller {
	this( Model model, View view ) {
		m_model = model;
		m_view = view;
	}
	
	void run() {
		bool exit = false;
		while( ! exit ) {
			exit = model.getInput();
		}
	}
	
	void display(T...)( T str ) {
		view.display( str );
	}
	
	void displayln(T...)( T str ) {
		view.displayln( str );
	}

	@property ref auto model() { return m_model; }
	@property ref auto view() { return m_view; }
private:
	Model m_model;
	View m_view;
}
