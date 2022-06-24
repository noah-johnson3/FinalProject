import { Blog } from "./blog";

export class Topic {
  id: number;
  name: string;
  description: string;
  blogs: Blog[];


  constructor(id: number = 0, name: string = '',
  description: string = '', blogs: Blog [] = []){
    this.id = id
    this.name = name
    this.description = description
    this.blogs = blogs
  }
}
