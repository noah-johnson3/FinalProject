package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer>{
	
	List<Comment> findByBlog_Id(int id);
	

}
