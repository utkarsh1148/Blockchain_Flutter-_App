import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:web3dart/web3dart.dart';
import 'global.dart' as glo;
import 'whats/models/chat_model.dart' as whats;
import 'package:http/http.dart';
import 'global.dart' as glo;

const String rpcUrl =
    '';

final EthereumAddress contractAddr =
    EthereumAddress.fromHex('');
final EthereumAddress receiver =
    EthereumAddress.fromHex('');

main() async {

  createContext();
  final client = Web3Client(rpcUrl, Client());

  String privateKey = glo.key;
  final credentials = await client.credentialsFromPrivateKey(privateKey);

  final ownAddress = await credentials.extractAddress();
  // read the contract abi and tell web3dart where it's deployed (contractAddr)
  final abiCode =
      '[{"constant":false,"inputs":[],"name":"addNewGroup","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"participant","type":"address"},{"name":"groupID","type":"uint256"}],"name":"addNewParticipant","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"b","type":"bytes1"}],"name":"char","outputs":[{"name":"c","type":"bytes1"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"groupID","type":"uint256"},{"name":"ipfsHash","type":"string"}],"name":"setIPFS","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"detail","type":"string"}],"name":"setMyWhisperDetails","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"x","type":"address"}],"name":"toString","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"creator","type":"address"},{"indexed":false,"name":"groupID","type":"uint256"}],"name":"newGroupEvent","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"participant","type":"address"},{"indexed":false,"name":"groupID","type":"uint256"}],"name":"newParticipantEvent","type":"event"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"AllGroupParticicpants","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"groupID","type":"uint256"}],"name":"getIPFS","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getLength","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"x","type":"address"}],"name":"getLinkedGroupsto","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"groupID","type":"uint256"}],"name":"getParticipantsFromGroupID","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"ipfsOfGroupID","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"linkedGroupsIndexis","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"showAllGroupParticicpants","outputs":[{"name":"","type":"string[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"addrs","type":"address"}],"name":"showMyWhisperDetails","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"whisperDetails","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}]';
  final contract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'WhisperChat'), contractAddr);

  final getParticipantsFromGroupID =
      contract.function('getParticipantsFromGroupID');
  final getLinkedGroupsto = contract.function('getLinkedGroupsto');

  final s = await client.call(
      contract: contract, function: getLinkedGroupsto, params: [receiver]);
  print(s);
  glo.data = s;
  List data = glo.data;
  int num = data.length;
  List ndata = data[0].split(",");
  List ldata = [];
  for (int i = 0; i < ndata.length; i++) {
    ldata.add(int.parse(ndata[i]));
  }
  glo.participants = ldata;
  for (int j = 0; j < ldata.length; j++) {
    final a = await client.call(
        contract: contract,
        function: getParticipantsFromGroupID,
        params: [BigInt.from(ldata[j])]);
    print(a);
    List strdata = a[0].split(" ");
//  print(strdata);
    var x = new glo.info(gid: ldata[j], members: strdata);

    glo.information.add(x);
    print(glo.information[j].members.length);
  }

  glo.groupnumbers = ldata.length;



  whats.main();


  // send all our MetaCoins to the other address by calling the sendCoin
//   await client.sendTransaction(
//    credentials,
//    Transaction.callContract(
//      contract: contract,
//      function: setString,
//      parameters: ['hello'],
//    ),
//  );

  await client.dispose();
}
