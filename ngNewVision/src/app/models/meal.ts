import { MealType } from './meal-type';
import { Recipe } from './recipe';
import { TrackedDay } from './tracked-day';

export class Meal {
  id: number;
  trackDay: TrackedDay | null;
  mealType: MealType | null;
  recipe: Recipe | null;

  constructor(id: number = 0, trackDay: TrackedDay | null = null, mealType: MealType | null = null,
    recipe: Recipe | null = null){
      this.id = id
      this.trackDay = trackDay
      this.mealType = mealType
      this.recipe = recipe
    }
}
