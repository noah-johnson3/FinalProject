import { FactoryTarget } from '@angular/compiler';
import { Ingredient } from './ingredient';
import { User } from './user';
export class Recipe {

  id: number;
  link: string;
  timeRequired: number;
  recipeText: string;
  name: string;
  protein: number;
  carbs: number;
  fats: number;
  sodium: number;
  sugar: number;
  calories: number;
  createdAt: Date;
  updatedAt: Date | null;
  imageUrl: string;
  user: User | null;
  ingredients: Ingredient [];

  constructor(id: number = 0, link: string = '', timeRequired: number = 0, recipeText: string = '', name: string = '',
  protein: number = 0, carbs: number = 0, fats: number = 0, sodium: number = 0,
  sugar: number = 0, calories: number = 0, createdAt: Date = new Date(), updatedAt: Date | null = null,
  imageUrl: string = '', user: User | null = null, ingredients: Ingredient [] = []){
    this.id = id
    this.link = link
    this.timeRequired = timeRequired
    this.recipeText = recipeText
    this.name = name
    this.protein = protein
    this.carbs = carbs
    this.fats = fats
    this.sodium = sodium
    this.sugar = sugar
    this.calories = calories
    this.createdAt = createdAt
    this.updatedAt = updatedAt
    this.imageUrl = imageUrl
    this.user = user
    this.ingredients = ingredients
  }
}
