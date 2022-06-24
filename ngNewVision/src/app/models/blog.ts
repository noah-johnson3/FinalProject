import { Topic } from './topic';
import { User } from './user';
export class Blog {

  id: number;
  content: string;
  imageLink: string;
  createdAt: Date;
  title: string;
  user: User | null;
  topics: Topic [];
  comments: Comment [];

  constructor(id : number = 0, content: string = '', imageLink: string = '',
  createdAt: Date = new Date(), title: string = '', user: User | null = null, topics: Topic[] = [],
  comments: Comment[] = []){
    this.id = id
    this.content = content
    this.imageLink = imageLink
    this.createdAt = createdAt
    this.title = title
    this.user = user
    this.topics = topics
    this.comments = comments
  }
}

