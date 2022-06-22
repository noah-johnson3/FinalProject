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

class CommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

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
	    comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
	    em.close();
	    comment = null;
	}

	@Test
	@DisplayName("testing basic comment mappings")
	void test1() {
		assertNotNull(comment);
		assertEquals(comment.getContent(), "YES I CAN HEAR YOU - WHY ARE YOU IN MY COMPUTER???!");
		
	}
	@Test
	@DisplayName("testing basic comment / blog mappings")
	void test2() {
		assertNotNull(comment);
		assertEquals(comment.getBlog().getTitle(), "Blog 1 TEST");
		
		
	}
}
