require 'wuparty'
ACCOUNT = 'devbootcamp'
API_KEY = 'X1HQ-ZU20-12O7-0SD9'
FORM = "dev-bootcamp-mentor-application"
@wufoo = WuParty.new(ACCOUNT, API_KEY)
@form = @wufoo.form(FORM)
