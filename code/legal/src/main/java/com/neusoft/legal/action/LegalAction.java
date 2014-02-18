package com.neusoft.legal.action;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.neusoft.base.action.BaseAction;
import com.neusoft.base.domain.Dictionary;
import com.neusoft.base.query.DictionaryQuery;
import com.neusoft.base.service.DictionaryService;
/**
 * 
 * @author jiawg
 *
 */
@Controller
@Scope("prototype")
public class LegalAction extends BaseAction{
	private static final long serialVersionUID = 8032958721886686532L;
	@javax.annotation.Resource
	private	DictionaryService dictionaryService;
	private List<DictionaryQuery> dictionaryInfoList = new ArrayList<DictionaryQuery>();
	public String stepOne(){
		try {
//			DictionaryQuery aa = new DictionaryQuery();
//			dictionaryInfoList = dictionaryService.listAll(aa);
//			System.out.println(">>>dictionaryInfoList:"+dictionaryInfoList.size()+"");
			return "legal";
		} catch (Exception e) {
			logger.debug(">>>>",e);
		}
		return null;
	}
}
