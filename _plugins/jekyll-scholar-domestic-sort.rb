module Jekyll
  class Scholar
    module Utilities
      unless method_defined?(:resolve_sort_value_without_domestic_last)
        alias_method :resolve_sort_value_without_domestic_last, :resolve_sort_value
      end

      unless method_defined?(:sort_without_domestic_last)
        alias_method :sort_without_domestic_last, :sort
      end

      def resolve_sort_value(entry, key)
        if key.to_s == "domestic_last"
          additional_info = entry[:additional_info].to_s.downcase
          domestic_last = additional_info.include?("domestic") ? "1" : "0"
          return BibTeX::Value.new(domestic_last)
        end

        resolve_sort_value_without_domestic_last(entry, key)
      end

      def sort(unsorted)
        return unsorted if skip_sort?

        unsorted
          .each_with_index
          .sort do |(e1, i1), (e2, i2)|
            sort_keys
              .map
              .with_index do |key, idx|
                v1 = resolve_sort_value(e1, key)
                v2 = resolve_sort_value(e2, key)

                if (sort_order[idx] || sort_order.last) =~ /^(desc|reverse)/i
                  v2 <=> v1
                else
                  v1 <=> v2
                end
              end
              .find { |comparison| comparison != 0 } || (i1 <=> i2)
          end
          .map(&:first)
      end
    end
  end
end
