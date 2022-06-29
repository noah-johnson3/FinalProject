import { IngredientService } from './ingredient.service';
import { Food } from './../models/food';
import { SearchQuery } from './../models/search-query';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { Meal } from '../models/meal';
import { AuthService } from './auth.service';
import { Ingredient } from '../models/ingredient';
import { Nutrients } from '../models/nutrients';
import { Result } from '../models/result';

@Injectable({
  providedIn: 'root'
})
export class UsdaService {
  apiKey: string = "api_key=fmdf1lXHyCCMoNNcmnXEt8t9Dgo3W31fOtm9ZDSS"
  url :string = "https://api.nal.usda.gov/fdc/v1/foods"

  searchQuery: SearchQuery = {
    "query": ''
  };

  stringQuery : string = '';

  constructor(private http: HttpClient, private auth: AuthService, private ingServ: IngredientService) { }

  findFoodByStringQuery(query: string): Observable<Result> {
    query.replace(" ", "%20")
    return this.http.get<Result>(this.url + "/search?" + this.apiKey + "&query=" + query ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('error with usda database retrieval: ' + err)
      );
      })
    );
  }


  findFoodByObjectQuery(query: SearchQuery): Observable<Result> {
    return this.http.post<Result>(this.url + "/search?" + this.apiKey , query).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('error with usda database retrieval: ' + err)
      );
      })
    );
  }
  listFoods(): Observable<Result> {
    return this.http.get<Result>(this.url + "/list?" + this.apiKey ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('error with usda database retrieval: ' + err)
      );
      })
    );
  }

  converter(food: Food, ing: Ingredient): Ingredient{
    let nutri: Nutrients = new Nutrients();
    let cf: number = 1;
    // ing.amount = food.servingSize
    if(food.foodNutrients){

        for(let n of food.foodNutrients){
          if(!food.servingSize){
            food.servingSize = ing.amount;
          }
          switch(n.nutrientName){
              case 'Protein':
                nutri.protein = Math.round((ing.amount/food.servingSize)* n.value)
                break;
                case 'Carbohydrate, by difference':
                nutri.carbs =Math.round( (ing.amount/food.servingSize)*n.value);
                break;
                case 'Total lipid (fat)':
                nutri.fats = Math.round((ing.amount/food.servingSize)* n.value);
                break;
                case 'Energy':
                nutri.calories = Math.round((ing.amount/food.servingSize)* n.value);
                break;
                case 'Sugars, total including NLEA':
                nutri.sugar = Math.round((ing.amount/food.servingSize)* n.value);
                break;
                case 'Sodium, Na':
                nutri.sodium = Math.round((ing.amount/food.servingSize)* n.value);
                break;
                case 'Cholesterol':
                nutri.cholesterol = Math.round((ing.amount/food.servingSize)* n.value);
                break;
                default:
                break;
          }

      }
      ing.nutrients = nutri;
      ing.portion = "" + ing.amount + " " + food.servingSizeUnit;
      ing.name = food.description;
    }
    return ing;

  }


}
