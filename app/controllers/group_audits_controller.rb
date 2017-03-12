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
      
      previous_audit =  @group.group_audits.where("id < ? ", @group_audit.id).last
      @transaction = @group.group_transactions.where("created_at <= ?", @group_audit.created_at)
      if previous_audit.present?
        @transaction = @transaction.where("created_at  >= ?", previous_audit.created_at)
      end
      #@group_audits = @group.group_audits
    else
      redirect_to "/groups"
    end
  end
  
end
