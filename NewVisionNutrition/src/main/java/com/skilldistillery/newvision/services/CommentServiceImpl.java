package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.Comment;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.BlogRepository;
import com.skilldistillery.newvision.repositories.CommentRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commRepo;

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private BlogRepository blogRepo;

	@Override
	public Comment createComment(Comment comm, String username) {
		User user = userRepo.findByUsernameEquals(username);
		System.out.println(comm.getBlog());
		Optional<Blog> op = blogRepo.findById(comm.getBlog().getId());
		if(op.isPresent()) {
			comm.setBlog(op.get());
		}
		if (user != null) {
			comm.setUser(user);
			comm = commRepo.saveAndFlush(comm);
		}

		return comm;
	}

	@Override
	public List<Comment> findByBlogId(int id) {
		return commRepo.findByBlog_Id(id);
	}

	@Override
	public Comment updateComment(Comment comm, String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		
		Comment updatedComm = null;
		System.out.println(comm.getId());
		if (comm.getUser().equals(user)) {
			System.out.println(user.getFirstName());
			Optional<Comment> op = commRepo.findById(comm.getId());
			if (op.isPresent()) {
				System.out.println(user.getEmail());
				updatedComm = op.get();
				updatedComm.setContent(comm.getContent());
				updatedComm = commRepo.saveAndFlush(updatedComm);
			}
		}
		return updatedComm;
	}

	@Override
	public boolean deleteComment(String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Comment deletedComm = null;
		Optional<Comment> op = commRepo.findById(id);
		if (op.isPresent()) {
			deletedComm = op.get();
		}
		if (deletedComm.getUser() == user) {
			commRepo.deleteById(id);
		}
		return !commRepo.existsById(id);
	}

}
