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

		var owner = $("#"+elementId);
		var editorid = "editor_box_"+elementId;
		var elementName = owner.attr("name");
		var content = owner.val();

		if(rows == undefined){
			rows = 24;
		}

		var result = EDITOR_TEMPLATE;
		result = result.replace('{{editorid}}',editorid);
		result = result.replace('{{textId}}',elementId);
		result = result.replace('{{txtName}}',elementName);
		result = result.replace('{{value}}',content);
		result = result.replace('{{rows}}',rows);

		owner.after(result);
		owner.remove();

		var editor = $('#' + editorid);
		var txtBody = $('#' + elementId);
		var subButtons = $(".sub_buttons",editor)
		var btnShow = $('.buttons .view button.show',editor);

		// 绑定事件
		btnShow.click(function(){
			$('.view button',editor).removeClass('selected');
			$(this).addClass('selected');
			tinyMCE.activeEditor.setContent(txtBody.val());
			txtBody.hide();
			subButtons.hide();
			txtBody.focus();
			 $('#' + elementId + '_parent').show();
		});

		$('.buttons .view button.code',editor).click(function(){
			$('.view button',editor).removeClass('selected');
			$(this).addClass('selected');
			txtBody.val(tinyMCE.activeEditor.getContent());
			txtBody.show();
			txtBody.focus();
			subButtons.show();
			 $('#' + elementId + '_parent').hide();
		});

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


// Coderblogs Editor HTML 模板
EDITOR_TEMPLATE = '\
<div id="{{editorid}}" class="tinymce_box">\
	<div class="buttons">\
		<div class="insert">\
			上传/插入 <span class="link"><a href="#" class="insert_image"></a><a href="#" class="insert_file"></a></link>\
		</div>\
		<div class="view">\
			<button	type="button" class="show selected">可视化</button><button type="button" class="code">代码</button>\
		</div>\
		<div class="clear"></div>\
	</div>\
	<div id="edit_box">	\
		<div class="sub_buttons" style="display:none;"></div>		\
		<textarea id="{{textId}}" name="{{txtName}}" class="tinymce text long" rows="{{rows}}">{{value}}</textarea>\
	</div>\
</div>';


