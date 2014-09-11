class MembersController < ApplicationController
  before_action :get_member, except: [:new, :create, :update]
  before_action :authenticate_member_from_email

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def join_community
    @new_community = Community.find(params[:community_id])
    @member.member_communities.build(community: @new_community)
    @member.save
    flash[:notice] = "Welcome to #{@new_community.name}!"
    redirect_to @new_community
  end

  def leave_community
    @community = Community.find_by(params[:community_id])
    @member.member_communities.find_by(params[:community_id]).delete
    @member.save
    flash[:notice] = "Successfully left #{@community.name}"
    redirect_to root_path
  end

  def join_group
    @old_group = @member.group
    @new_group = Group.find(params[:group_id])
    @member.group = @new_group
    @member.save
  end

  def join_group_from_email
    join_group
    @group = Group.find(params[:group_id])
    @community = Community.find(@group.community.id)
    flash[:notice] = "You joined the group going to #{@group.restaurant.name} at #{@group.show_time}"
    redirect_to community_groups_path(@community, @group)
  end

  def leave_group
    @old_group = @member.group
    @member.group = nil
    @member.save
  end

  private

    def authenticate_member_from_email
      if !current_member
        flash[:alert] = "Please sign in to continue"
        redirect_to root_path
      elsif current_member.id != params[:id]
        flash[:alert] = "You are not logged in as the user to whom this invitation was sent. Please log in with the correct account to continue."
        redirect_to root_path
      end
    end

    def get_member
      @member = Member.find(params[:id])
    end

    def member_params
      # TODO - fix please
      params.require(:member).permit(:name, :email, :community_id)
    end

end