/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2014-03-02 05:09:55 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.portal;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class _005fportal_005fjs_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=utf-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${staticURL}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/portal/js/jquery-1.8.3.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${staticURL}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/portal/js/bootstrap/js/bootstrap.min.js\"></script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${staticURL}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/portal/js/HoorayLibs/hooraylibs.js\"></script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${staticURL}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/portal/js/artDialog4.1.6/jquery.artDialog.js?skin=simple\"></script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${staticURL}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/portal/js/artDialog4.1.6/plugins/iframeTools.js\"></script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${staticURL}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/portal/js/Validform_v5.3/Validform_v5.3_min.js\"></script>\r\n");
      out.write("<script>\r\n");
      out.write("$(function(){\r\n");
      out.write("\t//配置artDialog全局默认参数\r\n");
      out.write("\t(function(config){\r\n");
      out.write("\t\tconfig['lock'] = true;\r\n");
      out.write("\t\tconfig['fixed'] = true;\r\n");
      out.write("\t\tconfig['resize'] = false;\r\n");
      out.write("\t\tconfig['background'] = '#000';\r\n");
      out.write("\t\tconfig['opacity'] = 0.5;\r\n");
      out.write("\t})($.dialog.defaults);\r\n");
      out.write("\t//toolTip\r\n");
      out.write("\t$('[rel=\"tooltip\"]').tooltip();\r\n");
      out.write("\t//detailIframe\r\n");
      out.write("\topenDetailIframe = function(url){\r\n");
      out.write("\t\tZENG.msgbox.show('正在载入中，请稍后...', 6, 100000);\r\n");
      out.write("\t\t$('#detailIframe iframe').attr('src', url).load(function(){\r\n");
      out.write("\t\t\tZENG.msgbox._hide();\r\n");
      out.write("\t\t\t$('#detailIframe').animate({\r\n");
      out.write("\t\t\t\t'top' : 0,\r\n");
      out.write("\t\t\t\t'opacity' : 'show'\r\n");
      out.write("\t\t\t}, 500);\r\n");
      out.write("\t\t});\r\n");
      out.write("\t};\r\n");
      out.write("\tcloseDetailIframe = function(callback){\r\n");
      out.write("\t\t$('#detailIframe').animate({\r\n");
      out.write("\t\t\t'top' : '-100px',\r\n");
      out.write("\t\t\t'opacity' : 'hide'\r\n");
      out.write("\t\t}, 500, function(){\r\n");
      out.write("\t\t\tcallback && callback();\r\n");
      out.write("\t\t});\r\n");
      out.write("\t};\r\n");
      out.write("});\r\n");
      out.write("</script>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
