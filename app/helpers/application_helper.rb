# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # return the formatted flash[:notice] html
  def success_messages
    if flash[:notice]
      '
      <div id="successMessage" class="successMessage">
    		'+flash[:notice]+'
    	</div>
      '
    else
      ''
    end
  end
  
  
end