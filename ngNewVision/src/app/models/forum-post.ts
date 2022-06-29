import { User } from "./user";

export class ForumPost {

  id: number;
  createdAt: Date | null;
  inReplyTo: ForumPost | null;
  responses: ForumPost [];
  user : User | null;

  constructor(
    id: number = 0,
  createdAt: Date | null= null,
  inReplyTo: ForumPost | null = null,
  responses: ForumPost [] = [],
  user : User | null = null
  ){
    this.id = id;
    this.createdAt = createdAt;
    this.inReplyTo = inReplyTo;
    this.responses = responses;
    this.user = user;
  }

}
