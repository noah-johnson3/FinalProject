package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.BlogRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class BlogServiceImpl implements BlogService {

	@Autowired
	private BlogRepository blogRepo;

	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Blog> findByTopic(String topicName) {
		return blogRepo.findBlogByTopicName(topicName);
	}

	@Override
	public List<Blog> findByUsername(String username) {
		return blogRepo.findByUser_UsernameEquals(username);
	}

	@Override
	public Blog findById(int id) {
		Blog blog = null;
		Optional<Blog> op = blogRepo.findById(id);
		if (op.isPresent()) {
			blog = op.get();

		}
		return blog;
	}

	@Override
	public Blog createBlog(Blog blog, String username) {
		User user = userRepo.findByUsernameEquals(username);
		if (user != null) {
			blog.setUser(user);
			blog = blogRepo.saveAndFlush(blog);

		}
		return blog;
	}

	@Override
	public Blog updateBlog(Blog blog, String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Blog updatedBlog = null;
		System.out.println(username);
		System.out.println(blog.getUser().getUsername());
		if (blog.getUser().equals(user)) {
			System.out.println("User authorized");
			Optional<Blog> op = blogRepo.findById(id);
			if (op.isPresent()) {
				updatedBlog = op.get();
				updatedBlog.setContent(blog.getContent());
				updatedBlog.setImageLink(blog.getImageLink());
				updatedBlog.setTitle(blog.getTitle());
				updatedBlog.setTopics(blog.getTopics());
				updatedBlog = blogRepo.saveAndFlush(updatedBlog);
			}
		}
		return updatedBlog;
	}

	@Override
	public boolean deleteBlog(String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Blog deletedBlog = null;
		Optional<Blog> op = blogRepo.findById(id);
		if (op.isPresent()) {
			deletedBlog = op.get();
		}
		if (deletedBlog.getUser() == user) {
			blogRepo.deleteById(id);

		}
		return !blogRepo.existsById(id);

	}

	@Override
	public List<Blog> findAll() {
		return blogRepo.findAll();
	}

}
