
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
  //*************************** Setup ******************** */

  constructor(private recipeServ: RecipeService) { }

  ngOnInit(): void {
    this.getRecipes();
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
  }
  updateSelect(){
    this.updating = true;
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
  deleteRecipe(recipeId: number){

  }
}
