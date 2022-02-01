import ballerina/grpc;
import ballerina/protobuf.types.empty;

public isolated client class StoreClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR_DUPLICATE_OUTPUT_TYPE, getDescriptorMapDuplicateOutputType());
    }

    isolated remote function storeAlbum(Album|ContextAlbum req) returns Album|grpc:Error {
        map<string|string[]> headers = {};
        Album message;
        if req is ContextAlbum {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Store/storeAlbum", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Album>result;
    }

    isolated remote function storeAlbumContext(Album|ContextAlbum req) returns ContextAlbum|grpc:Error {
        map<string|string[]> headers = {};
        Album message;
        if req is ContextAlbum {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Store/storeAlbum", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Album>result, headers: respHeaders};
    }

    isolated remote function getAlbums() returns stream<Album, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("Store/getAlbums", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        AlbumStream outputStream = new AlbumStream(result);
        return new stream<Album, grpc:Error?>(outputStream);
    }

    isolated remote function getAlbumsContext() returns ContextAlbumStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("Store/getAlbums", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        AlbumStream outputStream = new AlbumStream(result);
        return {content: new stream<Album, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class AlbumStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Album value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Album value;|} nextRecord = {value: <Album>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class StoreAlbumCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAlbum(Album response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAlbum(ContextAlbum response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextAlbumStream record {|
    stream<Album, error?> content;
    map<string|string[]> headers;
|};

public type ContextAlbum record {|
    Album content;
    map<string|string[]> headers;
|};

public type Album record {|
    string id = "";
    string title = "";
    string artist = "";
    float price = 0.0;
|};

const string ROOT_DESCRIPTOR_DUPLICATE_OUTPUT_TYPE = "0A1B6475706C69636174655F6F75747075745F747970652E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F225B0A05416C62756D120E0A0269641801200128095202696412140A057469746C6518022001280952057469746C6512160A06617274697374180320012809520661727469737412140A0570726963651804200128025205707269636532540A0553746F7265122D0A09676574416C62756D7312162E676F6F676C652E70726F746F6275662E456D7074791A062E416C62756D3001121C0A0A73746F7265416C62756D12062E416C62756D1A062E416C62756D620670726F746F33";

public isolated function getDescriptorMapDuplicateOutputType() returns map<string> {
    return {"duplicate_output_type.proto": "0A1B6475706C69636174655F6F75747075745F747970652E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F225B0A05416C62756D120E0A0269641801200128095202696412140A057469746C6518022001280952057469746C6512160A06617274697374180320012809520661727469737412140A0570726963651804200128025205707269636532540A0553746F7265122D0A09676574416C62756D7312162E676F6F676C652E70726F746F6275662E456D7074791A062E416C62756D3001121C0A0A73746F7265416C62756D12062E416C62756D1A062E416C62756D620670726F746F33", "google/protobuf/empty.proto": "0A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F120F676F6F676C652E70726F746F62756622070A05456D70747942540A13636F6D2E676F6F676C652E70726F746F627566420A456D70747950726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"};
}

