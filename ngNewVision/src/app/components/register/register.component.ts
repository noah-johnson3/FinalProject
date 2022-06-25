import { GenderService } from './../../services/gender.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Gender } from 'src/app/models/gender';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  newUser: User = new User();
  genders: Gender[] = [];

  constructor(private authServ: AuthService, private router: Router, private genderServ: GenderService) { }

  ngOnInit(): void {
    this.indexGender();
  }


  register(u: User): void{
    this.authServ.register(u).subscribe({
      next: (registeredUser) => {
        if(u.username && u.password){
        this.authServ.login(u.username, u.password).subscribe({
          next:(loggedInUser)=>{
            this.router.navigateByUrl('/home')
          }
        })
      }
      },
      error: (problem) => {
        console.error('HttpComponent.reload(): error registering');
        console.error(problem);
      }
    });
  }
  indexGender(): void{
    this.genderServ.index().subscribe({
      next: (genders) => {
       this.genders = genders;
      },
      error: (problem) => {
        console.error('HttpComponent.reload(): error registering');
        console.error(problem);
      }
    });
  }

}
