import { Food } from "./food";

export class Result {
  foods: Food[];

  constructor(foods: Food[] =[]){
    this.foods = foods;
  }
}
