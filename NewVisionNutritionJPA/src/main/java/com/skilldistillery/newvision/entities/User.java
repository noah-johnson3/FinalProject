package com.skilldistillery.newvision.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	private String email;

	private double height;

	private double weight;

	@Column(name="date_of_birth")
	private LocalDateTime dateOfBirth;

	private boolean active;

	private String username;

	private String password;

	private String role;

	@CreationTimestamp
	@Column(name = "created_at")
	private LocalDateTime createAt;

	@Column(name = "image_url")
	private String imageUrl;

	@ManyToOne
	@JoinColumn(name = "gender_id")
	private Gender gender;

	@JsonIgnoreProperties({"user"})
	@OneToMany(mappedBy = "user")
	@JsonIgnore
	private List<Goal> goals;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Blog> blogs;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Comment> comments;

	@JsonIgnoreProperties({"user"})
	@OneToMany(mappedBy="user")
	private List<TrackedDay> trackedDays;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name="user_recipe", joinColumns=@JoinColumn(name="user_id"),
	inverseJoinColumns = @JoinColumn(name="recipe_id"))
	private List <Recipe> recipes;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Recipe> createdRecipes;
	

	// Object Mappings!! :

	// user has: role, list of blogs, list ofcomments, list of goals,
	// list of tracked days list of recipes, list of forum posts, list of replies,
	// a team, list of chat

	public User() {
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
		User other = (User) obj;
		return id == other.id;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<Goal> getGoals() {
		return goals;
	}

	public void setGoals(List<Goal> goals) {
		this.goals = goals;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	

	public LocalDateTime getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(LocalDateTime dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public List<Blog> getBlogs() {
		return blogs;
	}

	public void setBlogs(List<Blog> blogs) {
		this.blogs = blogs;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<TrackedDay> getTrackedDays() {
		return trackedDays;
	}

	public void setTrackedDays(List<TrackedDay> trackedDays) {
		this.trackedDays = trackedDays;
	}

	public List<Recipe> getRecipes() {
		return recipes;
	}

	public void setRecipes(List<Recipe> recipes) {
		this.recipes = recipes;
	}

	public List<Recipe> getCreatedRecipes() {
		return createdRecipes;
	}

	public void setCreatedRecipes(List<Recipe> createdRecipes) {
		this.createdRecipes = createdRecipes;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	
	
	

}
