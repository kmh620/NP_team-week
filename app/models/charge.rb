class Charge < ActiveRecord::Base
  belongs_to :user, optional: true

  def receipt
    Receipts::Receipt.new(
     id: id,
     subheading: "RECEIPT FOR CHARGE #%{id}",
     product: "GoRails",
     company: {
       name: "One Month, Inc.",
       address: "37 Great Jones\nFloor 2\nNew York City, NY 10012",
       email: "teachers@onemonth.com",
       logo: Rails.root.join("app/assets/images/one-month-dark.png")
     },
     line_items: [
       ["Date",           created_at.to_s],
       ["Account Billed", "#{user.name} (#{user.email})"],
       ["Product",        "GoRails"],
       ["Amount",         "$#{amount / 100}.00"],
       ["Charged to",     "#{card_type} (**** **** **** #{card_last4})"],
     ],
     font: {

     }
   )
  end
end
