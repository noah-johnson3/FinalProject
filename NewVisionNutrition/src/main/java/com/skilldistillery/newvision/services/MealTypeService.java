package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.MealType;

public interface MealTypeService {
	
	List<MealType> findAll();
	MealType findById(int id);
}
