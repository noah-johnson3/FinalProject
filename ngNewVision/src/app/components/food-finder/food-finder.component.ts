import { TrackedDay } from './../../models/tracked-day';
import { MealService } from './../../services/meal.service';
import { MealTypeService } from './../../services/meal-type.service';
import { SearchQuery } from './../../models/search-query';
import { Nutrients } from './../../models/nutrients';
import { UserService } from './../../services/user.service';
import { UsdaService } from './../../services/usda.service';
import { IngredientService } from './../../services/ingredient.service';
import { Component, OnInit } from '@angular/core';
import { Food } from 'src/app/models/food';
import { Ingredient } from 'src/app/models/ingredient';
import { MealType } from 'src/app/models/meal-type';
import { Meal } from 'src/app/models/meal';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-food-finder',
  templateUrl: './food-finder.component.html',
  styleUrls: ['./food-finder.component.css']
})
export class FoodFinderComponent implements OnInit {
  searchResults: Food [] = [];
  addedIngredients: Ingredient [] = [];
  selectedIngredient: Ingredient = new Ingredient();
  selectedFood: Food = new Food();
  mealNutrients: Nutrients = new Nutrients();
  searchQuery: string = '';
  addedFoods: Food [] = [];
  totalNutrients = new Nutrients();
  mealTypes: MealType [] = [];
  newMeal: Meal = new Meal();
  creatingNewMeal: boolean = true;
  creatingNewRecipe: boolean = false;
  loggedInUser: User = new User();


  constructor(private ingServ: IngredientService, private usdaServ: UsdaService,
    private userServ: UserService, private mts: MealTypeService, private mealServ: MealService) { }

  ngOnInit(): void {
    this.indexMealTypes();
  }
  //************************* Page Dynamics */

  search(query: string){
      this.searchByKeyword(query);

  }

  addFoodToMealOrRecipe(food: Food,){
    this.addedFoods.push(food);
    this.addedIngredients.push(this.usdaServ.converter(food, this.selectedIngredient));
    this.selectedIngredient = new  Ingredient();
    this.mealNutrients = this.calculateMealRecipeNutrients(this.addedIngredients);
  }

  calculateMealRecipeNutrients(ingredients: Ingredient []): Nutrients{
    let nutri: Nutrients = new Nutrients();
     nutri.protein = 0;
     nutri.carbs = 0;
     nutri.calories = 0;
     nutri.fats = 0;
     nutri.sugar = 0;
     nutri.sodium = 0;
     nutri.cholesterol = 0;
    for(let ing of ingredients) {
      if(ing.nutrients){
        nutri.sodium += ing.nutrients.sodium;
        nutri.protein += ing.nutrients.protein;
        nutri.calories += ing.nutrients.calories;
        nutri.carbs += ing.nutrients.carbs;
        nutri.fats += ing.nutrients.fats;
        nutri.sugar += ing.nutrients.sugar;
        nutri.cholesterol += ing.nutrients.cholesterol;
      }

    }
    return nutri;
  }
  //***********************Service Methods


  searchByKeyword(query: string): void {
    let search = new SearchQuery(query);
    this.usdaServ.findFoodByObjectQuery(search).subscribe({
      next: (result) => {
          this.searchResults = result.foods;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  indexMealTypes(): void {
    this.mts.index().subscribe({
      next: (result) => {
          this.mealTypes = result;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  getUser(): void {
    this.userServ.getLoggedInUser().subscribe({
      next: (result) => {
          this.loggedInUser = result;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }

  createMeal(meal: Meal){
    let day = new TrackedDay();
    day.user = this.loggedInUser;
    day.day = new Date();
    meal.ingredients = this.addedIngredients;
    this.mealServ.create(meal).subscribe({
      next: (result) => {
        this.addedFoods = [];
        this.addedIngredients = [];
        this.selectedIngredient = new Ingredient();
        this.selectedFood = new Food();
        console.log(result)
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });

  }
}
