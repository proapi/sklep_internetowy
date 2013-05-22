#encoding: utf-8

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def yield_or(name, content = nil, &block)
    if content_for?(name)
      content_for(name)
    else
      block_given? ? capture(&block) : content
    end
  end

  def render_flash(flash)
    unless flash[:alert].blank?
      raw "<br/><div class=\"flashalert\">#{flash[:alert]}</div><br/><div class=\"flashSeparator\"><div class=\"flashSeparatorPattern\" style=\"margin: 0;\"></div></div>"
    end
    unless flash[:notice].blank?
      raw "<br/><div class=\"flashnotice\">#{flash[:notice]}</div><br/><div class=\"flashSeparator\"><div class=\"flashSeparatorPattern\" style=\"margin: 0;\"></div></div>"
    end
  end

  def options_for_pack_machines(postcode, id)
    nearest = PackMachine.nearest(postcode)
    if nearest.empty?
      options_from_collection_for_select(PackMachine.all, :id, :to_s, id).insert(0, options_for_select(["Wszystkie paczkomaty:"]))
    else
      options_from_collection_for_select(PackMachine.where('id not in (?)', nearest.collect { |n| n.id }), :id, :to_s, id).insert(0, options_for_select(["", "Wszystkie paczkomaty:"])).insert(0, options_from_collection_for_select(nearest, :id, :to_s, id)).insert(0, options_for_select(["Najbliższe paczkomaty:"]))
    end
  end
end