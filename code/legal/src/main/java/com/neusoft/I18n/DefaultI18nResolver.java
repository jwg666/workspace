package com.neusoft.I18n;


import java.util.List;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.MessageSourceSupport;

/**
 * 默认的资源文件解析器，该类读取<code>org.springframework.context.i18n.LocaleContextHolder</code>中保存的Local信息解析资源文件
 * @author WangXuzheng
 * @see org.springframework.context.i18n.LocaleContextHolder
 */
public class DefaultI18nResolver extends MessageSourceSupport implements I18nResolver {
	private static final ConcurrentMap<String, ResourceBundle> BUNDLE_MAP = new ConcurrentHashMap<String, ResourceBundle>();
	private static final List<String> DEFAULT_RESOURCE_BUNDLES = new CopyOnWriteArrayList<String>();
	private static final Log LOG = LogFactory.getLog(DefaultI18nResolver.class);
	@SuppressWarnings("rawtypes")
	protected Class clazz;
	/**
	 * 添加全局资源配置信息
	 *
	 * @param resourceBundleName the name of the bundle to add.
	 */
	public static void addDefaultResourceBundle(String resourceBundleName) {
		//make sure this doesn't get added more than once
		synchronized (DEFAULT_RESOURCE_BUNDLES) {
			DEFAULT_RESOURCE_BUNDLES.remove(resourceBundleName);
			DEFAULT_RESOURCE_BUNDLES.add(0, resourceBundleName);
		}

		if (LOG.isDebugEnabled()) {
			LOG.debug("Added default resource bundle '" + resourceBundleName + "' to default resource bundles = "
					+ DEFAULT_RESOURCE_BUNDLES);
		}
	}

	/**
	 * Creates a key to used for lookup/storing in the bundle misses cache.
	 *
	 * @param aBundleName the name of the bundle (usually it's FQN classname).
	 * @param locale      the locale.
	 * @return the key to use for lookup/storing in the bundle misses cache.
	 */
	private String createMissesKey(String aBundleName, Locale locale) {
		return aBundleName + "_" + locale.toString();
	}

	/**
	 * 从全局资源文件中读取文案信息
	 *
	 * @param aTextName 文案 key
	 * @param locale    the locale the message should be for
	 * @return 
	 */
	private String findDefaultText(String aTextName, Locale locale) {
		List<String> localList = DEFAULT_RESOURCE_BUNDLES;
		for (String bundleName : localList) {
			ResourceBundle bundle = findResourceBundle(bundleName, locale);
			if (bundle != null) {
				try {
					return bundle.getString(aTextName);
				} catch (MissingResourceException e) {
					// ignore and try others
				}
			}
		}
		return null;
	}

	/**
	 * 根据资源名称和locale信息查找资源信息
	 * @param aBundleName the name of the bundle (usually it's FQN classname).
	 * @param locale      the locale.
	 * @return the bundle, <tt>null</tt> if not found.
	 */
	protected ResourceBundle findResourceBundle(String aBundleName, Locale locale) {
		String key = createMissesKey(aBundleName, locale);
		ResourceBundle bundle = BUNDLE_MAP.get(key);
		if (bundle == null) {
			bundle = ResourceBundle.getBundle(aBundleName, locale, Thread.currentThread().getContextClassLoader());
			BUNDLE_MAP.put(key, bundle);
		}
		return bundle;
	}

	private Locale getLocale() {
		return LocaleContextHolder.getLocale();
	}

	@Override
	public String getMessage(String code) {
		return getMessage(code, new Object[] {});
	}

	/**
	 * 获取资源消息对应的值,先从指定的bundleName的资源中获取文案，如果找不到，从globalResources中读取
	 * @param bundleName
	 * @param locale
	 * @param key
	 * @param args
	 * @return
	 * @see #findResourceBundle
	 */
	private String getMessage(String bundleName, Locale locale, String key, Object[] args) {
		ResourceBundle bundle = findResourceBundle(bundleName, locale);
		if (bundle == null) {
			return null;
		}

		String orginalMessage = null;
		try {
			orginalMessage = bundle.getString(key);
		} catch (MissingResourceException e) {
			// read text from global resources
			orginalMessage = findDefaultText(bundleName, locale);
		}
		return this.formatMessage(orginalMessage, args, locale);
	}

	@Override
	public String getMessage(String code, Object[] args) {
		return getMessage(resolveBunFile(), getLocale(), code, args);
	}

	@Override
	public String getMessage(String code, Object[] args, String defaultMessage) {
		return StringUtils.defaultIfEmpty(getMessage(code, args), defaultMessage);
	}

	@Override
	public String getMessage(String code, String arg) {
		String[] args = new String[] { arg };
		return getMessage(code, args);
	}

	protected String resolveBunFile() {
		String pack = this.clazz.getName();
		return pack.replaceAll("[.]", "/");
	}

	@SuppressWarnings("rawtypes")
	public void setClass(Class clazz) {
		this.clazz = clazz;
	}
}
