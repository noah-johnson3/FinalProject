package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.Comment;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.CommentRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commRepo;

	@Autowired
	private UserRepository userRepo;

	@Override
	public Comment createComment(Comment comm, String username) {
		User user = userRepo.findByUsernameEquals(username);
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
		if (comm.getUser() == user) {
			Optional<Comment> op = commRepo.findById(id);
			if (op.isPresent()) {
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
