  has_many :initiated_contact,
           :foreign_key => 'user_id',
           :class_name => 'Contact'
  has_many :received_contact,
           :foreign_key => 'other_user_id',
           :class_name => 'Contact'
  has_many :initiated_contacts, :through => :initiated_contact,
           :source => :receiver
  has_many :received_contacts, :through => :received_contact,
           :source => :initiator

  has_many :initiated_friends,
           :foreign_key => 'user_id',
           :class_name => 'Friend'
  has_many :received_friends,
           :foreign_key => 'other_user_id',
           :class_name => 'Friend'
  has_many :initiated_friendships, :through => :initiated_friends,
           :source => :receiver
  has_many :received_friendships, :through => :received_friends,
           :source => :initiator

  has_many :initiated_fam,
           :foreign_key => 'user_id',
           :class_name => 'Family'
  has_many :received_fam,
           :foreign_key => 'other_user_id',
           :class_name => 'Family'
  has_many :initiated_family, :through => :initiated_fam,
           :source => :receiver
  has_many :received_family, :through => :received_fam,
           :source => :initiator

  #this is using two select statements, we need to
  #fix...
  def contacts
    first_set = self.initiated_contacts
    second_set = self.received_contacts
    return first_set + second_set
  end

  #this is using two select statements, then we need to
  #fix...
  def friends
    first_set = self.initiated_friendships
    second_set = self.received_friendships
    return first_set + second_set
  end

  #this is using two select statements, we need to
  #fix...
  def family
    first_set = self.initiated_family
    second_set = self.received_family
    return first_set + second_set
  end

