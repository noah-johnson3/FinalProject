package com.skilldistillery.newvision.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.newvision.entities.TrackedDay;

public interface TrackedDayRepository extends JpaRepository<TrackedDay, Integer>{

}