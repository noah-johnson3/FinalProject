import { GoalService } from './../../services/goal.service';
import { RecipeService } from './../../services/recipe.service';
import { IngredientService } from './../../services/ingredient.service';
import { Ingredient } from './../../models/ingredient';
import { Nutrients } from './../../models/nutrients';
import { NutrientsService } from './../../services/nutrients.service';
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
import { Meal } from 'src/app/models/meal';
import { MealType } from 'src/app/models/meal-type';
import { Recipe } from 'src/app/models/recipe';
import { Goal } from 'src/app/models/goal';


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
  newMeal: Meal = new Meal();
  newMealNutrients: Nutrients = new Nutrients();
  newMealIngredient: Ingredient[] = [];
  allIngredient: Ingredient[] = [];
  newIngredient: Ingredient = new Ingredient();
  mealTypes: MealType [] = [];
  showingRecipes: boolean = false;
  showingTracker: boolean = true;
  showingAddMeal: boolean = false;
  selectedRecipe: Recipe | null = null;
  newGoal: Goal = new Goal();


  //************************ Setup Methods ********************* */
  constructor(private auth: AuthService, private userServ: UserService,
    private tds: TrackedDayService, private genderServ: GenderService,
    private mealServ: MealService, private mts: MealTypeService, private nts: NutrientsService,
    private ingServ: IngredientService, private recipeServ: RecipeService, private goalServ: GoalService) { }

  ngOnInit(): void {
    this.getUser();
    this.getTrackedDays();
    this.indexGender();
    this.indexIngred();
    this.indexMealTypes();
    this.getFavoriteRecipes();



  }

  //******************** Page Dynamics Methods  ******************** */

  showTracker(){
    this.showingTracker = true;
    this.showingRecipes = false;
    this.showingAddMeal = false;
    this.editing = false;
    this.editUser = null;
  }
  viewRecipes(){
    this.showingTracker = false;
    this.showingRecipes = true;
    this.showingAddMeal = false;
    this.editing = false;
    this.editUser = null;
  }
  showAddMeal(){
    this.showingTracker = false;
    this.showingRecipes = false;
    this.showingAddMeal = true;
    this.editing = false;
    this.editUser = null;
  }

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
    this.showingRecipes = false;
    this.showingAddMeal = false;
    this.showingTracker = false
  }
  showRecipe(recipe: Recipe){
    this.selectedRecipe = recipe;
  }
  stopShowRecipe(recipe: Recipe){
    this.selectedRecipe = null;
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

  checkCurrentDay(): boolean  {
  let today = new Date();
  let result = false;
  console.log(today);
  for (let day of this.trackedDays){
    console.log(day.day)
    if(Number.parseInt(day.day.toString().substring(0,4)) == today.getFullYear()) {

      if(Number.parseInt(day.day.toString().substring(5,7)) == (today.getMonth() + 1)) {
        if(Number.parseInt(day.day.toString().substring(8,10)) == today.getDate()) {
          result = true;
        }
      }
    }
  }
  console.log(result)
  return result;
  }

  getCurrentDay(): TrackedDay {
    let today = new Date();
    let result = new TrackedDay();

  for (let day of this.trackedDays){
    if(Number.parseInt(day.day.toString().substring(0,4)) == today.getFullYear()) {
      if(Number.parseInt(day.day.toString().substring(5,7)) == (today.getMonth()+1)) {
        if(Number.parseInt(day.day.toString().substring(8,10)) == today.getDate()) {
          result = day;
        }
      }
    }
  }
  return result;

  }

  createCurrentDay(): void {
    let today = new TrackedDay();
    today.day = new Date();
    console.log(today.day)
    if(!this.checkCurrentDay()) {
      console.log("starting")
      this.createTrackedDay(today);
    }
  }

  addNewIngredientToMeal(ingred: Ingredient) {
    this.newMealIngredient.push(ingred);
    this.newIngredient = new Ingredient();
  }
  removeIngredient(ingred: Ingredient) {
    if(this.newMealIngredient) {
      for(let i = 0; i < this.newMealIngredient.length; i++) {
        if(this.newMealIngredient[i].name == ingred.name) {
          this.newMealIngredient.splice(i,1);
          break;
        }
      }
    }
  }

  //*********************Service Methods ************ */
  getUser(){
    this.userServ.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
        this.calculateAge();
        this.getUserGoals();
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
        if(!this.checkCurrentDay()){
          this.createCurrentDay();
        }
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
        this.showingTracker = true;
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

  addMeal(meal: Meal) {
    meal.trackDay = this.getCurrentDay();
    meal.nutrients = this.newMealNutrients;
    meal.ingredients = this.newMealIngredient;
    this.mealServ.create(meal).subscribe({
      next: (meals)=>{
        this.getTrackedDays();
        this.newMeal = new Meal();

      },
      error: (fail)=>{
        console.error('ERROR in creating a new Meal');
        console.error(fail);
      }
    })
  }
  getFavoriteRecipes() {
    this.recipeServ.findUserFavorites().subscribe({
      next: (favRecipes)=>{
        if(this.loggedInUser){
          this.loggedInUser.recipes = favRecipes;
        }

      },
      error: (fail)=>{
        console.error('ERROR in creating a new Meal');
        console.error(fail);
      }
    })
  }
 createTrackedDay(td: TrackedDay) {
  console.log("creating new tracked day")
    this.tds.create(td).subscribe({
      next: ()=>{
        this.getTrackedDays();
      },
      error: (fail)=>{
        console.error('ERROR in creating a new Day');
        console.error(fail);
      }
    })
  }

  indexIngred(): void{
    this.ingServ.index().subscribe({
      next: (ingredient) => {
       this.allIngredient = ingredient;
      },
      error: (problem) => {
        console.error('HttpComponent.reload(): error registering');
        console.error(problem);
      }
    });
  }

  indexMealTypes(){
    this.mts.index().subscribe({
      next: (allMealTypes) => {
       this.mealTypes = allMealTypes;
      },
      error: (problem) => {
        console.error('HttpComponent.reload(): error registering');
        console.error(problem);
      }
    });
  }

  removeMeal(meal: Meal){
    this.mealServ.destroy(meal.id).subscribe({
      next: () => {
       this.getTrackedDays();
      },
      error: (problem) => {
        console.error('HttpComponent.reload(): error registering');
        console.error(problem);
      }
    });
  }
  createNewGoal(goal: Goal){
    this.goalServ.create(goal).subscribe({
      next: () => {
        this.getUserGoals();
      },
      error: (problem) => {
        console.error('HttpComponent.reload(): error registering');
        console.error(problem);
      }
    });
  }
  achieveGoal(goal: Goal){
    goal.achieved = true;
    this.goalServ.achieveGoal(goal.id, goal).subscribe({
      next: () => {
        this.getUserGoals();
      },
      error: (problem) => {
        console.error('HttpComponent.reload(): error registering');
        console.error(problem);
      }
    });
  }
  getUserGoals(){
    if(this.loggedInUser?.id != null){
      this.goalServ.indexByUser(this.loggedInUser.id).subscribe({
        next: (goals) => {
          if(this.loggedInUser){
            this.loggedInUser.goals = goals;
          }
        },
        error: (problem) => {
          console.error('HttpComponent.reload(): error registering');
          console.error(problem);
        }
      });
    }
  }


}
