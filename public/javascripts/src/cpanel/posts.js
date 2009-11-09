var CpanelPosts = {
	settings : {
		bodyId : "post_body"
	},
	
	init : function(settings){
		$.extend(CpanelPosts.settings,settings);
		Common.Editor.create(CpanelPosts.settings.bodyId,40);
	}
}