class RoomsController < ApplicationController

  def index
    @user = User.find_by(id: current_user.id)
    @currentEntries = current_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?',@user.id)
  end

end