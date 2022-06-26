package com.skilldistillery.newvision.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class MealTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Meal meal;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("NewVisionNutrition");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}
	@BeforeEach
	void setUp() throws Exception {
	    em = emf.createEntityManager();
	    meal = em.find(Meal.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    meal = null;
	}

	@Test
	@DisplayName("testing basic meal mappings")
	void test1() {
		assertNotNull(meal);
		assertEquals(meal.getId(), 1);
		
	}
	
	@Test
	@DisplayName("testing basic meal / mealType mappings")
	void test3() {
		assertNotNull(meal);
		assertEquals(meal.getMealType().getName(), "Breakfast");
		
	}
	
}
