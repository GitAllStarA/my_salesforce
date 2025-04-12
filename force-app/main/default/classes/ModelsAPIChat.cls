public class ModelsAPIChat {

	@AuraEnabled(cacheable=true)
    public static String createChat(String systemPrompt, String userPrompt) {

        // Create chat generations request
        aiplatform.ModelsAPI.createChatGenerations_Request request = new aiplatform.ModelsAPI.createChatGenerations_Request();

        // Specify model
        request.modelName = 'sfdc_ai__DefaultOpenAIGPT4OmniMini';

        // Create request body
        aiplatform.ModelsAPI_ChatGenerationsRequest body = new aiplatform.ModelsAPI_ChatGenerationsRequest();
        request.body = body;

        // Create a list to hold chat messages
        List<aiplatform.ModelsAPI_ChatMessageRequest> messagesList = new List<aiplatform.ModelsAPI_ChatMessageRequest>();

        // Add system message
        aiplatform.ModelsAPI_ChatMessageRequest systemMessageRequest = new aiplatform.ModelsAPI_ChatMessageRequest();
        systemMessageRequest.content = systemPrompt;
        systemMessageRequest.role = 'system';
        messagesList.add(systemMessageRequest);

        // Add user message
        aiplatform.ModelsAPI_ChatMessageRequest userMessageRequest = new aiplatform.ModelsAPI_ChatMessageRequest();
        userMessageRequest.content = userPrompt;
        userMessageRequest.role = 'user';
        messagesList.add(userMessageRequest);

        // Set the messages in the request body
        body.messages = messagesList;

        // Set the request body and model name
        request.body = body;

        String response = '';

        try {
            // Call the API and get the response
            aiplatform.ModelsAPI modelsAPI = new aiplatform.ModelsAPI();
            aiplatform.ModelsAPI.createChatGenerations_Response apiResponse = modelsAPI.createChatGenerations(
                request
            );

            // Check that we have a non-null response
            if (
                apiResponse?.Code200?.generationDetails?.generations != null &&
                !apiResponse.Code200.generationDetails.generations.isEmpty()
            ) {
                // Set the variable from the response
                response = apiResponse.Code200.generationDetails.generations[0]
                    .content;
            } else {
                // Handle the case where response is null
                response = 'No content generated';
            }

        // Handle error
        } catch(aiplatform.ModelsAPI.createChatGenerations_ResponseException e) {
            System.debug('Response code: ' + e.responseCode);
            System.debug('The following exception occurred: ' + e);

            // Add error to the output
            response = 'Unable to get a valid response. Error code: ' + e.responseCode;
        }

        return response;
    }
}