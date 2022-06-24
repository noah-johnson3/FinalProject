import { AuthService } from './auth.service';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Blog } from '../models/blog';

@Injectable({
  providedIn: 'root'
})
export class BlogService {
  private: Blog [] = [];
  private url = environment.baseUrl + 'api/blogs';



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

  index(): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('index blog error: ' + err)
      );
      })
    );
  }
  blogsByTopic(topic: string): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url + "/Topic/" + topic ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('showBlogsByTopic error: ' + err)
      );
      })
    );
  }
  listBlogsByAuthor(author: string): Observable<Blog[]> {
    return this.http.get<Blog[]>(this.url + "/Author/" + author ).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('showBlogsByTopic error: ' + err)
      );
      })
    );
  }
  updateBlog(id: number, blog: Blog): Observable<Blog> {
    return this.http.put<Blog>(this.url + "/" + id, blog).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('showBlogsByTopic error: ' + err)
      );
      })
    );
  }


  create(blog: Blog): Observable<Blog> {
    return this.http.post<Blog>(this.url, blog).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating blog ' + err)
        );
      })
    );
  }
  destroy(id: number): Observable<void> {
    return this.http.delete<void>(`${this.url}/${id}`).pipe(
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
