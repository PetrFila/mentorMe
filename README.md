# README

This is a two-sided market place like app providing a platform for people looking for a mentor
or simply somebody to talk their coding related problems.

* The problem
There are many free resources related to programming however people are still facing many problems and/or confusions of the concepts. The online resources are sometimes not good enough and there is nobody around to explain the issues.

* The solution
This platform is trying to combine the power of the internet and the need to talk to a real person about a specific problems.
The idea is to have a community of people helping each other by using this app to talk by using implemented live chat.

* How it work - business case
Anyone can create a profile and assign skills to it so the other users know which person to contact. Each mentor also writes some brief information about himself or herself and assigns a price to charge per specific time period. The minimum time limit is 15 minutes with no price limit.
Users can message each other to schedule an appointment and assign it to in-build calendar system where both the parties can see the availability options.


# System details

* Ruby version
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin17]

* Rails version
Rails 5.1.4

* Gem files used
gem 'devise'
gem 'shrine', '~> 2.8'
gem "aws-sdk-s3", "~> 1.2"
gem 'dotenv-rails', groups: [:development, :test]
gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'jquery-rails'
gem "rails-erd"


# Configuration

* Installing devise
(https://github.com/plataformatec/devise)

* Creating profile table
- rails g scaffold Profile first_name:string last_name:string about:text user_id:reference

* Installing Shrine
- adding a new column to the existing database:
- rails g migration add_avatar_to_profile image_data:text
- create a new file called shrine.rb in config/initializers and paste there following code in the exact same form:

```
require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :rack_file # for non-Rails apps
```

- create a new folder inside `app` called `uploaders`
- create a new file inside `uploaders` called `image_uploader.rb`
- paste following code to the `image_uploader.rb`
`class ImageUploader < Shrine

end`


- add validation requirement to your model/profile.rb
`include ImageUploader[:image]
validates :first_name, presence: true
validates :last_name, presence: true
validates :about, presence: true`

- create a new form field in the partial `_form.html.erb`
`<% if profile.image.present?%>
  <%= image_tag profile.image_url%>
<% end %>
<%= form.label :avatar %>
<%= form.hidden_field :image, value: @photo.cached_image_data %>
<%= form.file_field :image, class: "form-control", placeholder: "Upload your image" %>
</div>`

- add `:image` to the private method inside of the `profiles_controllers` so it looks like this:
`private
  #### Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  #### Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:image, :first_name, :last_name, :title, :about)
  end`

- to display images on the `index.html.erb` and `show.html.erb` page paste there following syntax:
`  <% if profile.image.present?%>
    <%= image_tag profile.image_url%>
  <% end %>`
- to include AWS option follow the instructions on the official GitHub Shrine profile
(https://github.com/janko-m/shrine)


* Live chat implementation
(https://medium.com/@adnama.lin/live-messaging-with-rails-5-action-cable-7f009e0c1d8b)

* Database schema
<img src="https://au08rq.dm2302.livefilestore.com/y4mv865hsDRAIIlB23t95obPto0Wltm_2D751inE4hh60zlQPbuQtZOr4IPTowiGlnkBirEb_RTUWBkCo0nKoBZW29v2xX982lwU3Zk4L8uxLrPvux4HdcNShhr7woW1fGeRrvqQoiJP8gQxWcrMTsi_tFPyFeL7vrRPMkNyCYgskEY7Tsw3PZepzqy9oZ_nIdMQe09zsWjiKfqkJjtebXjQA?width=660&height=574&cropmode=none" width="660" height="574" />

* Wire frame
<img src="https://weoksa.dm2302.livefilestore.com/y4mMTEXazYSN8XBzZfGzs1FMebDroYs42igiu7vBqLclHCa6ZqQObTCNvhpPVOSz3JXdCVr9z3E_l4pEYib3-Os7YQA_d5MPrNOF-AVyukqY36nFTXEv5E1NsDlf2T0iOVvL_HWpjpNdipS4TYPhOJtUsHcSK1xOJ141Eoxr6Z-uJf24SF0bhw5JcAGPcIma6aIxLngH4S7PtJqYVhqU_lFuw?width=660&height=527&cropmode=none" width="660" height="527" />






# create the Chat migration before the Message migration since it's dependent
rails generate model Chat identifier:string
# references Profile, not User
rails generate model Message content:string profile:references chat:references
bin/rails db:environment:set RAILS_ENV=development
rails db:drop db:create db:migrate
# references Profile, not User
rails generate model Subscription chat:references profile:references
# edit all files replacing User with Profile according to this guide - https://medium.com/@adnama.lin/live-messaging-with-rails-5-action-cable-7f009e0c1d8b
