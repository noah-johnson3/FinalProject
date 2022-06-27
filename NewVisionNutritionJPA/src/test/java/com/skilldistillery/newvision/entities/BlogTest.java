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

class BlogTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Blog blog;

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
	    blog = em.find(Blog.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    blog = null;
	}

	@Test
	@DisplayName("testing basic blog mappings")
	void test1() {
		assertNotNull(blog);
		assertEquals(blog.getTitle(), "Blog 1 TEST");
		
	}
	@Test
	@DisplayName("testing basic / user mappings")
	void test2() {
		assertNotNull(blog);
		assertEquals(blog.getUser().getFirstName(), "Katherine");
		
	}
	
	@Test
	@DisplayName("testing basic blog  / comment mappings")
	void test4() {
		assertNotNull(blog);
		assertNotNull(blog.getComments());
		assertTrue(blog.getComments().size() > 0);
		
	}
	
	@Test
	@DisplayName("testing basic blog  / topic mappings")
	void test5() {
		assertNotNull(blog);
		assertNotNull(blog.getTopics());
		assertTrue(blog.getTopics().size() > 0);
		
	}
}