package com.skilldistillery.newvision.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Nutrients {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	
	private Double protein;

	private Double carbs;

	private Double fats;

	private Integer sodium;

	private Integer sugar;

	private Double calories;
	
	private Double cholesterol;
	
	@JsonIgnore
	@OneToOne(mappedBy="nutrients")
	private Recipe recipe;
	
	@JsonIgnore
	@OneToOne(mappedBy="nutrients")
	private Ingredient ingredient;
	
	@JsonIgnore
	@OneToOne(mappedBy="nutrients")
	private Meal meal;
	
	
	public Nutrients() {}

	
	

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
		Nutrients other = (Nutrients) obj;
		return id == other.id;
	}


	

	public Double getCholesterol() {
		return cholesterol;
	}




	public void setCholesterol(Double cholesterol) {
		this.cholesterol = cholesterol;
	}




	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public Double getProtein() {
		return protein;
	}


	public void setProtein(Double protein) {
		this.protein = protein;
	}


	public Double getCarbs() {
		return carbs;
	}


	public void setCarbs(Double carbs) {
		this.carbs = carbs;
	}


	public Double getFats() {
		return fats;
	}


	public void setFats(Double fats) {
		this.fats = fats;
	}


	public Integer getSodium() {
		return sodium;
	}


	public void setSodium(Integer sodium) {
		this.sodium = sodium;
	}


	public Integer getSugar() {
		return sugar;
	}


	public void setSugar(Integer sugar) {
		this.sugar = sugar;
	}


	public Double getCalories() {
		return calories;
	}


	public void setCalories(Double calories) {
		this.calories = calories;
	}


	public Ingredient getIngredient() {
		return ingredient;
	}


	public void setIngredient(Ingredient ingredient) {
		this.ingredient = ingredient;
	}




	public Meal getMeal() {
		return meal;
	}




	public void setMeal(Meal meal) {
		this.meal = meal;
	}
	
	

}
