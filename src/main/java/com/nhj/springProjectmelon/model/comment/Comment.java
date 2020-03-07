package com.nhj.springProjectmelon.model.comment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
	private int id;
	private int joinId;
	private int userId;
	private String content;
	private int recommend;
	private int opposite;
	private String type;
}
