import { FoodNutrients } from './food-nutrients';
export class Food {

fdcId: number;
description: string;
lowercaseDescription: string;
shortDescription: string;
dataType: string;
foodCategory: string;
servingSizeUnit: string;
servingSize: number;
foodNutrients: FoodNutrients [] ;


constructor(fdcId : number = 0,
  description: string = '',
  lowercaseDescription: string = '',
  dataType: string = '',
  foodCategory: string = '',
  servingSizeUnit: string = '',
  servingSize: number = 0,
  foodNutrients: FoodNutrients [] =[],
  shortDescription: string = ''
  ){
  this.fdcId = fdcId;
  this.description = description;
  this.lowercaseDescription = lowercaseDescription;
  this.dataType = dataType;
  this.foodCategory = foodCategory;
  this.servingSize = servingSize;
  this.servingSizeUnit =servingSizeUnit;
  this.foodNutrients = foodNutrients;
  this.shortDescription = shortDescription;

};

}
