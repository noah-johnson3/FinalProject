package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Gender;

public interface GenderService {
	
	List<Gender> findAll();
	Gender findById(int id);
}
