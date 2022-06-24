import { Recipe } from "./recipe";

export class Ingredient {
  id: number;
  name: string;
  recipes: Recipe [];

  constructor(id: number = 0, name: string = '', recipes: Recipe[] = []){
    this.id = id
    this.name = name
    this.recipes = recipes
  }
}
