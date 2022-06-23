package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.Meal;

public interface MealRepository extends JpaRepository<Meal, Integer>{
	
	List<Meal> findByTrackDay_IdEquals(@Param("Id")int id);

}
