import { Component, OnInit } from '@angular/core';
import { Blog } from 'src/app/models/blog';
import { Topic } from 'src/app/models/topic';
import { User } from 'src/app/models/user';
import { CommentService } from 'src/app/services/comment.service';
import { Comment } from './../../models/comment';
import { AuthService } from './../../services/auth.service';
import { BlogService } from './../../services/blog.service';
import { TopicService } from './../../services/topic.service';
import { UserService } from './../../services/user.service';

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
  newBlog: Blog = new Blog();
  creatingBlog: boolean = false;
  newBlogTopics:Topic [] = [];
  newBlogTopic: Topic = new Topic();
  newComment: Comment = new Comment();
  commentUnderEdit: Comment = new Comment();
  editingComment: boolean = false;
  newTopic: Topic = new Topic();
  blogUnderEdit: Blog = new Blog();
  editingBlog: boolean = false;



  constructor(private blogServ: BlogService, private commentServ: CommentService,
    private topicServ: TopicService, private auth: AuthService, private userServ: UserService) { }

  ngOnInit(): void {
    this.indexBlogs();
    this.indexTopics();
    this.commentsByBlog();
    this.getUser();

  }
  //********************** Page Dynamics ********************************** */
  selectBlog(blog: Blog){
    this.displayBlog = blog;
  }

  startCreateBlog(){
    this.creatingBlog = true;
  }
  cancelCreateBlog(){
    this.creatingBlog = false;
    this.newBlog = new Blog();
  }

  startEditBlog(blog: Blog){
    this.blogUnderEdit = blog;
    this.editingBlog = true;
  }
  cancelEditBlog(){
    this.blogUnderEdit = new Blog();
    this.editingBlog = false;
  }

  addNewBlogTopic(topic : Topic){
    this.newBlogTopics.push(topic);
    this.newBlogTopic = new Topic();
  }
  removeNewBlogTopic(topic : Topic){
    if(this.newBlogTopics){
      for(let i=0; i< this.newBlogTopics.length; i ++){
        this.newBlogTopics.slice(i, 1);
      }
    }
  }

  showEditComment(comment: Comment){
    this.editingComment = true;
    this.commentUnderEdit = comment;
  }
  cancelEditComment(){
    this.editingComment = false;
    this.commentUnderEdit = new Comment();
  }
  addTopic(topic : Topic){
    this.newBlogTopics.push(topic);
    this.newTopic = new Topic();
    this.newBlogTopic = new Topic();

  }


  removeBlogTopic(topic: Topic){
    // if(this.newBlogTopics){
    //   for(let i=0; i< this.newBlogTopics.length; i ++){
    //     this.newBlogTopics.slice(i, 1);
    //   }
    // }

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
  createTopic(topic: Topic): void {
    this.topicServ.create(topic).subscribe({
      next: (topic) => {
        if(this.creatingBlog){
          this.newBlogTopics.push(topic);
        }
          this.indexTopics();
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

  createBlog(blog : Blog){
    blog.topics = this.newBlogTopics;
    this.blogServ.create(blog).subscribe({
      next: () => {
        this.indexBlogs();
        this.newBlogTopics = [];
        this.newBlogTopic = new Topic();
        this.cancelCreateBlog();
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  updateBlog(blog : Blog){
    blog.topics = this.newBlogTopics;
    this.blogServ.updateBlog(blog.id, blog).subscribe({
      next: () => {
        this.indexBlogs();
        this.newBlogTopics = [];
        this.newBlogTopic = new Topic();
        this.cancelEditBlog();
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  deleteBlog(id: number){
    this.blogServ.destroy(id).subscribe({
      next: () => {
        this.indexBlogs();
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  createComment(comment : Comment){
    comment.blog = this.displayBlog;
    if(this.loggedInUser){
      comment.user = this.loggedInUser;
    }
    this.commentServ.create(comment).subscribe({
      next: () => {
        this.commentsByBlog();
        this.newComment = new Comment();
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
  getUser(){
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
  editComment(comment : Comment){
    if(this.loggedInUser){
      comment.user = this.loggedInUser;
    }
    this.commentServ.updateComment(comment.id, comment).subscribe({
      next: () => {
        this.commentsByBlog();
        this.commentUnderEdit = new Comment();
        this.editingComment = false;
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }
  deleteComment(commentId : number){
    this.commentServ.destroy(commentId).subscribe({
      next: () => {
        this.commentsByBlog();
      },
      error: (problem) => {
        console.error('HttpComponent.loadProducts(): error loading products:');
        console.error(problem);
      }
    });
  }

}
