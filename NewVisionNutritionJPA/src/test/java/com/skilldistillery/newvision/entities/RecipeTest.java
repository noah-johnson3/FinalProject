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

class RecipeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Recipe recipe;

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
	    recipe = em.find(Recipe.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    recipe = null;
	}

	@Test
	@DisplayName("testing basic recipe mappings")
	void test1() {
		assertNotNull(recipe);
		assertEquals(recipe.getName(), "Easy Morning Hash");
		
	}
	
	@Test
	@DisplayName("testing basic recipe / user  mapping")
	void test2() {
		assertNotNull(recipe);
		assertEquals(recipe.getUser().getFirstName(), "Katherine");
		
	}
	@Test
	@DisplayName("testing basic recipe / ingredient  mapping")
	void test3() {
		assertNotNull(recipe);
		assertNotNull(recipe.getIngredients());
		assertTrue(recipe.getIngredients().size() > 0);
		
	}
	
	
	
}