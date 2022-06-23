package com.skilldistillery.newvision.services;

import java.util.List;

import com.skilldistillery.newvision.entities.Goal;

public interface GoalService {
	
	Goal createGoal(String username, Goal goal);
	Goal updateGoal(Goal goal, String username, int id);
	List<Goal> findByUser(int id, String username);
	List<Goal> accomplishedGoal(String username, boolean achieved);
	boolean deleteGoal(String username, int id);
	

}
