class GroupTransactionsController < ApplicationController
  def index
    
  end

  def new
    @group  = current_user.groups.where(id: params[:group_id]).first
    if @group
      @group_transaction = @group.group_transactions.new
      @members = @group.group_members
    else
      redirect_to groups_path
    end
  end

  def create
    @group  = current_user.groups.where(id: params[:group_id]).first
    
    if @group
      @group_transaction = @group.group_transactions.new(create_params.merge({user_id: current_user.id}))
      if @group_transaction.save 
        unless @group_transaction.all_group 
          @group_transaction.add_members(params[:members].values.map(&:to_i)) if params[:members].present?
        end
        redirect_to "/groups/#{@group.id}"
      else
        render :new
      end
    else
      redirect_to groups_path
    end
  end
  
  private 
  
  def create_params
    params.require(:group_transaction).permit(:amount, :reason, :all_group)
  end
end
