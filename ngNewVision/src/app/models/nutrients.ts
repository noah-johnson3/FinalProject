export class Nutrients {

  id: number;
  protein: number;
  carbs: number;
  fats: number;
  sodium: number;
  sugar: number;
  calories: number;
  cholesterol: number;

  constructor(protein: number = 0, carbs: number = 0, fats: number = 0, sodium: number = 0,
    sugar: number = 0, calories: number = 0, id: number = 0, cholesterol: number = 0){
    this.protein = protein;
    this.carbs = carbs;
    this.fats = fats;
    this.sodium = sodium;
    this.sugar = sugar;
    this.calories = calories;
    this.id = id;
    this.cholesterol = cholesterol;
    }
}
