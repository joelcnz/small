// Not mine
import std.stdio, std.typecons, std.array, std.string;

alias double function(double,double) Op;
alias Tuple!(uint, Op) Pair;

double calculate(in string expression, in Pair[immutable char] operators) {
    double newNum, result = 0.0;
    /*
    stack<pair<double, signed char>> s;
    char oldOperator = '\0', newOperator;
    istringstream iss(expression);

    while (true) {
        if (!(iss >> newNum)) {
            iss.clear();
            if (iss.get() == '(') {
                s.push(make_pair(result, -oldOperator));
                oldOperator = '\0';
                continue;
            } else
                throw invalid_argument("ERROR");
        }
NEXT:
        if (!(iss >> newOperator))
            break;
        if (operators.find(newOperator) == operators.end()) {
            if (newOperator == ')') {
                result = operators.find(oldOperator)->second.second(result, newNum);
                while (true) {
                    if (s.empty())
                        throw invalid_argument("XXXXXXX");
                    if (s.top().second > 0) {
                        result = operators.find(s.top().second)->second.second(s.top().first, result);
                        s.pop();
                    } else {
                        oldOperator = -s.top().second;
                        newNum = result;
                        result = s.top().first;
                        s.pop();
                        goto NEXT;
                    }
                }
            } else
                throw invalid_argument("?????");
        }

        if (operators.find(newOperator)->second.first > operators.find(oldOperator)->second.first) {
            s.push(make_pair(result, oldOperator));
            result = newNum;
        } else {
            result = operators.find(oldOperator)->second.second(result, newNum);
            if (operators.find(newOperator)->second.first<operators.find(oldOperator)->second.first) {
                while (!s.empty() && s.top().second > 0 &&
                       operators.find(newOperator)->second.first < operators.find(s.top().second)->second.first) {
                    result = operators.find(s.top().second)->second.second(s.top().first, result);
                    s.pop();
                }
            }
        }

        oldOperator = newOperator;
    }

    result = operators.find(oldOperator)->second.second(result, newNum);

    while (!s.empty()) {
        if (s.top().second <= 0)
            throw invalid_argument("YYYYYYYY");
        result = operators.find(s.top().second)->second.second(s.top().first, result);
        s.pop();
    }
    */

    return result;
}

void main() {
    Pair[immutable char] operators;
    operators['+'] =  Pair(1, (double a, double b) => a + b);
    operators['-'] =  Pair(1, (double a, double b) => a - b);
    operators['*'] =  Pair(2, (double a, double b) => a * b);
    operators['/'] =  Pair(2, (double a, double b) => a / b);
    operators['^'] =  Pair(3, (double a, double b) => a ^^ b);
    operators['\0'] = Pair(uint.max, (double a, double b) => b);

    foreach (line; stdin.byLine())
        if (!line.strip().empty) {
            writeln(calculate(line.idup, operators));
            return;
        }
}
