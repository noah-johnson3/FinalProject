import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Gender } from '../models/gender';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class GenderService {
  private meal: Gender [] = [];
  private url = environment.baseUrl + 'api/genders';



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

  index(): Observable<Gender[]> {
    return this.http.get<Gender[]>(this.url).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index gender error: ' + err)
      );
      })
    );
  }

  findMealTypeById(id: number): Observable<Gender> {
    return this.http.get<Gender>(this.url + "/" + id ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('filter goals by achieved: ' + err)
      );
      })
    );
  }


}
