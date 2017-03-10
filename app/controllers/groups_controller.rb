class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @groups = current_user.groups
  end

  def show
    @group  = current_user.groups.where(id: params[:id]).first
    @transactions = @group.group_transactions
  end
  
  def  new
    @group  = current_user.groups.new
  end
  
  def create
    @group  = current_user.groups.new(create_params)
    if @group.save
      
      redirect_to "/groups/#{@group.id}"
    else
      render :new
    end
  end

  def members
    @group  = current_user.groups.where(id: params[:id]).last
    if @group
      @users = User.where("id not in (?)", @group.group_members.map(&:user_id) << 0)
    else 
      redirect_to groups_path
    end
  end
  
  def add_members
    @group  = current_user.groups.where(id: params[:id]).last
    if @group
      if params[:group_member].present?
        @group.add_members(params[:group_member].values.map(&:to_i))
      end
      
      #@users = User.where("id not in (?)", @group.group_members.map(&:user_id))
      redirect_to "/groups/#{@group.id}"
    else 
      redirect_to groups_path
    end
  end

  def make_audit
    @group  = current_user.groups.where(id: params[:id]).last
    if @group
      @group.make_audit(current_user.id)
      redirect_to "/groups/#{@group.id}"
    else 
      redirect_to groups_path
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def create_params
    params.require(:group).permit(:name, :reason)
  end
end
