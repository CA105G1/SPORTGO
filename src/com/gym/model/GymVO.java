package com.gym.model;

public class GymVO {
	
	private Integer gym_id;
	private String gym_name;
	private String gym_funclist;
	
	public GymVO() {
		
	}
	
	public Integer getGym_id() {
		return gym_id;
	}
	public void setGym_id(Integer gym_id) {
		this.gym_id = gym_id;
	}
	public String getGym_name() {
		return gym_name;
	}
	public void setGym_name(String gym_name) {
		this.gym_name = gym_name;
	}
	public String getGym_funclist() {
		return gym_funclist;
	}
	public void setGym_funclist(String gym_funclist) {
		this.gym_funclist = gym_funclist;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((gym_id == null) ? 0 : gym_id.hashCode());
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
		GymVO other = (GymVO) obj;
		if (gym_id == null) {
			if (other.gym_id != null)
				return false;
		} else if (!gym_id.equals(other.gym_id))
			return false;
		return true;
	}
	
	
}
