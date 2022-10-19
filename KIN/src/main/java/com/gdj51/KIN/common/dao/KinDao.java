package com.gdj51.KIN.common.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class KinDao implements IKinDao {
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getInt(String sql) throws Throwable {
		return sqlSession.selectOne(sql);
	}

	@Override
	public int getInt(String sql, HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne(sql, params);
	}

	@Override
	public String getString(String sql) throws Throwable {
		return sqlSession.selectOne(sql);
	}

	@Override
	public String getString(String sql, HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne(sql, params);
	}

	@Override
	public HashMap<String, String> getMap(String sql) throws Throwable {
		return sqlSession.selectOne(sql);
	}

	@Override
	public HashMap<String, String> getMap(String sql, HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne(sql, params);
	}

	@Override
	public List<HashMap<String, String>> getList(String sql) throws Throwable {
		return sqlSession.selectList(sql);
	}

	@Override
	public List<HashMap<String, String>> getList(String sql, HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList(sql, params);
	}

	@Override
	public int insert(String sql) throws Throwable {
		return sqlSession.insert(sql);
	}

	@Override
	public int insert(String sql, HashMap<String, String> params) throws Throwable {
		return sqlSession.insert(sql, params);
	}

	@Override
	public int update(String sql) throws Throwable {
		return sqlSession.update(sql);
	}

	@Override
	public int update(String sql, HashMap<String, String> params) throws Throwable {
		return sqlSession.update(sql, params);
	}
	
	@Override
	public int delete(String sql) throws Throwable {
		return sqlSession.delete(sql);
	}

	@Override
	public int delete(String sql, HashMap<String, String> params) throws Throwable {
		return sqlSession.delete(sql, params);
	}

	@Override
	public List<HashMap<String, String>> delete(String sql, List<HashMap<String, String>> a) throws Throwable {
		return sqlSession.selectList(sql, a);
	}
	
}
