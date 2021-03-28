enum isValue(alias T) = __traits(compiles, typeof(T));

template isConvertibleToInstanceOf(alias From, alias To)
if(isValue!From)
{
    enum isConvertibleToInstanceOf = 
isConvertibleToInstanceOf!(typeof(From), To);
}

template isConvertibleToInstanceOf(From, alias To)
if(!is(From == struct) && !is(From == class) && !is(From == 
interface))
{
    enum isConvertibleToInstanceOf = false;
}

template isConvertibleToInstanceOf(From, alias To)
if(is(From == struct) || is(From == class) || is(From == 
interface))
{
    // workaround for 
//https://issues.dlang.org/show_bug.cgi?id=14286
    import std.typetuple : anySatisfy;
    enum aliasThisConvertible(string name) = 
isConvertibleToInstanceOf!(mixin("typeof(From." ~ name ~ ")"), 
To);
    enum isConvertibleToInstanceOf =
            anySatisfy!(aliasThisConvertible, 
__traits(getAliasThis, From)) ||
            is(From : To!Args, Args...);
}

void main() {}