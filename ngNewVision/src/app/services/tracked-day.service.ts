import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { TrackedDay } from '../models/tracked-day';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TrackedDayService {
  private day : TrackedDay [] = [];
  private url = environment.baseUrl + 'api/trackedDay';



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

  indexByUser(): Observable<TrackedDay[]> {
    return this.http.get<TrackedDay[]>(this.url + "/user").pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
  findDayById(id: number): Observable<TrackedDay[]> {
    return this.http.get<TrackedDay[]>(this.url + "/" + id ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('filter goals by achieved: ' + err)
      );
      })
    );
  }

  updateDay(id: number, day: TrackedDay): Observable<TrackedDay> {
    return this.http.put<TrackedDay>(this.url + "/" + id, day).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('error updating goal: ' + err)
      );
      })
    );
  }


  create(day: TrackedDay): Observable<TrackedDay> {
    return this.http.post<TrackedDay>(this.url, day).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating goal ' + err)
        );
      })
    );
  }

}

