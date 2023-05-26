class MessagesController < ApplicationController
  def create
    puts params
    message = params[:message]

    # Конфігурація з'єднання з RabbitMQ
    connection = Bunny.new(hostname: 'localhost')
    connection.start
    channel = connection.create_channel
    queue = channel.queue('my_queue')

    # Публікуємо повідомлення в черзі
    queue.publish(message)
    puts 'Message sent to RabbitMQ'
    render json: { success: true, message: 'Message sent to RabbitMQ' }
  end
end