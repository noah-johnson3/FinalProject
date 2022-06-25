package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.Goal;
import com.skilldistillery.newvision.services.GoalService;

@RequestMapping("api")
@RestController
@CrossOrigin({ "*", "http://localhost:4200" })
public class GoalController {
	
	@Autowired
	private GoalService goalService;
	
	@GetMapping("goals/{id}")
	public List<Goal> findGoalByUsername(HttpServletResponse res, @PathVariable int id, Principal principal) {
		List<Goal> goals = null;
		try {
			goals = goalService.findByUser(id, principal.getName());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return goals;

	}
	
	@PostMapping("goals")
	public Goal createGoal(HttpServletResponse res, @RequestBody Goal goal, Principal principal) {

		try {
			goal = goalService.createGoal(principal.getName(), goal);
			if (goal == null) {
				res.setStatus(400);
			} else {
				res.setStatus(201);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return goal;
	}
	
	@PutMapping("goals/{id}")
	public Goal updateGoal(HttpServletResponse res, @PathVariable int id, @RequestBody Goal goal,
			Principal principal) {
		try {
			goal = goalService.updateGoal(goal, principal.getName(), id);
			if (goal == null) {
				res.setStatus(401);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return goal;
	}
	@PutMapping("goals/achieve/{id}")
	public Goal achieveGoal(HttpServletResponse res, @PathVariable int id, @RequestBody Goal goal,
			Principal principal) {
		try {
			goal = goalService.achieveGoal(goal, principal.getName(), id);
			if (goal == null) {
				res.setStatus(401);
			} else {
				res.setStatus(200);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return goal;
	}
	
	@GetMapping("goals/filter/{achieved}")
	public List<Goal> findByGoalAchievment(HttpServletResponse res, @PathVariable boolean achieved,
			Principal principal) {
		List<Goal> goals = null;
		try {
			goals = goalService.accomplishedGoal(principal.getName(), achieved);
			if (goals == null) {
				res.setStatus(401);
			} else {
				res.setStatus(200);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return goals;
	}
	
	@DeleteMapping("goals/{id}")
	public void deleteGoal(HttpServletResponse res, @PathVariable int id, Principal principal) {
		boolean removed = false;
		try {
			removed = goalService.deleteGoal(principal.getName(), id);
			if (!removed) {
				res.setStatus(400);
			} else {
				res.setStatus(204);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
	}

}
