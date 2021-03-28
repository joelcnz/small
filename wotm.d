void main() {
	struct Info {
		string text;
		
		string toString() {
			return text;
		}
	}
	
	Info[string] lines;
	lines["W"] = Info("W Would you consider yourself to be a good person?");
	lines["D1"] = Info("D Do you think you have kept the Ten Commandments?");
	lines["J"] = Info("J Judgement -- If God were to judge you by the Ten Commandments, do you think you would be innocent or guilty?");
	lines["D2"] = Info("D Destiny -- Do you think you would go to heaven or hell?");
	
	lines["C"] = Info("C Concern -- Does that concern you?");
	lines["c"] = Info("c Cross -- Jesus suffered for our sins, died and rose from the dead.");
	lines["R"] = Info("R Repentance -- Confess and forsake all sin.");
	lines["A"] = Info("A and");
	lines["F"] = Info("F Faith -- More than belief, it's trust in Jesus for salvation.");
	lines["T"] = Info("T Truth -- Point to the truth of the Bible and encourage them to get right with God today.");

	import std.stdio: writeln;
	writeln("Welcome to Joel's Way of the Master proglet");

	auto notDone = true;
	while(notDone) {
		import std.stdio: readln;
		import std.string: chomp;
		
		string command = readln.chomp;
		if (command in lines) {
			writeln(lines[command]);
			continue;
		}
		
		switch(command) {
			default:
				writeln("q - quit\n" ~
						"h - help");
			break;
			case "h":
				displayHelp;
			break;
			case "q":
				writeln("Quitting..");
				notDone = false;
			break;
		}
	}
}
	
void displayHelp() {
	import std.stdio: writeln;
	
writeln(`WDJD \/b

W Would you consider yourself to be a good person?
D1 Do you think you have kept the Ten Commandments?
J Judgement -- If God were to judge you by the Ten Commandments, do you think you would be innocent or guilty?
D2 Destiny -- Do you think you would go to heaven or hell?


CcRAFT \/b

C Concern -- Does that concern you?
c Cross -- Jesus suffered for our sins, died and rose from the dead.
R Repentance -- Confess and forsake all sin.
A and
F Faith -- More than belief, it's trust in Jesus for salvation.
T Truth -- Point to the truth of the Bible and encourage them to get right with God today.`);
}
