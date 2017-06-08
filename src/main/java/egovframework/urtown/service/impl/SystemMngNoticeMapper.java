package egovframework.urtown.service.impl;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper("systemMngNoticeMapper")
public interface SystemMngNoticeMapper {

	/**
	 * 공지사항 게시글 데이터
	 * @param map
	 * @return List<HashMap<String, Object>>
	 * @throws Exception
	 */
	public List<HashMap<String, Object>> selectNoticeInfo(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 공지사항 게시글의 총 개수
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int selectNoticeInfoTot(HashMap<String, Object> map) throws Exception;

	/**
	 * 공지사항 게시글 생성
	 * @param map
	 * @return
	 */
	public void insertNoticeInfo(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 공지사항 게시글 삭제
	 * @param map
	 * @return
	 */
	public void deleteNoticeInfo(HashMap<String, Object> map) throws Exception;
	
	/**
	 * 공지사항 게시글 수정
	 * @param map
	 * @return
	 */
	public void updateNoticeInfo(HashMap<String, Object> map) throws Exception;
	
}
