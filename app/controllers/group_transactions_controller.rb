class GroupTransactionsController < ApplicationController
  def index
    
  end

  def new
    @group  = current_user.groups.where(id: params[:group_id]).first
    if @group
      @group_transaction = @group.group_transactions.new
    else
      redirect_to groups_path
    end
  end

  def create
    @group  = current_user.groups.where(id: params[:group_id]).first
    
    if @group
      @group_transaction = @group.group_transactions.new(create_params)
      if @group_transaction.save 
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
    params.require(:group_transaction).permit(:amount, :reason)
  end
end
