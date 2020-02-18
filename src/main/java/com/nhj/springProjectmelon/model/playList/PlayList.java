package com.nhj.springProjectmelon.model.playList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlayList {
	private int id;
	private int userId;
	private String groupName;
	private int musicId;
}
