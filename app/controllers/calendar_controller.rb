class CalendarController < ApplicationController

  def index
    id = params[:id] ? params[:id] : "calendar"
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    events = []
    events << OpenStruct.new(title: "Der Name meines Events", date: Date.today + 3.days, color: "bg-green-500/70", url: dashboard_path)
    events << OpenStruct.new(title: "Noch ein tolles Event", date: Date.today + 10.days, color: "bg-blue-500", url: dashboard_path)

    @code = 
    <<-CODE
<%= compact_month_calendar %>
<%# index.erb %>
    <h1>Listing Books</h1>
    <table>
      <tr>
        <th>Title</th>
        <th>Summary</th>
        <th></th>
        <th></th>
        <th></th>
      </tr>
    
      <% @books.each do |book| %>
        <tr>
          <td><%= book.title %></td>
          <td><%= book.content %></td>
          <td><%= link_to "Show", book %></td>
          <td><%= link_to "Edit", edit_book_path(book) %></td>
          <td><%= link_to "Remove", book, method: :delete, data: { confirm: "Are you sure?" } %></td>
        </tr>
      <% end %>
    </table>
    CODE

    respond_to do |format|
      format.html {
        render locals: { date:, id:, events: }
      } 
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/month_calendar", locals: { date:, id:, events: }) }
    end
  end

  def datepicker_paginate
    id = params[:id] ? params[:id] : "calendar"
    date = params[:date] ? Date.parse(params[:date]) : Date.today

    respond_to do |format|
      format.html
      format.turbo_stream { 
        render turbo_stream: 
          turbo_stream.update(id, partial: "shared/datepicker_month", locals: { date: date, id: id}) }
    end
  end

  def year
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events = []
    @events << OpenStruct.new(title: "Der Name meines Events", date: Date.today + 3.days, color: "bg-green-500")
    @events << OpenStruct.new(title: "Noch ein tolles Event", date: Date.today + 10.days, color: "bg-blue-500")
  end

  def datepicker
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @form = DatepickerForm.new
  end

end
