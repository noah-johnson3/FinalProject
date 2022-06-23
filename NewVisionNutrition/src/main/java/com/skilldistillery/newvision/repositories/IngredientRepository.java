package com.skilldistillery.newvision.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.Ingredient;

public interface IngredientRepository extends JpaRepository<Ingredient, Integer>{

	Ingredient findByNameEquals(@Param("name") String name);
	
	@Query("SELECT i FROM Ingredient i JOIN i.recipes ir WHERE ir.id = :id ")
	List<Ingredient> findByRecipe(@Param("id")int id);
}
