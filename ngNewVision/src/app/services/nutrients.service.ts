import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Nutrients } from '../models/nutrients';
import { Recipe } from '../models/recipe';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class NutrientsService {
  private url = environment.baseUrl + 'api/nutrients';

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

  createNutrient(nutrient: Nutrients): Observable<Nutrients> {
    console.log(nutrient)
    return this.http.post<Nutrients>(this.url, nutrient, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating nutrient ' + err)
        );
      })
    );
  }

  updateNutrient(nutrient: Nutrients): Observable<Nutrients> {
    return this.http.put<Nutrients>(this.url, nutrient, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error updating nutrient: ' + err)
        );
      })
    );
  }

  findNutrientById(id: number): Observable<Nutrients> {
    return this.http.get<Nutrients>(this.url + "/" + id ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('Find by nutrient id error: ' + err)
      );
      })
    );
  }
  findNutrientByMealId(id: number): Observable<Nutrients> {
    return this.http.get<Nutrients>(this.url + "/meal/" + id ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('Find by nutrient id error: ' + err)
      );
      })
    );
  }
  findNutrientByMealsWithIngredId(id: number): Observable<Nutrients[]> {
    return this.http.get<Nutrients[]>(this.url + "/meal/ingredients/" + id).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('Find by nutrient id error: ' + err)
      );
      })
    );
  }
  findNutrientByRecipeWithIngredId(id: number): Observable<Nutrients[]> {
    return this.http.get<Nutrients[]>(this.url + "/recipe/ingredients/" + id).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('Find by nutrient id error: ' + err)
      );
      })
    );
  }
  findNutrientByIngredId(id: number): Observable<Nutrients> {
    return this.http.get<Nutrients>(this.url + "/ingredient/" + id ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('Find by nutrient id error: ' + err)
      );
      })
    );
  }


}
