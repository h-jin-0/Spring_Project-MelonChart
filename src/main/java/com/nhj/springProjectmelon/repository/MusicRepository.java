package com.nhj.springProjectmelon.repository;

import java.util.List;

import com.nhj.springProjectmelon.model.music.Music;

public interface MusicRepository {
	List<Music> findAll();
	int save(Music music);
}
