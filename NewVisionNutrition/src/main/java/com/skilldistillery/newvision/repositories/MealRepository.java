package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Meal;

public interface MealRepository extends JpaRepository<Meal, Integer>{

}
