import { Topic } from './../models/topic';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class TopicService {
  private topics: Topic [] = [];
  private url = environment.baseUrl + 'api/topics';



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

  listAllTopics(): Observable<Topic[]> {
    return this.http.get<Topic[]>(this.url).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding all topics : ' + err)
      );
      })
    );
  }
  findTopicById(topicId: number): Observable<Topic[]> {
    return this.http.get<Topic[]>(this.url + "/idSearch/" + topicId).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding all topics : ' + err)
      );
      })
    );
  }
  findTopicByName(name: string): Observable<Topic[]> {
    return this.http.get<Topic[]>(this.url + "/search/" + name).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding all topics by name: ' + err)
      );
      })
    );
  }
  findTopicByKeyword(keyword: string): Observable<Topic[]> {
    return this.http.get<Topic[]>(this.url + "/keysearch/" +keyword).pipe(
      catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error(' error finding all topics by keyword: ' + err)
      );
      })
    );
  }



  create(topic: Topic): Observable<Topic> {
    return this.http.post<Topic>(this.url, topic, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('error creating comment ' + err)
        );
      })
    );
  }

}
