import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-base-bar',
  templateUrl: './base-bar.component.html',
  styleUrls: ['./base-bar.component.css']
})
export class BaseBarComponent implements OnInit {

  constructor(private auth:AuthService) { }

  ngOnInit(): void {
  }
  loggedIn(): boolean{
    return this.auth.checkLogin();
  }

}
