now = Time.now.to_date
old = now - 2.months
future = now + 1.month
Cohort.create(name: "current", start_date: now, end_date: now + 9.weeks )
Cohort.create(name: "completed", start_date: old, end_date: old + 9.weeks )
Cohort.create(name: "future", start_date: future, end_date: future + 9.weeks )

3.times do |n|
  User.create(first_name: "first_name#{n}",
              last_name: "last_name#{n}",
              email: "mentee#{n}@test.com",
              cohort_id: Cohort.find_by_name("current").id,
              interests: "hang out and do #{n}")
end

User.create(first_name: "John", last_name: "Davison", email: "johncdavison@gmail.com", admin: true)

3.times do |n|
  user = User.create(first_name: "mentor#{n}",
                     last_name: "last_name#{n}",
                     email: "mentor#{n}@mentor.com",
                     employment_agreement: true,
                     interests: "hang out and do #{n}")
  user.commit_to_mentor!(Cohort.find_by_name("current"))
end
