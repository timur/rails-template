class EventAggregatorService
  def initialize; end

  def aggregate_events
    # Ahoy::Event
    #   .where(name: 'Ran action')
    #   .where('time > ?', 48.hours.ago)
    #   .where("properties LIKE ?", '%"controller":"dashboard","action":"index"%')
    #   .count

      Ahoy::Event.group("strftime('%Y-%m-%d', time)").count    
  end
end


# Ahoy::Event
# .where(name: 'Ran action')
# .where('time > ?', 48.hours.ago).group_by_hour(:time).count


# Ahoy::Event
# .where_properties(controller: 'examples/upload',
# action: 'glitch').count

# Ahoy::Event.where("properties LIKE ?", '%"controller":"dashboard","action":"index"%')