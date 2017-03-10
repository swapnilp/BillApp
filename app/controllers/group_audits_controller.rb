class GroupAuditsController < ApplicationController

  def index
    @group  = current_user.groups.where(id: params[:group_id]).first
    
    if @group
      @group_audits = @group.group_audits
    else
      redirect_to "/groups"
    end
  end

  def show
    @group  = current_user.groups.where(id: params[:group_id]).first
    
    if @group
      @group_audit = @group.group_audits.where(id: params[:id]).first
      @users = @group_audit.au_report 
      #@group_audits = @group.group_audits
    else
      redirect_to "/groups"
    end
  end
  
end
