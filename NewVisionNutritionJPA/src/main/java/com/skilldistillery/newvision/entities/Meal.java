package com.skilldistillery.newvision.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.xml.ws.soap.MTOM;

@Entity
public class Meal {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "tracked_day_id")
	private TrackedDay trackDay;

	@JoinColumn(name = "meal_type_id")
	@ManyToOne
	private MealType mealType;

	@JoinColumn(name = "recipe_id")
	@ManyToOne
	private Recipe recipe;

	public Meal() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public TrackedDay getTrackDay() {
		return trackDay;
	}

	public void setTrackDay(TrackedDay trackDay) {
		this.trackDay = trackDay;
	}

	public MealType getMealType() {
		return mealType;
	}

	public void setMealType(MealType mealType) {
		this.mealType = mealType;
	}

	public Recipe getRecipe() {
		return recipe;
	}

	public void setRecipe(Recipe recipe) {
		this.recipe = recipe;
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
		Meal other = (Meal) obj;
		return id == other.id;
	}

}
