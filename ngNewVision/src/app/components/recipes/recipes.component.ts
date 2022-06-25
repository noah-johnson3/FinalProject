
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

}
