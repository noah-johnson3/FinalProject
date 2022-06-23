package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Topic;

public interface TopicRepository extends JpaRepository<Topic, Integer>{

}
