package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.TrackedDay;

public interface TrackedDayService {
	
	TrackedDay createTrackedDay(TrackedDay day, String username);
	TrackedDay updateDay(TrackedDay day, int id, String username);
	TrackedDay findByUserId(int id, String username);
	TrackedDay findById(int id);
	List<TrackedDay> findAll();
}
