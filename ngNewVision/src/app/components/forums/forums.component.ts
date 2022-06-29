import { ForumService } from './../../services/forum.service';
import { UserService } from './../../services/user.service';
import { Component, OnInit } from '@angular/core';
import { ForumPost } from 'src/app/models/forum-post';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-forums',
  templateUrl: './forums.component.html',
  styleUrls: ['./forums.component.css']
})
export class ForumsComponent implements OnInit {
  forums: ForumPost [] = [];
  displayForum: ForumPost | null = null;
  displayForumResponses: ForumPost [] = [];
  displayForumResponse: ForumPost | null = null;
  loggedInUser: User | null = null;
  responding: boolean = false;
  editPost: ForumPost | null = null;
  editing: boolean = false;
  newPost: ForumPost = new ForumPost();
  creatingPost: boolean = false;
  topic: string = '';


  //*********************************** Setup **************************************** */
  constructor(private userServ: UserService, private forumServ: ForumService) { }

  ngOnInit(): void {
    this.getMainForums();
    this.getUser();
  }

  // ***************************************** Page Dynamics **********************************

  startEditPost( post: ForumPost){
    this.editPost = post;
    this.editing = true;
  }
  cancelEditPost(){
    this.editPost = null;
    this.editing = false;
  }
  startCreatePost(){
    this.newPost = new ForumPost();
    this.creatingPost = true;
  }
  cancelCreatePost(){
    this.creatingPost = false;
    this.newPost = new ForumPost();
    if(this.responding){
      this.cancelReply();
    }
  }

  displayResponses(id: number, post: ForumPost){
    this.displayForum  =  post;
    this.getForumResponses(id);
  }

  cancelDisplay(){
    this.displayForum = null;
    this.displayForumResponses = [];
  }

  startReply(post: ForumPost){
    this.creatingPost = true;
    this.responding = true;
    this.newPost.inReplyTo = post;
  }
  cancelReply(){
    this.creatingPost = false;
    this.responding = false;
    this.newPost = new ForumPost();
  }

  display(post: ForumPost){
    this.displayForum = post;
    this.getForumResponses(post.id);
  }

  // ***************************************** Service Methods **********************************

getMainForums(){
  this.forumServ.getParentForums().subscribe({
    next: (results) => {
      this.forums = results;
    },
    error: (problem) => {
      console.error('HttpComponent.loadProducts(): error loading products:');
      console.error(problem);
    }
  });
}
getForumsByTopic(topic: string){
  this.forumServ.getParentForumsByTopic(topic).subscribe({
    next: (results) => {
      this.forums = results;
    },
    error: (problem) => {
      console.error('HttpComponent.loadProducts(): error loading products:');
      console.error(problem);
    }
  });

}
getForumResponses(id: number){
  this.forumServ.getForumResponses(id).subscribe({
    next: (results) => {
      this.displayForumResponses = results;

    },
    error: (problem) => {
      console.error('HttpComponent.loadProducts(): error loading products:');
      console.error(problem);
    }
  });

}
createForum(forum: ForumPost){
  this.forumServ.createForum(forum).subscribe({
    next: (results) => {
      if(this.responding){
        if(this.displayForum){

          this.getForumResponses(this.displayForum.id);
        }
      }else{
        this.displayForum = results;
      }
      this.newPost = new ForumPost();
      this.creatingPost = false;
    },
    error: (problem) => {
      console.error('HttpComponent.loadProducts(): error loading products:');
      console.error(problem);
    }
  });

}
editForum(forum: ForumPost){
  this.forumServ.createForum(forum).subscribe({
    next: (results) => {
      if(this.editPost?.inReplyTo){
        if(this.displayForum){
          this.getForumResponses(this.displayForum.id);
        }
      }else{
        this.displayForum = results;
      }
    },
    error: (problem) => {
      console.error('HttpComponent.loadProducts(): error loading products:');
      console.error(problem);
    }
  });
}
deleteForum(id: number){
  this.forumServ.deleteForum(id).subscribe({
    next: (results) => {
        if(this.displayForum){
          this.getForumResponses(this.displayForum.id);
        }
      else{
        this.displayForum = results;
      }
    },
    error: (problem) => {
      console.error('HttpComponent.loadProducts(): error loading products:');
      console.error(problem);
    }
  });


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












}
