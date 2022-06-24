package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.Topic;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.TopicRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class TopicServiceImpl implements TopicService {

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private TopicRepository topicRepo;
	
	@Override
	public Topic createTopic(Topic topic, String username) {
		User user = userRepo.findByUsernameEquals(username);
		if (user != null) {
			topic = topicRepo.saveAndFlush(topic);

		}
		return topic;
	}

	@Override
	public Topic findByName(String name) {
		System.out.println("searching by name");
		return topicRepo.findByNameEquals(name);
	}

	@Override
	public Topic findById(int id) {
		Topic topic = null;
		Optional<Topic> op = topicRepo.findById(id);
		if(op.isPresent()) {
			topic = op.get();
		}
		
		return topic;
	}

	@Override
	public List<Topic> findByKeyWord(String keyword) {
		
		return topicRepo.findbyKeyword(keyword, keyword);
	}

	@Override
	public List<Topic> findAll() {
		return topicRepo.findAll();
	}
	

}
