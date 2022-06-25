import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Goal } from '../models/goal';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class GoalService {
  private: Goal [] = [];
  private url = environment.baseUrl + 'api/goals';



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

  indexByUser(userId: number): Observable<Goal[]> {
    return this.http.get<Goal[]>(this.url + "/" + userId, this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
  listGoalsByAchieved(achieved: boolean): Observable<Goal[]> {
    return this.http.get<Goal[]>(this.url + "/filter/" + achieved , this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('filter goals by achieved: ' + err)
      );
      })
    );
  }

  updateGoal(id: number, goal: Goal): Observable<Goal> {
    return this.http.put<Goal>(this.url + "/" + id, goal, this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('error updating goal: ' + err)
      );
      })
    );
  }

  achieveGoal(id: number, goal: Goal): Observable<Goal> {
    return this.http.put<Goal>(this.url + "/achieve/" + id, goal, this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('error updating goal: ' + err)
      );
      })
    );
  }


  create(goal: Goal): Observable<Goal> {
    return this.http.post<Goal>(this.url, goal, this.getHttpOptions()).pipe(
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
