import { Blog } from "./blog";
import { User } from "./user";

export class Comment {
  id: number;
  content: string;
  createdAt: Date;
  user: User | null;
  blog: Blog | null;

  constructor(id: number = 0, content: string = '',
  createdAt: Date = new Date(), user: User | null = null,
  blog: Blog | null = null){
    this.id = id
    this.content = content
    this.createdAt = createdAt
    this.user = user
    this.blog = blog
  }
}
