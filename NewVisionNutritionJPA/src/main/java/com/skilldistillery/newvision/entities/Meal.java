package com.skilldistillery.newvision.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Meal {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@JsonIgnoreProperties({"meals", "user"})
	@ManyToOne
	@JoinColumn(name = "tracked_day_id")
	private TrackedDay trackDay;

	@JoinColumn(name = "meal_type_id")
	@ManyToOne
	private MealType mealType;

	@JsonIgnoreProperties({"meals"})
	@ManyToMany
	@JoinTable(name = "meal_ingredient", 
	joinColumns = @JoinColumn(name = "meal_id"), 
	inverseJoinColumns = @JoinColumn(name = "ingredient_id"))
	private List<Ingredient> ingredients;
	
	
	@JsonIgnoreProperties({"meal"})
	@OneToOne(cascade= {CascadeType.PERSIST})
	@JoinColumn(name="nutrients_id")
	private Nutrients nutrients;

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
	

	public List<Ingredient> getIngredients() {
		return ingredients;
	}

	public void setIngredients(List<Ingredient> ingredients) {
		this.ingredients = ingredients;
	}

	public Nutrients getNutrients() {
		return nutrients;
	}

	public void setNutrients(Nutrients nutrients) {
		this.nutrients = nutrients;
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
