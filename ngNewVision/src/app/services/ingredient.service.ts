import { Ingredient } from './../models/ingredient';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Blog } from '../models/blog';
import { Recipe } from '../models/recipe';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class IngredientService {
  private: Ingredient [] = [];
  private url = environment.baseUrl + 'api/ingredients';



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

  index(): Observable<Ingredient[]> {
    return this.http.get<Ingredient[]>(this.url).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index ingredient error: ' + err)
      );
      })
    );
  }
  ingredientByName(name: string): Observable<Ingredient> {
    return this.http.get<Ingredient>(this.url + "/" +name ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('ingredients by name error: ' + err)
      );
      })
    );
  }
//********************************Fix me (get method with request body) */
  // ingredientsByRecipe(recipe: Recipe): Observable<Ingredient[]> {
  //   return this.http.get<Ingredient[]>(this.url + "/recipe" , recipe ).pipe(
  //     catchError((err: any) => {
  //     console.log(err);
  //     return throwError(
  //       () => new Error('showBlogsByTopic error: ' + err)
  //     );
  //     })
  //   );
  // }



  create(ingredient: Ingredient): Observable<Ingredient> {
    return this.http.post<Ingredient>(this.url, ingredient, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating ingredent' + err)
        );
      })
    );
  }

}
