import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';
import { Comment } from './../models/comment';

@Injectable({
  providedIn: 'root'
})
export class CommentService {

  private url = environment.baseUrl + 'api/comments';



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

  index(blogId: number): Observable<Comment[]> {
    return this.http.get<Comment[]>(this.url + "/" +blogId).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('error finding blog by blogId: ' + err)
      );
      })
    );
  }
  updateComment(id: number, comment: Comment): Observable<Comment> {
    return this.http.put<Comment>(this.url + "/" + id, comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('showBlogsByTopic error: ' + err)
      );
      })
    );
  }


  create(comment: Comment): Observable<Comment> {
    return this.http.post<Comment>(this.url, comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating comment ' + err)
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
              'error deleting comment: ' + err
              )
          );
  })
    );
  }
}
