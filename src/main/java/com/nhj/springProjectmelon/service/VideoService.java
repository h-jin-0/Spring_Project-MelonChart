package com.nhj.springProjectmelon.service;

import java.io.IOException;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nhj.springProjectmelon.model.music.Music;
import com.nhj.springProjectmelon.repository.MusicRepository;
import com.nhj.springProjectmelon.repository.VideoRepository;

@Service
public class VideoService {
	@Autowired
	private MusicRepository musicRepository;
	@Autowired
	private VideoRepository videoRepository;

	public int videoSave() {

		int result = 0;
		List<Music> musics = musicRepository.findAll();
		try {

			for (int i = 0; i < musics.size(); i++) {

				musics.get(i).getId();

				String title = musics.get(i).getTitle();
				title = title.replace(" ", "+");
				title = title.replace("(", "%28");
				title = title.replace(")", "%29");
				title = title.replace(",", "%2C");
				Document docYoutube = Jsoup.connect("https://www.youtube.com/results?search_query=" + title + "-MV")
						.get();
				Elements musicVideoLink_el = docYoutube.select("h3.yt-lockup-title a");
				String musicVideoLink = musicVideoLink_el.attr("href");
				String musicLink = musicVideoLink.substring(musicVideoLink.indexOf("=") + 1, musicVideoLink.length());

				
				if(musicLink.equals("")) {
					System.out.println("실패한 아이디 : "+musics.get(i).getId());
				}else {
					System.out.println("id:"+musics.get(i).getId()+"link:"+musicLink);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}
}
