package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Blog;

public interface BlogRepository extends JpaRepository<Blog, Integer>{
	
	Blog findBlogByUser_Id(int id);

}
