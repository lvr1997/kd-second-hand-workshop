package com.springmvc.pojo;

import java.io.Serializable;

public class Province implements Serializable{
	
	private static final long serialVersionUID = 662269040070122298L;
	private Integer id;
	private String provinceCode;
	private String provinceName;
	public Province(){
		
	}
	public Province(Integer id, String provinceCode, String provinceName) {
		super();
		this.id = id;
		this.provinceCode = provinceCode;
		this.provinceName = provinceName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProvinceCode() {
		return provinceCode;
	}
	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((provinceCode == null) ? 0 : provinceCode.hashCode());
		result = prime * result + ((provinceName == null) ? 0 : provinceName.hashCode());
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
		Province other = (Province) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (provinceCode == null) {
			if (other.provinceCode != null)
				return false;
		} else if (!provinceCode.equals(other.provinceCode))
			return false;
		if (provinceName == null) {
			if (other.provinceName != null)
				return false;
		} else if (!provinceName.equals(other.provinceName))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Province [id=" + id + ", provinceCode=" + provinceCode + ", provinceName=" + provinceName + "]";
	}
	

}
