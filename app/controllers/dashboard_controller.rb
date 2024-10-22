class DashboardController < ApplicationController
  def index
    @attentions = Attention.all
    @register_ins = RegisterIn.all
    @register_outs = RegisterOut.all
    @protocols = Protocol.all

    @register_ins_status_average = {
      Fatiga:  @register_ins.average(:fatigue),
      Dolor:     @register_ins.average(:pain),
      General:  @register_ins.average(:general)
    }

    @register_outs_status_average = {
      Fatiga:  @register_outs.average(:fatigue),
      Dolor:     @register_outs.average(:pain),
      General:  @register_outs.average(:general)
    }

    all_protocol_frequency = @protocols.map do |protocol|
      [
         protocol.title,
         @register_outs.where(protocol_id: protocol.id).count
      ]
    end
    @protocol_frequency = all_protocol_frequency.sort_by { |protocol| protocol[1] }.reverse.first(5)

    @attentions_frequency = @attentions.group_by_day_of_week(:created_at).count

    @attentions_frequency = [
      [ "Sábado", @attentions_frequency[6] ],
      [ "Domingo", @attentions_frequency[0] ],
      [ "Lunes", @attentions_frequency[1] ],
      [ "Martes", @attentions_frequency[2] ],
      [ "Miércoles", @attentions_frequency[3] ],
      [ "Jueves", @attentions_frequency[4] ]
    ]

    first_five_frecuency_protocol_titles = @protocol_frequency.map { |protocol| protocol[0] }

    first_five_frecuency_protocol = Protocol.where(title: first_five_frecuency_protocol_titles)

    first_five_frecuency_protocol_group_by_day = first_five_frecuency_protocol.map do |protocol|
      {
        title: protocol.title,
        days: RegisterOut.where(protocol_id: protocol.id).group_by_day_of_week(:created_at).count
      }
    end

    @chart_data = first_five_frecuency_protocol_group_by_day.map do |protocol|
      {
        name: protocol[:title],
        data: protocol[:days].map { |day, count| [ day, count ] }.to_h
      }
    end
  end
end
