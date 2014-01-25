namespace :generator do
  task :questions_and_answers => :environment do
    question_count = ENV['question_count'] ? ENV['question_count'].to_i : 100
    answer_count   = ENV['answer_count']   ? ENV['answer_count'].to_i   : 10
    question_count.times do
      question = Question.create(title: Faker::Lorem.sentence(10), body: Faker::Lorem.sentence(30))
      answer_count.times do
        question.answers.create(body: Faker::Lorem.sentence(10))
      end
    end
    puts "Generated #{question_count} questions with #{answer_count} answers each"
  end
end