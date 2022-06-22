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

public class TopicTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Topic topic;

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
	    topic = em.find(Topic.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    topic = null;
	}

	@Test
	@DisplayName("testing basic topic mappings")
	void test1() {
		assertNotNull(topic);
		assertEquals(topic.getName(), "Test Topic");
		
	}
	@Test
	@DisplayName("testing basic topic / blog mappings")
	void test2() {
		assertNotNull(topic);
		assertNotNull(topic.getBlogs());
		assertTrue(topic.getBlogs().size() > 0);
		
	}
}