user = User.create!(email: 'test@abc.com', password: 'abc123')
Project.create!(title: 'Cleanup the Streets!', location: 'Shaw', user: user)