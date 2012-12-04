module Admin::ApplicationHelper
  def admin_polymorphic_path(model)
    path = ""
    case model.class.name
    when "Video"
      path = admin_video_path(model)
    end
    path
  end
  
  def find_parent_model(comment)
    return comment.commentable_type.constantize.(comment.commentable_id)
  end
end
