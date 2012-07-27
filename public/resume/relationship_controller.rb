class RelationshipController < ApplicationController

  def create
    relationship = params[:relationship]
    other_user_id = relationship[:other_user_id]
    type = relationship[:relationship_type]
    if other_user_id.to_s == current_user.id.to_s
      flash[:notice] = "You can't add yourself."
      redirect_to(:controller => :profile, :action => :show, :id => other_user_id) and return
    end
    if !Relationship.valid_type(type)
      redirect_to(:controller => :profile, :action => :show, :id => other_user_id) and return
    end
    if existing_relationship(current_user.id, other_user_id, type)
      redirect_to(:controller => :profile, :action => :show, :id => other_user_id) and return
    end
    save(current_user.id, other_user_id, type)
    redirect_to(:controller => :profile, :action => :show, :id => other_user_id )
  end

  def new
    @id = params[:id]
    @relationship = Relationship.existing(current_user.id, @id)
    if !@relationship
      @relationship = Relationship.new(:user_id => current_user.id, :other_user_id => @id, :relationship_type => 'conta
ct')
    else
      @relationship.relationship_type = @relationship.class.to_s.downcase
      @remove = true
      @remove_text = "Remove from " + @relationship.relationship_type + " list."
    end
    render(:layout => false, :locals => { :hidden => true }  )
  end
 def delete
   existing = Relationship.find(params[:relationship])
   flash[:notice] = "You have removed this person from your " + existing.class.to_s + " list."
   existing.destroy
   redirect_to(:controller => :profile, :action => :show, :id => existing.other_user_id) and return
  end

  private

  def save(first_id, second_id, type)
    if type == "friend"
      friend = Friend.new( :user_id => first_id, :other_user_id => second_id, :relationship_type => type)
      friend.save!
    elsif type == "family"
      family = Family.new( :user_id => first_id, :other_user_id => second_id, :relationship_type => type)
      family.save
    else
      contact = Contact.new( :user_id => first_id, :other_user_id => second_id, :relationship_type => type)
      contact.save
    end
    flash[:notice] = determine_notice(type)
  end

  def existing_relationship(first_id, second_id, proposed_type)
    existing =  Relationship.existing(first_id, second_id)
    if existing
      if can_update(existing, proposed_type)
        existing.destroy #update_attributes(:type => proposed_type)
        save(first_id, second_id, proposed_type)
      else
        flash[:notice] = "This person is already in your #{existing.class.to_s} list."
      end
      return true
    end
    return false
  end
 def can_update(existing, proposed_type)
    existing = existing.class.to_s.downcase
    if existing == proposed_type
      return false
    end
    if existing == "contact"
      return true
    end
    if existing == "friend" && proposed_type == "family"
      return true
    end
    return false
  end

  def determine_notice(type)
    if type == "friend" || type == "family"
      return "This person has been sent a " + type + " confirmation request."
      #TODO: send confirmation request
    elsif type == "contact"
      return "This person has been added to your " + type.pluralize + " list."
    end
  end

end

