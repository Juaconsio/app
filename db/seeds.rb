# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'csv'

CSV.read('db/protocols.csv', headers: true).each do |row|
  Protocol.create!(id: row["id"], title: row["title"])
end

Rails.logger.info "Protocols created"


CSV.read('db/register_ins.csv', headers: true).each do |row|
  res = RegisterIn.create!(
    id: row["id"],
    fatigue: row["fatigue"],
    pain: row["pain"],
    general: row["general"],
    created_at: row["created_at"]
  )
  Rails.logger.info res.inspect
end

Rails.logger.info "RegisterIns created"

CSV.read('db/register_outs.csv', headers: true).each do |row|
  res = RegisterOut.create(
    id: row["id"],
    fatigue: row["fatigue"],
    pain: row["pain"],
    general: row["general"],
    created_at: row["created_at"],
    protocol_id: row["protocol_id"]
  )

  Protocol.find(row["protocol_id"]).register_outs << res
end

Rails.logger.info "RegisterOuts created"

CSV.read('db/attentions.csv', headers: true).each do |row|
  Attention.create(
    id: row["id"],
    created_at: row["created_at"],
    register_in_id: row["register_in_id"],
    register_out_id: row["register_out_id"]
  )
  RegisterIn.find_or_create_by!(id: row["register_in_id"]).update!(attention_id: row["id"])
  RegisterOut.find_or_create_by!(id: row["register_out_id"]).update!(attention_id: row["id"])
end
Rails.logger.info "Attentions created"
