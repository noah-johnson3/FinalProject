package com.skilldistillery.newvision.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="tracked_day")
public class TrackedDay {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@CreationTimestamp
	private LocalDateTime day;
	
	@JsonIgnoreProperties({"trackedDays"})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@JsonIgnoreProperties("trackDay")
	@OneToMany(mappedBy="trackDay")
	private List<Meal> meals;
	

	
	public TrackedDay() {
	}

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public LocalDateTime getDay() {
		return day;
	}


	public void setDay(LocalDateTime day) {
		this.day = day;
	}

	
	
	public List<Meal> getMeals() {
		return meals;
	}

	public void setMeals(List<Meal> meals) {
		this.meals = meals;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TrackedDay other = (TrackedDay) obj;
		return id == other.id;
	}
	
	
	
	
	
	
}
