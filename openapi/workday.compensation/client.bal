// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# This is a generated connector for [WorkDay Compensation REST API v1](https://community.workday.com/sites/default/files/file-hosting/restapi/index.html) OpenAPI specification.
# The Workday compensation service enables applications to extend Workday's HCM compensation features.
@display {label: "Workday Compensation", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials. 
    # Follow [this guide] https://credentials.workday.com/docs/authentication/ and obtain tokens.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl) returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Provides the ability to set up and retrieve Scores on Scorecard Results.
    #
    # + 'limit - The maximum number of objects in a single response. The default is 20. The maximum is 100. 
    # + offset - The zero-based index of the first object in a response collection. The default is 0. Use offset with the limit parameter to control paging of a response collection. Example: If limit is 5 and offset is 9, the response returns a collection of 5 objects starting with the 10th object. 
    # + return - Successful response. A successful response can return no matched data. 
    remote isolated function getScorecardResults(int? 'limit = (), int? offset = ()) returns InlineResponse200|error {
        string resourcePath = string `/scorecardResults`;
        map<anydata> queryParam = {"limit": 'limit, "offset": offset};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        InlineResponse200 response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Creates a new Scorecard Result.
    #
    # + return - Resource created. 
    remote isolated function createsNewScorecardResults(CreateScorecardResults payload) returns CreateScorecardResults|error {
        string resourcePath = string `/scorecardResults`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        CreateScorecardResults response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Retrieves Compensation Scorecard information.
    #
    # + effectiveDate - Effective date the scorecard task takes effect. 
    # + 'limit - The maximum number of objects in a single response. The default is 20. The maximum is 100. 
    # + offset - The zero-based index of the first object in a response collection. The default is 0. Use offset with the limit parameter to control paging of a response collection. Example: If limit is 5 and offset is 9, the response returns a collection of 5 objects starting with the 10th object. 
    # + return - Successful response. A successful response can return no matched data. 
    remote isolated function getCompensationScorecards(string? effectiveDate = (), int? 'limit = (), int? offset = ()) returns InlineResponse2001|error {
        string resourcePath = string `/scorecards`;
        map<anydata> queryParam = {"effectiveDate": effectiveDate, "limit": 'limit, "offset": offset};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        InlineResponse2001 response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Creates a Compensation Scorecard
    #
    # + effectiveDate - Effective date the scorecard task takes effect. 
    # + return - Resource created. 
    remote isolated function createsCompensationScorecards(CreateScoreCard payload, string? effectiveDate = ()) returns CreateScoreCard|error {
        string resourcePath = string `/scorecards`;
        map<anydata> queryParam = {"effectiveDate": effectiveDate};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        CreateScoreCard response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Retrieves a worker instance.
    #
    # + id - The Workday ID of the resource. 
    # + return - Successful response. A successful response can return no matched data. 
    remote isolated function getWorkerInstance(string id) returns WorkerProfile|error {
        string resourcePath = string `/workers/${getEncodedUri(id)}`;
        WorkerProfile response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Provides the ability to set up and retrieve Scores on Scorecard Results.
    #
    # + id - The Workday ID of the resource. 
    # + return - Successful response. A successful response can return no matched data. 
    remote isolated function getAndSetUpScoresOnScorecardResults(string id) returns ScoresetContainer|error {
        string resourcePath = string `/scorecardResults/${getEncodedUri(id)}`;
        ScoresetContainer response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Deletes the Scorecard Results with the specified ID.
    #
    # + id - The Workday ID of the resource. 
    # + return - Successful response. A successful response can return no matched data. Deleting resource. 
    remote isolated function deleteScorecardResultsByID(string id) returns http:Response|error {
        string resourcePath = string `/scorecardResults/${getEncodedUri(id)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Retrieves a collection of workers.
    #
    # + 'limit - The maximum number of objects in a single response. The default is 20. The maximum is 100. 
    # + offset - The zero-based index of the first object in a response collection. The default is 0. Use offset with the limit parameter to control paging of a response collection. Example: If limit is 5 and offset is 9, the response returns a collection of 5 objects starting with the 10th object. 
    # + search - Searches ~workers~ by name. The search is case-insensitive. You can include space-delimited search strings for an OR search. 
    # + return - Successful response. A successful response can return no matched data. 
    remote isolated function getWorkerCollection(int? 'limit = (), int? offset = (), string? search = ()) returns InlineResponse2002|error {
        string resourcePath = string `/workers`;
        map<anydata> queryParam = {"limit": 'limit, "offset": offset, "search": search};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        InlineResponse2002 response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Request a one-time payment for a worker with the specified ID.
    #
    # + id - The Workday ID of the resource. 
    # + return - Resource created. 
    remote isolated function requestOneTimePayment(string id, OneTimePaymentPlanEventInput payload) returns OneTimePaymentPlanEventInput|error {
        string resourcePath = string `/workers/${getEncodedUri(id)}/requestOneTimePayment`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        OneTimePaymentPlanEventInput response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Updates the Score for the specified Scorecard Result.
    #
    # + id - The Workday ID of the resource. 
    # + subresourceID - The Workday ID of the subresource. 
    # + return - Successful response. A successful response can return no matched data. Updating resource. 
    remote isolated function updateScore(string id, string subresourceID, ScoreInput payload) returns ScoreInput|error {
        string resourcePath = string `/scorecardResults/${getEncodedUri(id)}/scores/${getEncodedUri(subresourceID)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ScoreInput response = check self.clientEp->patch(resourcePath, request);
        return response;
    }
    # Retrieves Compensation Scorecard information.
    #
    # + id - The Workday ID of the resource. 
    # + return - Successful response. A successful response can return no matched data. 
    remote isolated function getCompensationScoreCardInfo(string id) returns ScoreCard|error {
        string resourcePath = string `/scorecards/${getEncodedUri(id)}`;
        ScoreCard response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Updates a Compensation Scorecard
    #
    # + id - The Workday ID of the resource. 
    # + return - Successful response. A successful response can return no matched data. Updating resource. 
    remote isolated function updateCompensationScorecard(string id, EditScoreCards payload) returns EditScoreCards|error {
        string resourcePath = string `/scorecards/${getEncodedUri(id)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        EditScoreCards response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Deletes a Compensation Scorecard with the specified ID.
    #
    # + id - The Workday ID of the resource. 
    # + return - Successful response. A successful response can return no matched data. Deleting resource. 
    remote isolated function deleteCompensationScorecardByID(string id) returns http:Response|error {
        string resourcePath = string `/scorecards/${getEncodedUri(id)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
}
