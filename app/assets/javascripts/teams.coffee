# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require jquery
//= require jquery_ujs



addToTeam = (characterName) ->
  ind = gon.unpicked.findIndex( (unpickedChar) -> unpickedChar.name == characterName )
  gon.team.push( gon.unpicked[ind] )
  gon.unpicked.splice( ind, 1 )


removeFromTeam = (characterName) ->
  ind = gon.team.findIndex( (teamMember) -> teamMember.name == characterName )
  gon.unpicked.push( gon.team[ind] )
  gon.team.splice( ind, 1 )


# Argument: Name of unpicked character
numSupportsOnTeam = (characterName) ->
  character = gon.unpicked.find( (unpickedChar) -> unpickedChar.name == characterName )
  numSupports = gon.team.reduce (x,y) ->
    if y.partners.find( (partner) -> partner.name == character.name ) then x + 1 else x
  , 0
  numSupports


sortAndColorUnpickedCharacters = () ->
  unpickedTable = $('.unpicked tbody')
  unpickedRows = unpickedTable.children('tr')

  unpickedRows.detach()

  $(row).attr("class", "") for row in unpickedRows
  $(row).attr("class", "") for row in $('.team tbody tr')

  unpickedRows = unpickedRows.sort (a, b) ->
    return numSupportsOnTeam($(b).find('.unpicked-character').data('charname')) - numSupportsOnTeam($(a).find('.unpicked-character').data('charname'))

  $(row).attr("class", "supported-by-#{numSupportsOnTeam($(row).find('.unpicked-character').data('charname'))}") for row in unpickedRows

  $('.unpicked tbody').append unpickedRows




# On start
$ ->
  $('.unpicked tbody').empty()
  $('.team tbody').empty()
  $('.unpicked tbody').append "<tr><td class='unpicked-character' data-charname='#{character.name}'>#{character.name}</td></tr>" for character in gon.unpicked

  $('.unpicked-character').click () ->
    charname = $(this).data('charname')
    if gon.unpicked.findIndex( (unpickedChar) -> unpickedChar.name == charname ) != -1
      addToTeam(charname)
      $(this).removeClass('unpicked-character')
      $(this).addClass('team-character')
      $('.team tbody').append $(this).parent().detach()
      sortAndColorUnpickedCharacters()
    else
      removeFromTeam(charname)
      $(this).removeClass('team-character')
      $(this).addClass('unpicked-character')
      $('.unpicked tbody').append $(this).parent().detach()
      sortAndColorUnpickedCharacters()


