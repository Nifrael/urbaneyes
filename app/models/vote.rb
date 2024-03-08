class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :user_id, uniqueness: { scope: :ticket_id, message: "Vous ne pouvez voter qu'une seule fois par ticket." }

  def self.vote_by_user(ticket_id, user_id, up_vote)
    vote = find_by(ticket_id: ticket_id, user_id: user_id)
    if vote
      vote.update(up_vote: up_vote)
    else
      create(ticket_id: ticket_id, user_id: user_id, up_vote: up_vote)
    end
  end
end
