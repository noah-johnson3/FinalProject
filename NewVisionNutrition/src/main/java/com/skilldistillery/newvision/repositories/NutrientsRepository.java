package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.newvision.entities.Nutrients;

public interface NutrientsRepository extends JpaRepository <Nutrients, Integer> {
		
	Nutrients findByMeal_IdEquals(@Param("Id") int id);
	
//	Nutrients findByIngredient_IdEquals(@Param("id") int id);
	
	
	
}
