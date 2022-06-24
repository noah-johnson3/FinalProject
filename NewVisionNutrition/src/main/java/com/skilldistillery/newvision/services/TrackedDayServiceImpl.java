package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.newvision.entities.TrackedDay;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.TrackedDayRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

@Service
public class TrackedDayServiceImpl implements TrackedDayService {

	@Autowired
	private UserRepository userRepo;
	
	@Autowired TrackedDayRepository tdr;
	
	
	@Override
	public TrackedDay createTrackedDay(TrackedDay day, String username) {
		User user = userRepo.findByUsernameEquals(username);
		if (user != null) {
			day.setUser(user);
			day = tdr.saveAndFlush(day);

		}
		return day;
	}

	@Override
	public TrackedDay updateDay(TrackedDay day, int id, String username) {
		User user = userRepo.findByUsernameEquals(username);
		TrackedDay updatedDay = null;
		if (day.getUser() == user) {
			Optional<TrackedDay> op = tdr.findById(id);
			if (op.isPresent()) {
				updatedDay = op.get();
				updatedDay.setMeals(day.getMeals());
				updatedDay = tdr.saveAndFlush(updatedDay);
			}
		}
		return updatedDay;
	}

	

	@Override
	public TrackedDay findById(int id) {
		TrackedDay day = null;
		Optional<TrackedDay> op = tdr.findById(id);
		if(op.isPresent()) {
			day = op.get();
		}
		return day;
	}

	@Override
	public List<TrackedDay> findByUser(String username) {
		
		return tdr.findByUser_UsernameEquals(username);
	}

	

	
	
}
