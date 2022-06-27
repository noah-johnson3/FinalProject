package com.skilldistillery.newvision.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class TrackedDayTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private TrackedDay trackedDay;

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
	    trackedDay = em.find(TrackedDay.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    trackedDay = null;
	}

	@Test
	@DisplayName("testing basic user mappings")
	void test1() {
		assertNotNull(trackedDay);
		assertEquals(trackedDay.getId(), 1);
		
	}
}