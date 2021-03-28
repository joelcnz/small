import core.stdc.stdio;

void f(T:T)(T t) if(is(T == int)) { printf("case int\n"); }
void f(T:T)(T t) if(is(T == uint)) { printf("case uint\n"); }
void f(T)(T t) { printf("case default\n"); }

void main()
{
    f(1);
    f(1u);
    f(1.0);
}

