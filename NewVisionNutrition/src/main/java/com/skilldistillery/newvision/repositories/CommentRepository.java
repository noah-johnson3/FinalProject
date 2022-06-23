package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Blog;

public interface CommentRepository extends JpaRepository<CommentRepository, Integer>{
	
	CommentRepository findCommentBy_BlogId(int id);

}
