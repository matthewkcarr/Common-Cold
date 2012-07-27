class Relationship < ActiveRecord::Base

  # Virtual attribute for relationship type
  attr_accessor :relationship_type

  Types = {:Family => 'family', :Contact => 'contact', :Friend => 'friend' }
  validates_inclusion_of :relationship_type, :in => Types.values

  belongs_to :initiator,
             :foreign_key => "user_id",
             :class_name => "User"
  belongs_to :receiver,
             :foreign_key => "other_user_id",
             :class_name => "User"

  def Relationship::existing(first_id, second_id)
    relationship = find(:first,
                        :conditions => ['(user_id = ? and other_user_id = ?) OR
                                         (user_id = ? and other_user_id = ?)',
                                         first_id, second_id, second_id, first_id])
    return relationship if relationship
  end

  def Relationship::valid_type(type)
    type = type.to_s.downcase
    if type == 'friend' || type == 'family' || type == 'contact'
      return true
    end
    return false
  end

end

