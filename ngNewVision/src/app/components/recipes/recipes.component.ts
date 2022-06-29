import { NutrientsService } from './../../services/nutrients.service';
import { UsdaService } from './../../services/usda.service';
import { IngredientService } from './../../services/ingredient.service';
import { Ingredient } from './../../models/ingredient';

import { Component, OnInit } from '@angular/core';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from './../../services/recipe.service';
import { Food } from 'src/app/models/food';
import { Nutrients } from 'src/app/models/nutrients';
import { SearchQuery } from 'src/app/models/search-query';

@Component({
  selector: 'app-recipes',
  templateUrl: './recipes.component.html',
  styleUrls: ['./recipes.component.css']
})
export class RecipesComponent implements OnInit {

  allRecipes: Recipe [] = [];
  arrayOfRecipeArray: Recipe [] [] = [];
  selectedRecipe: Recipe | null = null;
  ingredientName: string = '';
  time: number | null = null;
  authorName: string = '';
  newRecipe: Recipe | null = null;
  updating: boolean = false;
  allIngredients : Ingredient [] = [];
  newRecipeIngredients : Ingredient [] = [];
  ingredientToBeAdded: Ingredient | null = null;
  newIngredient: Ingredient = new Ingredient();
  //**************USDA Fields ********************/
  searchResults: Food [] = [];
  addedIngredients: Ingredient [] = [];
  selectedIngredient: Ingredient = new Ingredient();
  selectedFood: Food = new Food();
  recipeNutrients: Nutrients = new Nutrients();
  searchQuery: string = '';
  addedFoods: Food [] = [];
  totalNutrients = new Nutrients();
  creatingNewMeal: boolean = true;

  //*************************** Setup ******************** */

  constructor(private recipeServ: RecipeService, private ingServ: IngredientService,
    private usdaServ: UsdaService, private nutriServ: NutrientsService) { }

  ngOnInit(): void {
    this.getRecipes();
    this.getAllIngredients();
  }


  //*************************** Page Dynamics ******************** */
  sortRecipes(){
    this.arrayOfRecipeArray = [];
    while(this.allRecipes.length > 0){
      let tempArray: Recipe[] = [];
      for(let x = 0; x < 3 && this.allRecipes.length > 0; x++){
        let recipeHeld: Recipe | undefined = this.allRecipes.pop();
        if(recipeHeld){
          tempArray.push(recipeHeld);
        }
      }
      this.arrayOfRecipeArray.push(tempArray);

    }

  }
  selectRecipe(recipe: Recipe){
    this.selectedRecipe = recipe;
  }
  cancelSelect(){
    this.selectedRecipe = null;
  }
  setTime(time : number){
    this.time = time;
  }
  resetTime(){
    this.time = null;
  }
  creatingRecipe(){
    this.newRecipe = new Recipe();
  }
  cancelCreate(){
    this.newRecipe = null;
    this.newRecipeIngredients = [];
  }
  updateSelect(){
    this.updating = true;
    if(this.selectedRecipe?.ingredients){
      this.newRecipeIngredients = this.selectedRecipe?.ingredients;
    }
  }
  cancelUpdate(){
    this.updating = false;
    this.newRecipeIngredients = [];
  }

  removeIngredient(ing : Ingredient){
    if(this.newRecipeIngredients){
      for(let idx = 0; idx < this.newRecipeIngredients.length; idx ++){
        if(this.newRecipeIngredients[idx] == ing){
            this.newRecipeIngredients.splice(idx, 1);
            break;
        }
      }
    }
    else if(this.selectedRecipe){
      for(let idx = 0; idx < this.selectedRecipe.ingredients.length; idx ++){
        if(this.selectedRecipe.ingredients[idx] == ing){
            this.selectedRecipe.ingredients.splice(idx, 1);
            break;
        }
      }
    }
  }

  addIngredient(){
    console.log(this.ingredientToBeAdded)
    if(this.ingredientToBeAdded){
      if(this.newRecipeIngredients){
        this.newRecipeIngredients.push(this.ingredientToBeAdded);
      }
       else if(this.selectedRecipe){
        this.selectedRecipe.ingredients.push(this.ingredientToBeAdded);
        }
      }
    }


  //*************************** Service Methods ******************** */

