import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Recipe } from '../models/recipe';
import { Topic } from '../models/topic';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class RecipeService {
  private recipes: Recipe [] = [];
  private url = environment.baseUrl + 'api/recipes';



  constructor( private http: HttpClient, private auth: AuthService) { }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }


  listAllRecipes(): Observable<Recipe[]> {
    return this.http.get<Recipe[]>(this.url).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding all recipes : ' + err)
      );
      })
    );
  }
  findRecipeByAuthor(author: string): Observable<Topic[]> {
    return this.http.get<Topic[]>(this.url + "/author/" + author).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding recipes by author : ' + err)
      );
      })
    );
  }
  findRecipesByTime(time: number): Observable<Recipe[]> {
    return this.http.get<Recipe[]>(this.url + "/time/" + time).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding all recipes by time: ' + err)
      );
      })
    );
  }
  findByIngredient(ingredientName: string): Observable<Recipe[]> {
    return this.http.get<Recipe[]>(this.url + "/ingredient/" + ingredientName).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding all topics by keyword: ' + err)
      );
      })
    );
  }
  //******************************FIX ME *************************************
  // findByNutrients(nutrition: Recipe): Observable<ArrayBuffer> {
    //   return this.http.get<ArrayBuffer>(this.url + "/nutrition", nutrition).pipe(
      //     catchError((err: any) => {
        //     console.log(err);
        //     return throwError(
          //       () => new Error(' error finding all topics by keyword: ' + err)
          //     );
          //     })
          //   );
          // }
  //******************************FIX ME *************************************



  createRecipe(recipe: Recipe): Observable<Recipe> {
    return this.http.post<Recipe>(this.url, recipe).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating recipe ' + err)
        );
      })
    );
  }
  updateRecipe(recipe: Recipe): Observable<Recipe> {
    return this.http.put<Recipe>(`${this.url}/${recipe.id}`, recipe).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error updating recipe: ' + err)
        );
      })
    );
  }
  addUser(recipe: Recipe, recipeId: number): Observable<Recipe> {
    return this.http.put<Recipe>(`${this.url}` + "/adduser/" + recipeId , recipe).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error updating recipe: ' + err)
        );
      })
    );
  }

  destroyRecipe(id: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${id}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              'error deleting recipe: ' + err
              )
          );
  })
    );
  }
}
