import { UserService } from './../../services/user.service';
import { AuthService } from './../../services/auth.service';
import { TopicService } from './../../services/topic.service';
import { Comment } from './../../models/comment';
import { BlogService } from './../../services/blog.service';
import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { Topic } from 'src/app/models/topic';
import { User } from 'src/app/models/user';
import { CommentService } from 'src/app/services/comment.service';

@Component({
  selector: 'app-blog',
  templateUrl: './blog.component.html',
  styleUrls: ['./blog.component.css']
})
export class BlogComponent implements OnInit {
  comments: Comment[] = [];
  blogs: Blog[] = [];
  displayBlog: Blog | null = null;
  topics :Topic [] = [];
  displayBlogTopics: Topic [] =[];
  searchTopic: Topic | null = null;
  loggedInUser: User | null = null;
  author: string = '';



  constructor(private blogServ: BlogService, private commentServ: CommentService,
    private topicServ: TopicService, private auth: AuthService, private userServ: UserService) { }

  ngOnInit(): void {
    this.indexBlogs();
    this.indexTopics();
    this.commentsByBlog();
    this.checkLogin();

  }
  //********************** Page Dynamics ********************************** */
  selectBlog(blog: Blog){
    this.displayBlog = blog;
  }


  //******************   Service Methods  *************************** */
  indexBlogs(): void {
    this.blogServ.index().subscribe({
      next: (blogs) => {
        this.blogs = blogs;
        this.displayBlog = blogs[0];
        this.commentsByBlog();
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  indexTopics(): void {
    this.topicServ.listAllTopics().subscribe({
      next: (topics) => {
        this.topics = topics;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  searchByTopic(topic : Topic | null): void {
    if(topic){
      console.log(topic.name)
      this.blogServ.blogsByTopic(topic?.name).subscribe({
        next: (blogs) => {
          this.blogs = blogs;
        },
        error: (problem) => {
          console.error('HttpComponent.loadProducts(): error loading products:');
          console.error(problem);
        }
      });
    }
  }
  searchByAuthor(author: string): void {
    if(author){
      this.blogServ.listBlogsByAuthor(author).subscribe({
        next: (blogs) => {
          this.blogs = blogs;
        },
        error: (problem) => {
          console.error('HttpComponent.loadProducts(): error loading products:');
          console.error(problem);
        }
      });
    }
  }

  checkLogin(){
    this.userServ.getLoggedInUser().subscribe({
      next: (user) => {
        this.loggedInUser = user;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }

  commentsByBlog(): void{
    if(this.displayBlog){
      console.log(this.displayBlog.id)
      this.commentServ.index(this.displayBlog.id).subscribe({
        next: (data) => {
          this.comments = data;
        },
        error: (problem) => {
          console.error('error displaying comments');
          console.error(problem);
        }
      });
    }
  }


}
