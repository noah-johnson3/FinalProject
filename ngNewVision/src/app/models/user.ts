import { TitleStrategy } from "@angular/router";
import { Blog } from "./blog";
import { Gender } from "./gender";
import { Goal } from "./goal";
import { Recipe } from "./recipe";
import { TrackedDay } from "./tracked-day";

export class User {

  id: number | null;
  username: string | null;
  password: string | null;
  firstName: string | null;
  lastName: string | null;
  email: string | null;
  height: number = 0;
  weight: number = 0;
  dateOfBirth: Date;
  imageUrl: string | null;
  gender: Gender | null;
  goals: Goal[];
  blogs: Blog[];
  trackedDays: TrackedDay[];
  recipes: Recipe[];
  createdRecipes: Recipe[];
  updatedAt: Date | null;
  publicProfile: boolean;
  activityLevel: number;

  constructor(
    id: number | null = 0,
    username: string | null = '',
    password: string | null = '',
    firstName: string | null = '',
  lastName: string | null = '',
  email: string | null = '',
  height: number = 0,
  weight: number = 0,
  dateOfBirth: Date = new Date(),
  imageUrl: string | null = '',
  gender: Gender | null = null,
  goals: Goal[] = [],
  blogs: Blog[] = [],
  trackedDays: TrackedDay[] = [],
  recipes: Recipe[] = [],
  createdRecipes: Recipe[] = [],
  updatedAt: Date | null = null,
  publicProfile: boolean = false,
  activityLevel: number = 1
  ){
    this.id = id;
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.height = height;
    this.weight = weight;
    this.dateOfBirth = dateOfBirth;
    this.imageUrl = imageUrl;
    this.gender = gender;
    this.goals = goals;
    this.blogs = blogs;
    this.trackedDays = trackedDays;
    this.recipes = recipes;
    this.createdRecipes = createdRecipes;
    this.updatedAt = updatedAt;
    this.publicProfile = publicProfile;
    this.activityLevel = activityLevel;
  }

}
