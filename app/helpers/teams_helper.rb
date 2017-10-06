module TeamsHelper
  def numSupportsOnTeam(character, team)
    return team.count { |member| member.partners.include? character }
  end

  def classForSupportState(character, team)
    return "supported-by-#{numSupportsOnTeam(character, team)}"
  end

  def sortByNumSupports(unpicked, team)
    return unpicked.sort { |a, b| numSupportsOnTeam(b, team) <=> numSupportsOnTeam(a, team) }
  end
end
