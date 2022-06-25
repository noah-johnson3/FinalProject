
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


  //*************************** Setup ******************** */

  constructor(private recipeServ: RecipeService) { }

  ngOnInit(): void {
    this.getRecipes();
  }


  //*************************** Page Dynamics ******************** */
  sortRecipes(){
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





  //*************************** Service Methods ******************** */

  getRecipes(){
    this.recipeServ.listAllRecipes().subscribe({
      next: (recipeArray) => {
        this.allRecipes = recipeArray;
        this.sortRecipes();
      },
      error: (problem) => {
        console.error('getRecipes(): error loading recipe list:');
        console.error(problem);
      }
    });
  }

}
