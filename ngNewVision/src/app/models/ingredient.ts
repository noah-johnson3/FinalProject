import { Nutrients } from "./nutrients";
import { Recipe } from "./recipe";

export class Ingredient {
  id: number;
  name: string;
  recipes: Recipe [];
  nutrients: Nutrients | null;
  portion: string;
  amount: number;
  measure: string;

  constructor(id: number = 0, name: string = '', recipes: Recipe[] = [], nutrients: Nutrients | null =  null,
  serving: string = '', amount: number = 0, measure: string = ''){
    this.id = id
    this.name = name
    this.recipes = recipes
    this.nutrients = nutrients;
    this.portion = serving;
    this.amount = amount;
    this.measure = measure;
  }
}
