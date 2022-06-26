import { IngredientService } from './../../services/ingredient.service';
import { Ingredient } from './../../models/ingredient';

import { Component, OnInit } from '@angular/core';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from './../../services/recipe.service';

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
  numRecipeIngredients : number [] = [];
  ingredientToBeAdded: Ingredient | null = null;
  newIngredient: Ingredient = new Ingredient();

  //*************************** Setup ******************** */

  constructor(private recipeServ: RecipeService, private ingServ: IngredientService) { }

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
    this.numRecipeIngredients = [];
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
    console.log(recipe.ingredients)
    recipe.ingredients = this.newRecipeIngredients;
    console.log(recipe.ingredients)
    this.recipeServ.createRecipe(recipe).subscribe({
      next: (recipeArray) => {
        this.newRecipe = null;
        this.getRecipes();
      },
      error: (problem) => {
        console.error('error creating recipe: ');
        console.error(problem);
      }
    });
  }
  updateRecipe(recipe: Recipe){
    this.recipeServ.updateRecipe(recipe).subscribe({
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
}
