package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Topic;
import com.skilldistillery.newvision.services.TopicService;

@RequestMapping("api")
@RestController
public class TopicController {
	
	@Autowired
	private TopicService topicServ;
	
	@PostMapping("topics")
	public Topic createTopic(HttpServletResponse res, @RequestBody Topic topic, Principal principal) {

		try {
			topic = topicServ.createTopic(topic, principal.getName());
			if (topic == null) {
				res.setStatus(404);
			} else {
				res.setStatus(201);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return topic;

	}
	
	@GetMapping("topics/search/{name}")
	public Topic findByTopicName(HttpServletResponse res, @PathVariable String name) {
		Topic topic = null;
		try {
			topic = topicServ.findByName(name);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return topic;
	}
	
	@GetMapping("topics/idSearch/{id}")
	public Topic findById(@PathVariable int id, HttpServletResponse res) {
		Topic topic = null;
		try {
			topic = topicServ.findById(id);
			if (topic == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return topic;
	}
	
	@GetMapping("topics/keySearch/{keyword}")
	public List<Topic> findByKeyword(@PathVariable String keyword, HttpServletResponse res) {
		List<Topic> topics = null;
		try {
			topics = topicServ.findByKeyWord(keyword);
			if (topics == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return topics;
	}
	@GetMapping("topics")
	public List<Topic> findAll( HttpServletResponse res) {
		List<Topic> topics = null;
		try {
			topics = topicServ.findAll();
			if (topics == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return topics;
	}

}
