import { MealTypeService } from './../../services/meal-type.service';
import { MealService } from './../../services/meal.service';
import { TrackedDay } from './../../models/tracked-day';
import { TrackedDayService } from './../../services/tracked-day.service';
import { UserService } from './../../services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { GenderService } from 'src/app/services/gender.service';
import { Gender } from 'src/app/models/gender';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
  loggedInUser : User | null = null;
  trackedDays: TrackedDay [] = [];
  now : Date = new Date();
  age :  number = 0;
  activityModifiers: number [] = [1.2, 1.375, 1.55, 1.725, 1.9];
  editing: boolean = false;
  editUser: User | null = null;
  genders: Gender [] = [];
  amr: number = 0;
  displayDay : TrackedDay | null = null;

  //************************ Setup Methods ********************* */
  constructor(private auth: AuthService, private userServ: UserService,
    private tds: TrackedDayService, private genderServ: GenderService,
    private mealServ: MealService, private mts: MealTypeService) { }

  ngOnInit(): void {
    this.getUser();
    this.getTrackedDays();
    this.indexGender();

  }

  //******************** Page Dynamics Methods  ******************** */

  calculateMetabolicRate(): number {
    let bmr = 0;
    if(this.loggedInUser?.gender?.id == 1){
        bmr = 447.593 + (9.247 * (0.454* this.loggedInUser.weight)) + (3.098 *(2.54 * this.loggedInUser.height)) - (4.330 * this.age);
        //Ecercise levels: 1 - 1.2, 2 - 1.375, 3 -1.55, 4 - 1.725, 5 - 1.9 //
      }else{
        if(this.loggedInUser)
        bmr = 88.362 + (13.397 * (0.454 * this.loggedInUser.weight)) + (4.799 *(2.54 * this.loggedInUser.height)) - (5.677 * this.age);
    }
    if(this.loggedInUser){
      this.amr = Math.round(bmr * this.activityModifiers[this.loggedInUser?.activityLevel -1]);
    }
    return Math.round(bmr);
  }
  calculateAge(){
    if(this.loggedInUser?.dateOfBirth){
      console.log(this.loggedInUser.dateOfBirth);
      let current = this.now.getFullYear();
      console.log(current);
      let dob = Number.parseInt(this.loggedInUser.dateOfBirth.toString().substring(0,4));
      this.age = current - dob;
    }
  }
  showEdit(){
    this.editing = true;
    this.editUser = this.loggedInUser;
  }
  cancelEdit(){
    this.editing = false;
  }
  showDayDetails(day : TrackedDay){
    if(day){
      this.displayDay = day;
    }
  }
  cancelDetails(){
    this.displayDay = null;
  }

  //*********************Service Methods ************ */
  getUser(){
    this.userServ.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        this.calculateAge();
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }

  getTrackedDays(){
    this.tds.indexByUser().subscribe({
      next: (trackedDays) => {
        this.trackedDays = trackedDays;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }

  updateUser(updatingUser: User){
    if(updatingUser.id){
    this.userServ.updateUser(updatingUser.id, updatingUser).subscribe({
      next: (user) => {
        this.loggedInUser = user;
        this.calculateAge();
        this.editing = false;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
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
