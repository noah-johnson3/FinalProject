import { UserService } from './services/user.service';
import { TrackedDayService } from './services/tracked-day.service';
import { TopicService } from './services/topic.service';
import { RecipeService } from './services/recipe.service';
import { MealService } from './services/meal.service';
import { MealTypeService } from './services/meal-type.service';
import { IngredientService } from './services/ingredient.service';
import { GoalService } from './services/goal.service';
import { GenderService } from './services/gender.service';
import { CommentService } from 'src/app/services/comment.service';
import { BlogService } from './services/blog.service';
import { AuthService } from 'src/app/services/auth.service';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { UserComponent } from './components/user/user.component';
import { BlogComponent } from './components/blog/blog.component';
import { RecipesComponent } from './components/recipes/recipes.component';
import { MealTrackerComponent } from './components/meal-tracker/meal-tracker.component';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { LogoutComponent } from './components/logout/logout.component';
import { FoodFinderComponent } from './components/food-finder/food-finder.component';
import { BaseBarComponent } from './components/base-bar/base-bar.component';
import { ForumsComponent } from './components/forums/forums.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';


@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    UserComponent,
    BlogComponent,
    RecipesComponent,
    MealTrackerComponent,
    HomeComponent,
    LoginComponent,
    RegisterComponent,
    LogoutComponent,
    FoodFinderComponent,
    BaseBarComponent,
    ForumsComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule

  ],
  providers: [
   AuthService,
   BlogService,
   CommentService,
   GenderService,
   GoalService,
   IngredientService,
   MealTypeService,
   MealService,
   RecipeService,
   TopicService,
   TrackedDayService,
   UserService
  ],

  bootstrap: [AppComponent]
})
export class AppModule { }
