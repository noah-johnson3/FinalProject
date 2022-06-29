package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.ForumPost;

public interface ForumPostRepository extends JpaRepository<ForumPost, Integer> {
	
	List<ForumPost> findByInReplyTo_IdEquals(@Param("Id")int id);
	
	List<ForumPost> findByInReplyToIsNullAndTopicEquals(String topic);
	
	List<ForumPost> findByInReplyToIsNull();

}
