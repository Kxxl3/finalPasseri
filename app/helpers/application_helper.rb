module ApplicationHelper
    def flash_class(level)
        case level.to_sym
        when :notice then "notification is-info"
        when :success then "notification is-success"
        when :error then "notification is-danger"
        when :alert then "notification is-warning"
        end
      end

      def print_username(user)
        return "@#{user.email.sub(/@.*/, '')}" if user.username == "nill"
        "@#{user.name}"
      end

      def voted_up_on?(user)
        votes.exists?(votable_id: id, votable_type: self.class.name, voter_id: user.id, voter_type: user.class.name, vote_flag: true)
      end
      
end
