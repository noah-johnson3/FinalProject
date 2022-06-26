package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.Blog;
import com.skilldistillery.newvision.entities.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Integer>{

	
	@Query("SELECT r FROM Recipe r WHERE r.timeRequired <= :time ")
	List<Recipe> findByTime(@Param("time")int time);
	
	
	@Query("SELECT r FROM Recipe r JOIN r.ingredients ri WHERE ri.name = :ingredient")
	List<Recipe> findByIngredient(@Param("ingredient")String ingredient);
	
	
	
	List<Recipe> findByUser_UsernameEquals(@Param("Username")String username);
}
