import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Meal } from '../models/meal';
import { TrackedDay } from '../models/tracked-day';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class MealService {
  private meal: Meal [] = [];
  private url = environment.baseUrl + 'api/meals';



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

  indexByDay(day: TrackedDay): Observable<Meal[]> {
    return this.http.get<Meal[]>(this.url + "/byDay", this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }

  findMealById(id: number): Observable<Meal> {
    return this.http.get<Meal>(this.url + "/" + id , this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('filter goals by achieved: ' + err)
      );
      })
    );
  }



  create(meal: Meal): Observable<Meal> {
    return this.http.post<Meal>(this.url, meal, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating goal ' + err)
        );
      })
    );
  }
  destroy(id: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              'error deleting blog: ' + err
              )
          );
  })
    );
  }
}
