//Design pattern
import std.stdio;

void main() {
	new BreakfastInheritance();
}

class BreakfastBowl {
	Ingredient[] contents;

	void AddDryIngredient(DryIngredient ingredient)
	{
		writeln("AddDryIngredient");
		contents ~= ingredient;
	}

	void PourLiquid(LiquidIngredient ingredient)
	{
		writeln("PourLiquid");
		contents ~= ingredient;
	}
}

abstract class Ingredient
{
	
}

abstract class DryIngredient : Ingredient
{}

class Muesli : DryIngredient
{
}

class Weetbix : DryIngredient
{
}

class Oats : DryIngredient
{
}

abstract class LiquidIngredient : Ingredient
{
	
}

class Milk : LiquidIngredient
{
}

class WeetbixAndMuesliBreakfastFactory
{
	void MakeBreakfast(BreakfastBowl bowl)
	{
		auto weetbixCruncher = new WeetbixCruncher();
		auto weetbix = new Weetbix();
		weetbixCruncher.CrunchWeetbix(weetbix);
		bowl.AddDryIngredient(weetbix);
		bowl.AddDryIngredient(new Muesli());
		bowl.PourLiquid(new Milk());
	}
}

class WeetbixCruncher
{
	void CrunchWeetbix(Weetbix weetbix)
	{
		// crunch it
		writeln("crunch it");
	}
}

class BreakfastInheritance
{
	abstract class Breakfast
	{
		abstract void Prepare();
	}

	class Porridge : Breakfast
	{
		override void Prepare()
		{
			writeln("Prepare");
			// cook
			// pour into plate
			// pour on weetgerm
			// spoon brown sugar
			// pour milk
		}
	}

	abstract class BreakfastWithMilk : Breakfast
	{
		public override void Prepare()
		{
			PrepareDryIngredients();
			PrepareWetIngredients();
		}

		protected abstract void PrepareDryIngredients();


		protected void PrepareWetIngredients()
		{
			writeln("abstact BreakfastWithMilk : Breakfast -> PrepareWetIngredients");
			// pour milk
		}
	}
	class Weetbix : BreakfastWithMilk
	{
		protected override void PrepareDryIngredients()
		{
			writeln("Weetbix : BreakfastWithMilk -> PrepareDryIngredients");
			// crunch up weetbix
			// pour milk;
		}

	}

	class Muesli : BreakfastWithMilk
	{
		protected override void PrepareDryIngredients()
		{
			writeln("Muesli : BreakfastWithMilk -> PrepareDryIngredients");
			// pour muesli
		}
	}

	class WeetbixWithMuesli : BreakfastWithMilk
	{
		protected override void PrepareDryIngredients()
		{
			super.Prepare();
		}
	}
}

class DecoratorBreakfast
{
	 
}
