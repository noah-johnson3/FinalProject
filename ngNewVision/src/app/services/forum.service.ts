import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { ForumPost } from '../models/forum-post';
import { Goal } from '../models/goal';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class ForumService {

  private url = environment.baseUrl + 'api/forums';



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

  getParentForums(): Observable<ForumPost[]> {
    return this.http.get<ForumPost[]>(this.url).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
  getParentForumsByTopic(topic: string): Observable<ForumPost[]> {
    return this.http.get<ForumPost[]>(this.url + "/topic/" + topic).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
  getForumResponses(id: number): Observable<ForumPost[]> {
    return this.http.get<ForumPost[]>(this.url + "/responses/" + id).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
  createForum(post :ForumPost): Observable<ForumPost> {
    return this.http.post<ForumPost>(this.url , post,this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
  updateForum(post :ForumPost, id: number): Observable<ForumPost> {
    return this.http.put<ForumPost>(this.url + "/" + id , post,this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
  deleteForum(id: number): Observable<ForumPost> {
    return this.http.delete<ForumPost>(this.url + "/" + id ,this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index goal error: ' + err)
      );
      })
    );
  }
}
