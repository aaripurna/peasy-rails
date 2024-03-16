module Eliquid
  class Assigns
    INTERNAL_ATTRIBUTES = %i[@_routes @_config @lookup_context @view_renderer @current_template @_controller @_request
                             @_default_form_builder @view_flow @output_buffer @virtual_path @_assigns @rendered_format
                             @marked_for_same_origin_verification]
    def initialize(template)
      @template = template
    end

    def context
      @context ||= begin
        (@template.instance_variables - INTERNAL_ATTRIBUTES).inject({}) do |sum, current|
          key = current.to_s.sub("@", "")
          sum[key] = @template.instance_eval("#{current}")

          sum
        end
      end
    end

    def merge_assigns(locals)
      context.merge(locals.with_indifferent_access)
             .merge({'params' => @template.params.dup.permit!.to_h.with_indifferent_access})
    end
  end
end