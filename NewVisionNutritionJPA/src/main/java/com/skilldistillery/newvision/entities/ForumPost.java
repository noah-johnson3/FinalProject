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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="forum_post")
public class ForumPost {


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	
	private String topic;
	
	private String content;
	
	@JsonIgnoreProperties({"forums", "blogs", "comments", "recipes", "createdRecipes", "trackedDays"})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@CreationTimestamp
	@Column(name="created_at")
	private LocalDateTime createdAt;
	
	@JsonIgnoreProperties({"inReplyTo", "responses"})
	@ManyToOne
	@JoinColumn(name="in_reply_to_id")
	private ForumPost inReplyTo;
	
	@JsonIgnoreProperties({"inReplyTo", "responses"})
	@OneToMany(mappedBy=("inReplyTo"))
	private List<ForumPost> responses;
	
	public ForumPost() {}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public ForumPost getInReplyTo() {
		return inReplyTo;
	}

	public void setInReplyTo(ForumPost inReplyTo) {
		this.inReplyTo = inReplyTo;
	}

	public List<ForumPost> getResponses() {
		return responses;
	}

	public void setResponses(List<ForumPost> responses) {
		this.responses = responses;
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
		ForumPost other = (ForumPost) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Forum [id=" + id + ", topic=" + topic + ", content=" + content + ", user=" + user + ", createdAt="
				+ createdAt + ", inReplyTo=" + inReplyTo + ", responses=" + responses + "]";
	}
	
	
	
	
}
