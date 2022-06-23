package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.Topic;

public interface TopicRepository extends JpaRepository<Topic, Integer>{

	Topic findByNameEquals(@Param("Name")String name);
	
	@Query("SELECT t FROM Topic t WHERE t.name =  :name  OR t.description LIKE :description")
	List<Topic> findbyKeyword(@Param("name")String name, @Param("description") String description);
	
}
