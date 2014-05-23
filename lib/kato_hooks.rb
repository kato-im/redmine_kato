# encoding: utf-8

require 'kato'

class NotificationHook < Redmine::Hook::Listener

  def controller_issues_new_after_save(context={ })
    project = context[:project]
    return true if !kato_configured?(project)

    issue = context[:issue]
    user = issue.author
    assigned = issue.assigned_to_id.blank? ? "anyone yet" : "#{issue.assigned_to.name}"
    project = issue.project
    tracker = issue.tracker.name.downcase
    message = "#{user.name} created issue ##{issue.id} (#{tracker}) [#{issue.subject}](#{Setting[:protocol]}://#{Setting.host_name}/issues/#{issue.id}) at [#{project.name}](#{Setting[:protocol]}://#{Setting.host_name}/projects/#{project.name}).\n\nAssigned to: #{assigned}"
    send_message(kato_url(project), message)
  end

  def controller_issues_edit_after_save(context = { })
    issue = context[:issue]
    project = issue.project
    return true if !kato_configured?(project)

    params = context[:params]
    journal = context[:journal]
    notes = journal.notes
    tracker = issue.tracker.name.downcase
    message = "#{journal.user} edited issue ##{issue.id} (#{tracker}) [#{issue.subject}](#{Setting[:protocol]}://#{Setting.host_name}/issues/#{issue.id}) at [#{project.name}](#{Setting[:protocol]}://#{Setting.host_name}/projects/#{project.name})\n\n#{truncate_words(notes)}"
    send_message(kato_url(project), message)
  end

  def controller_wiki_edit_after_save(context = {})
    page = context[:page]
    project = page.wiki.project
    return true if !kato_configured?(project)

    wiki = page.pretty_title
    author = User.current.name
    url = "#{Setting[:protocol]}://#{Setting[:host_name]}/projects/#{page.wiki.project.identifier}/wiki/#{page.title}"
    message = "#{author} edited [#{project.name}](#{Setting[:protocol]}://#{Setting.host_name}/projects/#{project.name}) wiki page [#{wiki}](#{url})"
    send_message(kato_url(project), message)
  end

  def kato_url(project)
    return project.kato_url if !project.kato_url.empty?
    return Setting.plugin_redmine_kato[:kato_url]
  end

  def kato_configured?(project)
    if !project.kato_url.empty?
      return true
    elsif Setting.plugin_redmine_kato[:kato_url] &&
          Setting.plugin_redmine_kato[:projects] &&
          Setting.plugin_redmine_kato[:projects].include?(project.id.to_s)
      return true
    else
      Rails.logger.info "Not sending Kato message - missing config"
    end
    false
  end

  def send_message(kato_url, message)
    begin
      room = Kato::Room.new("", {:full_url => kato_url})
      room.post("Redmine", message, {:renderer => "markdown"})
    rescue => e
      Rails.logger.error "Error when trying to send message to kato: #{e.message}"
    end
  end

  def truncate_words(text, length = 20, end_string = '…')
    return if text == nil
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
end
