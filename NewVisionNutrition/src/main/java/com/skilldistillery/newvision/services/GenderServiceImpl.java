package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.newvision.entities.Gender;
import com.skilldistillery.newvision.repositories.GenderRepository;

public class GenderServiceImpl implements GenderService {

	@Autowired
	private GenderRepository genderRepo;
	
	
	
	
	@Override
	public List<Gender> findAll() {
		return genderRepo.findAll();
	}

	@Override
	public Gender findById(int id) {
		Gender gender = null;
		Optional<Gender> op = genderRepo.findById(id);
		if(op.isPresent()) {
			gender = op.get();
		}
		return gender;
	}

}
