package com.nhj.springProjectmelon.model.video;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Video {
	private int id;
	private int musicId;
	private String link;
	private String viewCount;
}
