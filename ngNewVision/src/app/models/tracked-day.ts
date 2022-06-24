import { identifierName } from "@angular/compiler";
import { Meal } from "./meal";
import { User } from "./user";

export class TrackedDay {

  id: number;
  day: Date;
  user: User | null;
  meals: Meal [];

  constructor(id: number = 0, day: Date = new Date(), user: User | null = null,
  meals: Meal [] = []){
    this.id = id
    this.day = day
    this.user = user
    this.meals = meals
  }
}
