package egovframework.systemmgr.dao;

public class SystemMgrMenuVO {
/*
 * T.MENU_SQ,
		  			T.PARENT_SQ,
		  			T.MENU_ORDER,
					T.MENU_NM,
					T.MENU_ID,
					T.MENU_URL,
					T.MENU_DESC,
					T.MENU_CONTENT,
					CASE WHEN T.USE_YN = '1' THEN true ELSE false end USE_YN,
					M.MENU_SQ 		AS MAIN_SQ,
				  	M.MENU_ORDER 	AS MAIN_ORDER,
					M.MENU_NM 		AS MAIN_NM,
					M.MENU_ID 		AS MAIN_ID,
					M.MENU_URL 		AS MAIN_URL,
					M.MENU_DESC 	AS MAIN_DESC,
					M.MENU_CONTENT 	AS MAIN_CONTENT,
					CASE WHEN M.USE_YN = '1' THEN true ELSE false end MAIN_USE_YN
 */
	
	private long menu_sq;
	private long parent_sq;
	private String menu_nm;
	private String menu_id;
	private String menu_url;
	private String menu_desc;
	private long main_sq;
	private long main_order;
	private String main_nm;
	private String main_id;
	
	public SystemMgrMenuVO() {
		
	}
	
	public SystemMgrMenuVO(String menu_id) {
		this.menu_id = menu_id;
	}
	
	public long getMenu_sq() {
		return menu_sq;
	}
	
	public void setMenu_sq(long menu_sq) {
		this.menu_sq = menu_sq;
	}
	
	public long getParent_sq() {
		return parent_sq;
	}
	
	public void setParent_sq(long parent_sq) {
		this.parent_sq = parent_sq;
	}
	
	public String getMenu_nm() {
		return menu_nm;
	}
	
	public void setMenu_nm(String menu_nm) {
		this.menu_nm = menu_nm;
	}
	
	public String getMenu_id() {
		return menu_id;
	}
	
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	
	public String getMenu_url() {
		return menu_url;
	}
	
	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}
	
	public String getMenu_desc() {
		return menu_desc;
	}
	
	public void setMenu_desc(String menu_desc) {
		this.menu_desc = menu_desc;
	}
	
	public long getMain_sq() {
		return main_sq;
	}
	
	public void setMain_sq(long main_sq) {
		this.main_sq = main_sq;
	}
	
	public long getMain_order() {
		return main_order;
	}
	
	public void setMain_order(long main_order) {
		this.main_order = main_order;
	}
	
	public String getMain_nm() {
		return main_nm;
	}
	
	public void setMain_nm(String main_nm) {
		this.main_nm = main_nm;
	}
	
	public String getMain_id() {
		return main_id;
	}
	
	public void setMain_id(String main_id) {
		this.main_id = main_id;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((main_id == null) ? 0 : main_id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SystemMgrMenuVO other = (SystemMgrMenuVO) obj;
		if (menu_id == null) {
			if (other.menu_id!= null)
				return false;
		} else if (!menu_id.equals(other.menu_id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SystemMgrMenuVO [menu_sq=" + menu_sq + ", parent_sq=" + parent_sq + ", menu_nm=" + menu_nm
				+ ", menu_id=" + menu_id + ", menu_url=" + menu_url + ", menu_desc=" + menu_desc + ", main_sq="
				+ main_sq + ", main_order=" + main_order + ", main_nm=" + main_nm + ", main_id=" + main_id + "]";
	}
}
