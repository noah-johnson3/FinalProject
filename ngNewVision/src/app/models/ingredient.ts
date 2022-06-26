import { Nutrients } from "./nutrients";
import { Recipe } from "./recipe";

export class Ingredient {
  id: number;
  name: string;
  recipes: Recipe [];
  nutrients: Nutrients | null = null;

  constructor(id: number = 0, name: string = '', recipes: Recipe[] = [], nutrients: Nutrients | null =  null){
    this.id = id
    this.name = name
    this.recipes = recipes
    this.nutrients = nutrients;
  }
}
