package com.skilldistillery.newvision.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class IngredientTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Ingredient ingredient;

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
	    ingredient = em.find(Ingredient.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    ingredient = null;
	}

	@Test
	@DisplayName("testing basic ingredient mappings")
	void test1() {
		assertNotNull(ingredient);
		assertEquals(ingredient.getName(), "egg");
		
	}
	
	@Test
	@DisplayName("testing basic ingredient / recipe mappings")
	void test2() {
		assertNotNull(ingredient);
		assertNotNull(ingredient.getRecipes());
		assertTrue(ingredient.getRecipes().size() > 0);
		
	}
}