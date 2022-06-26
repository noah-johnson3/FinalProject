import { Ingredient } from './ingredient';
import { MealType } from './meal-type';
import { Nutrients } from './nutrients';
import { Recipe } from './recipe';
import { TrackedDay } from './tracked-day';

export class Meal {
  id: number;
  trackDay: TrackedDay | null;
  mealType: MealType | null;
  recipe: Recipe | null;
  nutrients: Nutrients | null;
  ingredients: Ingredient[];

  constructor(id: number = 0, trackDay: TrackedDay | null = null, mealType: MealType | null = null,
    recipe: Recipe | null = null, nutrients: Nutrients | null = null, ingredients: Ingredient[] = []){
      this.id = id
      this.trackDay = trackDay
      this.mealType = mealType
      this.recipe = recipe
      this.nutrients = nutrients
      this.ingredients = ingredients
    }
}
