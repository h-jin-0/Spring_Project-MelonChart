package com.nhj.springProjectmelon.model.music;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Music {
	private int id;
	private String title;
	private String singer;
	private String album;
	private String photo;
	private int heart;
	
}
