import { GenderService } from './gender.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  private topics: User [] = [];
  private url = environment.baseUrl + 'api/users';



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

  getLoggedInUser():Observable<User>{

      return this.http.get<User>(this.url + "/loggedIn", this.getHttpOptions()).pipe(
        catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(' error finding all topics : ' + err)
        );
        })
      );
  }
  updateUser(id: number, user: User):Observable<User>{
      return this.http.put<User>(this.url + "/" + id, user ,this.getHttpOptions()).pipe(
        catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(' error finding all topics : ' + err)
        );
        })
      );
  }


}
