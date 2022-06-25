import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  user: User = new User();
  constructor(private auth: AuthService, private router: Router) { }
  ngOnInit(): void {
  }
  login(u : User): void{
    if(u.username && u.password){
    this.auth.login(u.username, u.password).subscribe({
      next:(loggedInUser)=>{
        this.user = new User();
        this.router.navigateByUrl('/user')
      },
      error:(err)=>{
        console.log('error loggin in: ' + err)
      }
    })
  }
  }
}
