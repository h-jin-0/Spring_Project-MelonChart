package com.nhj.springProjectmelon.model.comment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Commnet {
	private int id;
	private int joinId;
	private int userId;
	private String content;
	private String recommend;
	private String opposite;
	private String type;

}
