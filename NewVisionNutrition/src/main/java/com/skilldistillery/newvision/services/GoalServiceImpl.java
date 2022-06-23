package com.skilldistillery.newvision.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.newvision.entities.Goal;
import com.skilldistillery.newvision.entities.User;
import com.skilldistillery.newvision.repositories.GoalRepository;
import com.skilldistillery.newvision.repositories.UserRepository;

public class GoalServiceImpl implements GoalService {

	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private GoalRepository goalRepo;
	
	
	@Override
	public Goal createGoal(String username, Goal goal) {
		User user = userRepo.findByUsernameEquals(username);
		if(user != null) {
			goal.setUser(user);
			goal = goalRepo.saveAndFlush(goal);
		}
		return goal;
	}

	@Override
	public Goal updateGoal(Goal goal, String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Goal updatedGoal = null;
		if(goal.getUser() == user) {
			Optional<Goal> op = goalRepo.findById(id);
			if(op.isPresent()) {
				updatedGoal = op.get();
				updatedGoal.setWeight(goal.getWeight());
				updatedGoal.setDescription(goal.getDescription());
				updatedGoal.setName(goal.getName());
				updatedGoal = goalRepo.saveAndFlush(updatedGoal);
			}
		}
		return updatedGoal;
	}
	@Override
	public List<Goal> findByUser(int id, String username) {
		return goalRepo.findByUser_UsernameEquals(username);
	}

	@Override
	public List<Goal> accomplishedGoal(String username, boolean achieved) {
		
		return goalRepo.findByAchievedEqualsAndUser_UsernameEquals(achieved, username);
	}

	@Override
	public boolean deleteGoal(String username, int id) {
		User user = userRepo.findByUsernameEquals(username);
		Goal deletedGoal = null;
		Optional<Goal> op = goalRepo.findById(id);
		if(op.isPresent()) {
			deletedGoal = op.get();
		}
		if(deletedGoal.getUser() == user) {
			goalRepo.deleteById(id);
		}
		
		return !goalRepo.existsById(id);
	}

}
