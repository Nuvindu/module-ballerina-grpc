import ballerina/protobuf;

const string MESSAGE2_DESC = "0A0E6D657373616765322E70726F746F12097061636B6167696E671A2362616C6C6572696E612F70726F746F6275662F64657363726970746F722E70726F746F22350A0B5265714D6573736167653212100A03726571180120012805520372657112140A0576616C7565180220012809520576616C756522350A0B5265734D6573736167653212100A03726571180120012805520372657112140A0576616C7565180220012809520576616C75654216E24713677270635F74657374732E6D65737361676532620670726F746F33";

@protobuf:Descriptor {value: MESSAGE2_DESC}
public type ResMessage2 record {|
    int req = 0;
    string value = "";
|};

@protobuf:Descriptor {value: MESSAGE2_DESC}
public type ReqMessage2 record {|
    int req = 0;
    string value = "";
|};

