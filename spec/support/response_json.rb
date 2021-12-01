module ResponseJSON
    def response_json
        JSON.parse(response.content)
    end
end