package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer>{
	
	CommentRepository findCommentByBlog_Id(int id);

}
