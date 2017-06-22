package egovframework.espa.dao;

public class ESPAConfigVO {
	/*
		cfg_id,
		cfg_name,
		cfg_value,
	 */
	private String cfg_id;
	private String cfg_name;
	private String cfg_value;
	
	public ESPAConfigVO() {
	}
	
	public ESPAConfigVO(String cfg_id) {
		this.cfg_id = cfg_id;
	}
	
	public String getCfg_id() {
		return cfg_id;
	}
	
	public void setCfg_id(String cfg_id) {
		this.cfg_id = cfg_id;
	}
	
	public String getCfg_name() {
		return cfg_name;
	}
	
	public void setCfg_name(String cfg_name) {
		this.cfg_name = cfg_name;
	}
	
	public String getCfg_value() {
		return cfg_value;
	}
	
	public void setCfg_value(String cfg_value) {
		this.cfg_value = cfg_value;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cfg_id == null) ? 0 : cfg_id.hashCode());
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
		ESPAConfigVO other = (ESPAConfigVO) obj;
		if (cfg_id == null) {
			if (other.cfg_id != null)
				return false;
		} else if (!cfg_id.equals(other.cfg_id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ESPAConfigVO [cfg_id=" + cfg_id + ", cfg_name=" + cfg_name + ", cfg_value=" + cfg_value + "]";
	}
	
}


