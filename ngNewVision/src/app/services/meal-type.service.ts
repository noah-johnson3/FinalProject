import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { MealType } from '../models/meal-type';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class MealTypeService {
  private meal: MealType [] = [];
  private url = environment.baseUrl + 'api/mealTypes';



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

  index(): Observable<MealType[]> {
    return this.http.get<MealType[]>(this.url).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }

  findMealTypeById(id: number): Observable<MealType> {
    return this.http.get<MealType>(this.url + "/" + id ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('filter goals by achieved: ' + err)
      );
      })
    );
  }


}
