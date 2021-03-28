struct Variant {}
class Dynamic {}
alias Variant delegate(Dynamic self, Variant[] args...) DynMethod;
void main()
{
    DynMethod dg = delegate Variant(Dynamic, Variant[]) {
        return Variant();
    };
}
