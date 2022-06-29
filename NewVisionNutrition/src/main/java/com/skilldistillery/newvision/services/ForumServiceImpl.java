package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.ForumPost;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.ForumPostRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class ForumServiceImpl implements ForumService {
	
	@Autowired
	private ForumPostRepository fpr;
	
	@Autowired
	private UserRepository ur;
	
	@Override
	public List<ForumPost> getResponsesByPostId(int id) {
		return fpr.findByInReplyTo_IdEquals(id);
	}

	@Override
	public List<ForumPost> getMainPosts() {
		return fpr.findByInReplyToIsNull();
	}

	@Override
	public List<ForumPost> getMainPostsByTopic(String topic) {
		return fpr.findByInReplyToIsNullAndTopicEquals(topic);
	}

	@Override
	public ForumPost createPost(ForumPost post, String username) {
		User user = ur.findByUsernameEquals(username);
		if(user != null) {
			post.setUser(user);
			post = fpr.saveAndFlush(post);
		}
		
		return post;
	}

	@Override
	public ForumPost editPost(ForumPost post, int id, String username) {
		User user = ur.findByUsernameEquals(username);
		ForumPost underEdit = null;
		if(post.getUser().equals(user)) {
			Optional<ForumPost> op = fpr.findById(id);
			if(op.isPresent()) {
				underEdit = op.get();
				underEdit.setContent(post.getContent());
				underEdit = fpr.saveAndFlush(underEdit);
			}
			
		}
		return underEdit;
	}

	@Override
	public boolean deletePost(int id, String username) {
		User user = ur.findByUsernameEquals(username);
		Optional<ForumPost> op = fpr.findById(id);
		ForumPost post = null;
		if(op.isPresent()) {
			post = op.get();
		}
		if(post.getUser().equals(user)) {
			fpr.deleteById(id);
		}
		return !fpr.existsById(id);
	}
	
	

}
