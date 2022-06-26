import { FactoryTarget } from '@angular/compiler';
import { Ingredient } from './ingredient';
import { User } from './user';
export class Recipe {

  id: number;
  link: string;
  timeRequired: number;
  recipeText: string;
  name: string;

  createdAt: Date;
  updatedAt: Date | null;
  imageUrl: string;
  user: User | null;
  ingredients: Ingredient [];


  constructor(id: number = 0, link: string = '', timeRequired: number = 0, recipeText: string = '', name: string = '',
  createdAt: Date = new Date(), updatedAt: Date | null = null,
  imageUrl: string = '', user: User | null = null, ingredients: Ingredient [] = []){
    this.id = id
    this.link = link
    this.timeRequired = timeRequired
    this.recipeText = recipeText
    this.name = name
    this.createdAt = createdAt
    this.updatedAt = updatedAt
    this.imageUrl = imageUrl
    this.user = user
    this.ingredients = ingredients
  }
}
