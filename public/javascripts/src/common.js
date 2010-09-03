var Common = {};

/**
 * @summary Coderblogs可视化文本编辑器
 * @author 李华顺<huacnlee@gmail.com>
 */
Common.Editor = {

	varsion : "0.1",

	/**
	 * @summary 创建可视化编辑器
	 * @params
	 *		elementId <object> 创建到个对象里面
	 *		id <string> 编辑器的 elementId
	 * 		textId <string> 文本框的elementId
	 * 		textName <string> 文本框的name
	 */
	create : function(elementId,rows){
		if(! tinyMCE){
			alert("还未引用TinyMCE的JS文件。");
			return false;
		}

		// tinyMCE init
		tinyMCE.init({
			mode : "textareas",
			editor_selector : "tinymce",
			theme : "advanced",
			language : "zh",
			convert_urls : false,
			theme_advanced_toolbar_location : "top",
			theme_advanced_toolbar_align : "left",
			theme_advanced_buttons1 : "fullscreen,separator,formatselect,fontselect,separator,bold,italic,underline,strikethrough,separator,bullist,numlist,outdent,indent,separator,undo,redo,separator,link,unlink,anchor,separator,cleanup,separator",
			theme_advanced_buttons2 : "",
			theme_advanced_buttons3 : "",
			auto_cleanup_word : true,
			plugins : "table,save,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,searchreplace,contextmenu,fullscreen",
			plugin_insertdate_dateFormat : "%m/%d/%Y",
			plugin_insertdate_timeFormat : "%H:%M:%S",
			extended_valid_elements : "a[name|href|target=_blank|title|onclick],img[class|src|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name],hr[class|width|size|noshade],font[face|size|color|style],span[class|align|style]",
			fullscreen_settings : {
				theme_advanced_path_location : "top",
				theme_advanced_buttons1 : "fullscreen,separator,preview,separator,cut,copy,paste,separator,undo,redo,separator,search,replace,separator,code,separator,cleanup,separator,bold,italic,underline,strikethrough,separator,forecolor,backcolor,separator,justifyleft,justifycenter,justifyright,justifyfull,separator,help",
				theme_advanced_buttons2 : "removeformat,styleselect,formatselect,fontselect,fontsizeselect,separator,bullist,numlist,outdent,indent,separator,link,unlink,anchor",
				theme_advanced_buttons3 : "sub,sup,separator,image,insertdate,inserttime,separator,tablecontrols,separator,hr,advhr,visualaid,separator,charmap,emotions,iespell,flash,separator,print"
			},
			theme_advanced_resizing : true,
			theme_advanced_resize_horizontal : false	
		});
		return true;
	}

}

