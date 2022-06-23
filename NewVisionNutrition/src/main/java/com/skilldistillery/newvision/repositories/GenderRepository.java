package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.Gender;

public interface GenderRepository extends JpaRepository<Gender, Integer>{
	
	

}
