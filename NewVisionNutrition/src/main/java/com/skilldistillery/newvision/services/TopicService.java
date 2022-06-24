package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Topic;

public interface TopicService {
	

	Topic createTopic(Topic topic, String username);
	Topic findByName(String name);
	Topic findById(int id);
	List<Topic> findByKeyWord(String keyword);
	List<Topic> findAll();
 	

}
