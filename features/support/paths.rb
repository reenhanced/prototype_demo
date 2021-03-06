require 'cucumber/rails'
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the user dashboard page/
      '/dashboard'

    when /the sign in page/
      '/login'

    when /the search (screen|family cards page)/ then new_search_path

    when /the new family card page/ then new_family_card_path

    when /the family card's page/
      @family_card ||= FamliyCard.last
      raise "No @family_card exists, please reference features/step_definitions/family_card_steps.rb" unless @family_card
      "/family_cards/#{@family_card.id}"

    when /the family card's audit page/
      @family_card ||= FamliyCard.last
      raise "No @family_card exists, please reference features/step_definitions/family_card_steps.rb" unless @family_card
      "/family_cards/#{@family_card.id}/audits"

    when /another user's family card page/
      raise "No @user exists, please reference features/step_definitions/family_card_steps.rb" unless @user
      @family_card = FamilyCard.where("user_id != #{@user.id}").first
      raise "Couldn't find a family card belonging to another user..." unless @family_card
      "/family_cards/#{@family_card.id}"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
