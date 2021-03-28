enum {
    ENCODABLE = "ENCODABLE",
};
alias string[string] Row;
template Tuple(T...) { alias T Tuple; }
template isValueInTuple(string s, T...) {
    static if (T.length == 0) {
        enum bool isValueInTuple = false;
    } else static if (T.length == 1) {
        static if (is(typeof(T[0]) == typeof(s))) {
            enum bool isValueInTuple = T[0] == s;
        } else {
            enum bool isValueInTuple = false;
        }
    } else {
        enum bool isValueInTuple = isValueInTuple!(s, T[0]) || isValueInTuple!(s, T[1..$]);
    }
}
template GenEncodables(U) {
    string GenEncodables() {
        string ret = "alias Tuple!(";
        int fn = 0;
        foreach (index, field; __traits(allMembers, U)) {
            static if (field != "Monitor") { // better way to avoid compilation errors here?
                static if (isAssignable!(typeof(mixin(U.stringof~"."~field)))) {
                    static if (isValueInTuple!(ENCODABLE, __traits(getAttributes, mixin(U.stringof~"."~field)))) {
                        if (fn++)
                            ret ~= ",";
                        ret ~= `"`~field~`"`;
                    }
                }
            }
        }
        ret ~= ") encodables;";
        return ret;
    }
}
mixin template Encodables() {
    mixin(GenEncodables!(typeof(this)));
}


class A {
    @ENCODABLE string name;
    @ENCODABLE int x;
    int *p;

    this() {}

    mixin Encodables; // must come after this() definition, apparently!

    this(Row row) {
        foreach (var; encodables) {
            pragma(msg, "Reading parameter "~var~" from row");
            __traits(getMember, this, var) = to!(typeof(__traits(getMember, this, var)))(row[var]);
        }
    }
}
