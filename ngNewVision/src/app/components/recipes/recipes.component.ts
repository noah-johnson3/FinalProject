import { RecipeService } from './../../services/recipe.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-recipes',
  templateUrl: './recipes.component.html',
  styleUrls: ['./recipes.component.css']
})
export class RecipesComponent implements OnInit {


  //*************************** Setup ******************** */

  constructor(private recipeServ: RecipeService) { }

  ngOnInit(): void {
  }


  //*************************** Page Dynamics ******************** */







  //*************************** Service Methods ******************** */


}
