package com.nhj.springProjectmelon.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nhj.springProjectmelon.model.music.Music;
import com.nhj.springProjectmelon.repository.MusicRepository;

@Service
public class MusicService {

	@Autowired
	private MusicRepository musicRepository;

	@Transactional
	public List<Music> melonChart() {

		return musicRepository.findAll();

	}

	@Transactional
	public int musicSave() {
		int result = 0;
		try {
			String singer = null;
			ArrayList<String> singers = new ArrayList<String>();
			Music music = new Music();

			Document docMelon = Jsoup.connect("https://www.melon.com/chart/index.htm").get();
			Elements albums = docMelon.select(".wrap_song_info .rank03");
			Elements titles = docMelon.select(".wrap_song_info .rank01 a");
			Elements singers_els = docMelon.select(".wrap_song_info .rank02");
			Elements photos = docMelon.select(".image_typeAll img");
			
			for (Element el : singers_els) {
				singer = el.select("span a").text();
				singers.add(singer);

			}
			for (int i = 0; i < titles.size(); i++) {
				music.setAlbum(albums.get(i).text());
				music.setTitle(titles.get(i).text());
				music.setSinger(singers.get(i));
				music.setPhoto(photos.get(i).attr("src"));
				
				System.out.println("albums : "+albums.get(i).text());
				System.out.println("title : "+titles.get(i).text());
				System.out.println("singers : "+singers.get(i));
				System.out.println("photos : "+photos.get(i).attr("src"));
	
				musicRepository.save(music);
				
//				String title = titles.get(i).text();
//				title = title.replace(" ", "+");
//				title = title.replace("(", "%28");
//				title = title.replace(")", "%29");
//				title = title.replace(",", "%2C");
//				Document docYoutube = Jsoup.connect("https://www.youtube.com/results?search_query=" + title + "-MV").get();
//				Elements musicVideoLink_el = docYoutube.select("h3.yt-lockup-title a");
//				String musicVideoLink = musicVideoLink_el.attr("href");
//				String musicLink = musicVideoLink.substring(musicVideoLink.indexOf("=") + 1, musicVideoLink.length());
//				melon.setMusicLink(musicLink);
//				System.out.println(musicVideoLink);
//				System.out.println("test:" + ranks.get(i + 1).text() + " : " + title + " : " + musicLink);
//				melonRepository.save(melon);
			}

		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
		return result;

	}

	@Transactional
	public int melonMusic(String title) {
		int result = 0;

		try {
			Document doc = Jsoup.connect("https://www.youtube.com/results?search_query=" + title + "-MV").get();
//			Document doc = Jsoup.connect("https://www.youtube.com/results").data("search_query", "아무노래-MV").post();
			Elements musicVideoLink_el = doc.select("h3.yt-lockup-title a");
//			Elements musicLink=doc.select("#video-title");

			String musicVideoLink = musicVideoLink_el.attr("href");

			StringTokenizer str = new StringTokenizer(musicVideoLink, "=");
			str.nextToken();
			String musicLink = str.nextToken();
			System.out.println(musicLink);

		} catch (java.io.IOException e) {
			e.printStackTrace();
		}
		return result;

	}
}
