class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    # => 

        user ||= User.new # guest user (not logged in)
        if user.banners_permission?
            can :manage, Banner
        end
        if user.create_articles_permission?
            can [:new, :create, :edit, :update, :show, :index], Article
            can [:manage], Relationship, relationship_type: 'Investigation'
            can [:manage], Relationship, relationship_type: 'Collaborator'
            can [:manage], [Keyword, Highlight, Section]
        end
        if user.video_complaints_permission?
            can [:manage], Relationship, relationship_type: 'Complaint'
        end
        if user.hits_permission?
            can [:manage], Hit
        end
        if user.destroy_articles_permission?
            can [:show, :destroy], Article
        end
        if user.radio_stations_permission?
            can [:manage], [Station, Timetable]
        end
        if user.remote_controls_permission?
            can [:manage], Control
        end
        if User.new
           can :read, :all
        end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
