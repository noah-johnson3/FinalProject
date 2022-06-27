export class FoodNutrients {
  nutrientId: number;
  nutrientName: string;
  unitName: string;
  value: number;

  constructor(
    nutrientId: number =0,
    nutrientName: string = '',
    unitName: string = '',
    value: number = 0
  ){
    this.nutrientId = nutrientId;
    this.nutrientName = nutrientName;
    this.unitName = unitName;
    this.value = value;
  }



}
