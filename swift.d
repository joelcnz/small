//: A Cocoa based Playground to present user interface
// YouTube: Swift Programming Tutorial for Beginners (Full Tutorial)

import std;
import jmisc;

void main() {
	auto num = 3;
	writeln("house ", num * 10);
	writeln("shed ", num / 3);

	auto labels = ["house", "shed","black bird"];
	labels.writeln;

	auto str = "Hello, smalls";

	writeln(str);

	str ~= " - this is appended";

	writeln(str);

	writeln("\nList:");
	foreach(i; 0 .. labels.length) {
	    writeln(labels[i]);
	}
	writeln;
	writeln("\nList 2:");
	foreach(label; labels) {
	    writeln(label);
	}
	writeln;

	auto a = 1;
	auto b = 2;

	a = 2;

	writeln(a + b);
	writeln(a - b);
	writeln(a * b);
	writeln(a / b);

	immutable daysOfWeek = 7;

	auto cats = ["Pudge", "Scratchy", "Bag of rotten onions"];

	writeln(cats);

	void afunction() {
	    writeln("afunction called");
	}

	auto add(T1,T2)(T1 x, T2 y){
	    return x + y;
	}

	afunction();

	writeln(a,"+",b,"=",add(a,b));

	immutable age = 50;

	if (age > 12) {
	    writeln("At ", age, ", are you not a kid any more?");
	}

	auto someCharacter =  'a';

	switch(someCharacter) {
	    case 'a': writeln("'a' what?"); break;
	    case 'c': writeln("Sea"); break;
	    default: writeln("No, it's your fault!");
	}

	struct InterestingNumbers(T) {
		string type;
		T[] nums;
	}
	InterestingNumbers!(int)[] interNums = [
		{"Prime",[2, 3, 5, 7, 11, 13]},
	    {"Fibonacci", [1, 1, 2, 3, 5, 8]},
	    {"Square", [1, 4, 9, 16, 25]}
	];

	auto least = int.max;
	auto greatest = int.min;
	//for (kind, numbers) in interestingNumbers {
	interNums.writeln;
	foreach(s; interNums) {
	    foreach(n; s.nums) {
	        if (n < least)
	            least = n;
			if (n > greatest)
				greatest = n;
	    }
	}
	mixin(jm_trace("least greatest".split));

		/+
	immutable interestingNumbers = [
	    "Prime": [2, 3, 5, 7, 11, 13],
	    "Fibonacci": [1, 1, 2, 3, 5, 8],
	    "Square": [1, 4, 9, 16, 25],
	]
	var smallest = Int.max
	//for (kind, numbers) in interestingNumbers {
	for (_, numbers) in interestingNumbers {
	    for number in numbers {
	        if number < smallest {
	            smallest = number
	        }
	    }
	}
	print(smallest)

	var m = 2
	repeat {
	    m *= 2
	} while m < 100
	print(m)

	var total = 0
	for i in 0..<4 {
	    total += i
	}
	print(total)

	func greet(person: String, day: String) -> String {
	    return "Hello \(person), today is \(day)."
	}
	greet(person: "Bob", day: "Tuesday")

	func minAndMax(nums:[Int]) -> (min:Int,max:Int) {
	    var mx = 0
	    var mn = Int.max
	    for n in nums {
	        if n < mn {
	            mn = n
	        }
	        if n > mx {
	            mx = n
	        }
	    }
	    return (mn,mx)
	}

	let stats = minAndMax(nums: [4,7,2,5,4,9])

	print("min \(stats.min), max \(stats.max)")

	let numbers = [10,50,20,65,48]
	struct TwoNums {
	    var a = 0
	    var b = 0
	    init(a:Int, b:Int) {
	        self.a = a
	        self.b = b
	    }
	}

	var twoNums = [TwoNums(a:50,b:8),TwoNums(a:10,b:2),TwoNums(a:23,b:30),TwoNums(a:90,b:7)]

	// how do you sort like twoNums.sort!((x,y) => x.a > y.b);
	let sortedTwoNums = twoNums.sorted { $0.a > $1.a }
	var tns = ""
	var i = 0
	for tn in sortedTwoNums {
	    tns = String(tns) + String(tn.a)+(i == sortedTwoNums.count - 1 ? "" : ",");
	    i += 1
	}
	print(tns)

	let sortedNumbers = numbers.sorted { $0 > $1 }
	print(sortedNumbers)
		+/
}