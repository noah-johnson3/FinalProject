package com.skilldistillery.newvision.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.newvision.entities.TrackedDay;
import com.skilldistillery.newvision.services.TrackedDayService;

@RequestMapping("api")
@RestController
public class TrackedDayController {
	
	@Autowired
	private TrackedDayService tds;
	
	@PostMapping("trackedDay")
	public TrackedDay createTrackedDay(HttpServletResponse res, @RequestBody TrackedDay td, Principal principal) {

		try {
			td = tds.createTrackedDay(td, principal.getName());
			if (td == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return td;

	}
	
	@PutMapping("trackedDay/{id}")
	public TrackedDay updateDay(HttpServletResponse res, @PathVariable int id, @RequestBody TrackedDay td,
			Principal principal) {
		try {
			td = tds.updateDay(td, id, principal.getName());
			if (td == null) {
				res.setStatus(401);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(404);
		}
		return td;
	}
	
	@GetMapping("trackedDay/user/{id}")
	public TrackedDay findByUserId(@PathVariable int id, HttpServletResponse res, Principal principal) {
		TrackedDay td = null;
		try {
			td = tds.findByUserId(id, principal.getName());
			if (td == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}

		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return td;
	}
	@GetMapping("trackedDay/{id}")
	public TrackedDay findById(@PathVariable int id, HttpServletResponse res) {
		TrackedDay td = null;
		try {
			td = tds.findById(id);
			if (td == null) {
				res.setStatus(404);
			} else {
				res.setStatus(200);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return td;
	}
	
	

}
