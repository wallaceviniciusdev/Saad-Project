$(document).ready(function(){$(document).bind("ajaxError","form#new_strength_modal",function(t,e){$(t.data).render_form_errors($.parseJSON(e.responseText))})}),function(t){t.fn.modal_success=function(){this.modal("hide"),this.find('form input[type="text"]').val(""),this.clear_previous_errors()},t.fn.render_form_errors=function(e){$form=this,this.clear_previous_errors(),model=this.data("model"),t.each(e,function(e,n){$input=t('input[name="'+model+"["+e+']"]'),$input.closest(".form-group").addClass("has-error").find(".help-block").html(n.join(" & "))})},t.fn.clear_previous_errors=function(){t(".form-group.has-error",this).each(function(){t(".help-block",t(this)).html(""),t(this).removeClass("has-error")})}}(jQuery);