import { User } from "./user";

export class Goal {
  id: number;
  name: string;
  weight: number;
  achieved: boolean;
  description: string;
  dateAchieved: Date;
  createAt: Date;
  user: User | null;

  constructor(id: number = 0, name: string = '', weight: number = 0, achieved: boolean = false,
  description: string = '', dateAchieved: Date = new Date(), createAt: Date = new Date(),
  user: User | null = null){
    this.id = id
    this.name = name
    this.weight = weight
    this.achieved = achieved
    this.description = description
    this.dateAchieved = dateAchieved
    this.createAt = createAt
    this.user = user
  }
}
