package it.unisa.model;

import java.sql.SQLException;
import java.util.Collection;

public interface GenericDAO<T> {
	public T doRetriveByKey(String code) throws SQLException;

	public Collection<T> doRetriveAll(String order) throws SQLException;
	
	public void doSave(T item) throws SQLException;
	
	public int doUpdate(T item) throws SQLException;
	
	public boolean doDelete(T item) throws SQLException;

}
