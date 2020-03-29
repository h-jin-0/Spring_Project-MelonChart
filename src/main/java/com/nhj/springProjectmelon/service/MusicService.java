package com.nhj.springProjectmelon.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nhj.springProjectmelon.model.likes.dto.RespMelonChartDto;
import com.nhj.springProjectmelon.model.music.Music;
import com.nhj.springProjectmelon.model.music.dto.ReqPageDto;
import com.nhj.springProjectmelon.model.music.dto.RespListenListDto;
import com.nhj.springProjectmelon.model.music.dto.RespMelonJoinDto;
import com.nhj.springProjectmelon.model.playList.dto.ReqListenListDto;
import com.nhj.springProjectmelon.repository.LikesRepository;
import com.nhj.springProjectmelon.repository.MusicRepository;

@Service
public class MusicService {

	@Autowired
	private MusicRepository musicRepository;

	@Autowired
	private MyUserDetailService myUserDetailService;

	@Autowired
	private LikesRepository likesRepository;

	public List<RespMelonJoinDto> musicCharts(int startPage) {
		ReqPageDto reqPageDto = new ReqPageDto();
		reqPageDto.setPerPageNum(50);
		reqPageDto.setStartPage(startPage);
		List<RespMelonJoinDto> musicInfo = musicRepository.findAllWithLikes(reqPageDto);

		if (myUserDetailService.getPrincipal() != null) {
			int principalId = myUserDetailService.getPrincipal().getId();
			List<RespMelonChartDto> likesInfo = likesRepository.findByUserId(principalId);

			for (int j = 0; j < musicInfo.size(); j++) {
				for (int i = 0; i < likesInfo.size(); i++) {
					if (musicInfo.get(j).getId() == likesInfo.get(i).getMusicId()) {
						musicInfo.get(j).setLikesStatus(true);
					}
				}
			}
			return musicInfo;
		} else {
			return musicInfo;
		}
	}

	@Transactional
	public int videoSave() {
		// 트래픽발생이 심해서 멜론 크롤링이랑 유튜브 크롤링은 분리했다.
		int result = 0;

		try {
			List<Music> musics = musicRepository.findAll();
			Music music = new Music();

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

				music.setId(musics.get(i).getId());
				music.setVideoLink(musicLink);
				musicRepository.saveById(music);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
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
			Elements songNos = docMelon.select("tbody tr");

			for (Element el : singers_els) {
				singer = el.select("span a").text();
				singers.add(singer);

			}
			for (int i = 0; i < titles.size(); i++) {

				music.setTitle(titles.get(i).text());
				music.setSinger(singers.get(i));
				music.setAlbum(albums.get(i).text());

				music.setSongNo(Integer.parseInt(songNos.get(i).attr("data-song-no")));
				int songNo = Integer.parseInt(songNos.get(i).attr("data-song-no"));

				String USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36";
				Document doc = Jsoup.connect("https://www.melon.com/song/detail.htm?songId=" + songNo)
						.header("Content-Type", "application/json;charset=UTF-8").userAgent(USER_AGENT)
						.method(Connection.Method.GET).ignoreContentType(true).get();
				Elements photos = doc.select(".image_typeAll img");
				Elements others = doc.select(".list dd");
				Elements lyric_el = doc.select("#d_video_summary");
				String beforeLyrics = lyric_el.get(0).html();
				String lyrics = beforeLyrics.substring(beforeLyrics.indexOf(">") + 1, beforeLyrics.length());

				Date originDate = new SimpleDateFormat("yyyy.MM.dd").parse(others.get(1).html());
				SimpleDateFormat newFormat = new SimpleDateFormat("yyyy-MM-dd");

				music.setPhoto(photos.attr("src"));
				music.setLyrics(lyrics);
				music.setGenre(others.get(2).html());
				music.setAlbumDate((newFormat.format(originDate)));

				musicRepository.save(music);

//				System.out.println(i);
//				System.out.println("title : " + titles.get(i).text());
//				System.out.println("singers : " + singers.get(i));
//				System.out.println("albums : " + albums.get(i).text());
//				System.out.println("photos : " + photos.get(i).attr("src"));
//				System.out.println("songNo:" + songNos.get(i).attr("data-song-no"));
//				System.out.println("발매일:" + (newFormat.format(originDate)));
//				System.out.println("장르:" + others.get(2).html());
//				System.out.println("가사:" + lyric);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}

	public Music musicDetail(int id) {
		return musicRepository.findById(id);
	}

	public int serarchByTitle(String searchTitle) {
		return musicRepository.IdFindByTitle(searchTitle);
	}

	public List<RespListenListDto> findById(ReqListenListDto reqListenListDto) {
		List<RespListenListDto> reqListenListDtos = new ArrayList<RespListenListDto>();
		for (int findId : reqListenListDto.getList()) {
			RespListenListDto result = musicRepository.listenListfindById(findId);
			if (result != null) {
				reqListenListDtos.add(result);
			}
		}
		return reqListenListDtos;
	}
}