  getRecipes(){
    this.recipeServ.listAllRecipes().subscribe({
      next: (recipeArray) => {
        this.allRecipes = recipeArray;
        this.sortRecipes();
        this.ingredientName = '';
        this.time = null;
      },
      error: (problem) => {
        console.error('getRecipes(): error loading recipe list:');
        console.error(problem);
      }
    });
  }
  getRecipesByIngredient(ingredientName: string){
    this.recipeServ.findByIngredient(ingredientName).subscribe({
      next: (recipeArray) => {
        this.allRecipes = recipeArray;
        this.sortRecipes();
      },
      error: (problem) => {
        console.error('getRecipes(): error loading recipe list by ingredient');
        console.error(problem);
      }
    });
  }
  getRecipesByTime(time: number | null){
    if(time){

      this.recipeServ.findRecipesByTime(time).subscribe({
        next: (recipeArray) => {
          this.allRecipes = recipeArray;
          this.sortRecipes();
        },
        error: (problem) => {
          console.error('getRecipes(): error loading recipe list by ingredient');
          console.error(problem);
        }
      });
    }
  }
  getRecipesByAuthor(authorName: string){
    if(authorName){
      this.recipeServ.findRecipeByAuthor(authorName).subscribe({
        next: (recipeArray) => {
          this.allRecipes = recipeArray;
          this.authorName = '';
          this.sortRecipes();
        },
        error: (problem) => {
          console.error('getRecipes(): error loading recipe list by ingredient');
          console.error(problem);
        }
      });
    }
  }
  createRecipe(recipe: Recipe){
    console.log(recipe.nutrients?.id);
    console.log(recipe)
    this.recipeServ.createRecipe(recipe).subscribe({
      next: (recipeArray) => {
        this.newRecipe = null;
        this.getRecipes();
        this.recipeNutrients = new Nutrients();
      },
      error: (problem) => {
        console.error('error creating recipe: ');
        console.error(problem);
      }
    });
  }
  createRecipeNutrients(nutri : Nutrients, recipe: Recipe){
    recipe.ingredients = this.newRecipeIngredients;
    recipe.nutrients = this.recipeNutrients;
    console.log(nutri)
    this.nutriServ.createNutrient(nutri).subscribe({
      next: (nutrition) => {
        console.log(nutrition)
        console.log(nutrition.id)
        recipe.nutrients = nutrition;
        // this.recipeNutrients = new Nutrients();
        if(this.newRecipe){
          console.log(recipe)
          this.createRecipe(recipe);
        }else if(this.updating){
          console.log("updating")
          this.updateRecipe(recipe);
        }
      },
      error: (problem) => {
        console.error('error creating recipe: ');
        console.error(problem);
      }
    });
  }
  updateRecipe(recipe: Recipe){
    for(let ing of recipe.ingredients){
      console.log(ing.name)
    }
    console.log("recipe:"+ recipe.name)
    recipe.ingredients = this.newRecipeIngredients;
    this.recipeServ.updateRecipe(recipe).subscribe({
      next: (recipeArray) => {
        this.updating = false;
        this.getRecipes();
        this.selectedRecipe = null;
        this.recipeNutrients = new Nutrients();
        this.newRecipeIngredients = [];
      },
      error: (problem) => {
        console.error('error updating recipe: ');
        console.error(problem);
      }
    });
  }
  addSelect(recipe: Recipe){
    this.recipeServ.addUser(recipe, recipe.id).subscribe({
      next: (recipeArray) => {
        this.updating = false;
        this.getRecipes();
        this.selectedRecipe = null;
      },
      error: (problem) => {
        console.error('error updating recipe: ');
        console.error(problem);
      }
    });
  }
  deleteSelect(recipeId: number){
    this.recipeServ.destroyRecipe(recipeId).subscribe({
      next: (recipeArray) => {
        this.selectedRecipe = null;
        this.getRecipes();
      },
      error: (problem) => {
        console.error('error updating recipe: ');
        console.error(problem);
      }
    });

  }
  getAllIngredients(){
    this.ingServ.index().subscribe({
      next: (ingredientArray) => {
        this.allIngredients = ingredientArray;
      },
      error: (problem) => {
        console.error('error updating recipe: ');
        console.error(problem);
      }
    });
  }
  createIngredient(ingredient: Ingredient){
    this.ingServ.create(ingredient).subscribe({
      next: (ingredientArray) => {
        this.newIngredient = new Ingredient();
        this.getAllIngredients();
      },
      error: (problem) => {
        console.error('error updating recipe: ');
        console.error(problem);
      }
    });
  }

  //************************  USDA Service ****************************** */

//************************* Page Dynamics */

search(query: string){
  this.searchByKeyword(query);

}

addFoodToMealOrRecipe(food: Food){
this.addedFoods.push(food);
this.newRecipeIngredients.push(this.usdaServ.converter(food, this.selectedIngredient));
this.selectedIngredient = new  Ingredient();
this.recipeNutrients = this.calculateMealRecipeNutrients(this.newRecipeIngredients);
this.searchQuery = '';
this.searchResults = [];
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



}
