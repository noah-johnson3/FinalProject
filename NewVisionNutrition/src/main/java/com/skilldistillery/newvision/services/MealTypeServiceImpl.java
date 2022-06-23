package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.newvision.entities.MealType;
import com.skilldistillery.newvision.repositories.MealTypeRepository;

public class MealTypeServiceImpl implements MealTypeService {

	@Autowired
	private MealTypeRepository mtr;
	
	@Override
	public List<MealType> findAll() {
		return mtr.findAll();
	}

	@Override
	public MealType findById(int id) {
		MealType mealType = null;
		Optional<MealType> op = mtr.findById(id);
		if(op.isPresent()) {
			mealType = op.get();
		}
		return mealType;
	}

}
