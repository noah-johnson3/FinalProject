package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.ForumPost;

public interface ForumService {
	
	List<ForumPost> getResponsesByPostId(int id);
	
	List<ForumPost> getMainPosts();
	
	List<ForumPost> getMainPostsByTopic(String topic);
	
	ForumPost createPost(ForumPost post, String username);
	
	ForumPost editPost(ForumPost post, int id, String username);
	
	boolean deletePost(int id, String username);
	
	

}
