import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class RxUserModel {
  final id = 0.obs;
  final tenantId = '0'.obs;
  final refreshToken = '0'.obs;
  final companyName = 'Godzyken'.obs;
  final status = 'SASU'.obs;
  final activity = 'Concepteur Developpeur App Flutter'.obs;
  final specialisation = 'digitalisation des entreprises'.obs;
  final length = 1.obs;
  final matriculation = '35356464RC'.obs;
  final email = 'isgodzy@gmail.com'.obs;
  final emailVerified = false.obs;
  final phoneNumber = 'phoneNumber'.obs;
  final location = 'Lyon'.obs;
  final assurance = 'MAAF'.obs;
  final hireable = 'hireable'.obs;
  final bio = 'bio'.obs;
  final twitterUsername = 'twitterUsername'.obs;
  final facebookUsername = 'facebookUsername'.obs;
  final publicRepos = 0.obs;
  final publicGists = 0.obs;
  final followers = 0.obs;
  final following = 0.obs;
  final createdAt = 'createAt'.obs;
  final updatedAt = 'updateAt'.obs;
  final avatarUrl =
      'https://cdn.pixabay.com/photo/2021/09/25/19/06/witch-6655604_1280.png'
          .obs;
  final gravatarId = 'gravatarId'.obs;
  final url = 'url'.obs;
  final htmlUrl = 'htmlUrl'.obs;
  final followersUrl = 'followersUrl'.obs;
  final followingUrl = 'followingUrl'.obs;
  final gistsUrl = 'gistsUrl'.obs;
  final starredUrl = 'starredUrl'.obs;
  final subscriptionsUrl = 'subscriptionsUrl'.obs;
  final organizationsUrl = 'organizationsUrl'.obs;
  final reposUrl = 'reposUrl'.obs;
  final eventsUrl = 'eventsUrl'.obs;
  final receivedEventsUrl = 'receivedEventsUrl'.obs;
  final type = 'type'.obs;
  final providerData = [].obs;
  final siteAdmin = false.obs;
}

class UserModel {
  UserModel({
    id,
    tenantId,
    refreshToken,
    companyName,
    status,
    activity,
    specialisation,
    length,
    matriculation,
    email,
    emailVerified,
    phoneNumber,
    location,
    assurance,
    hireable,
    bio,
    twitterUsername,
    facebookUsername,
    publicRepos,
    followers,
    following,
    createAt,
    updateAt,
    avatarUrl,
    gravatarId,
    url,
    htmlUrl,
    followersUrl,
    followingUrl,
    gistsUrl,
    starredUrl,
    subscriptionsUrl,
    organizationUrl,
    reposUrl,
    receivedEventsUrl,
    type,
    providerData,
    siteAdmin,
  });

  final rx = RxUserModel();

  get siteAdmin => rx.siteAdmin.value;

  set siteAdmin(value) => rx.siteAdmin.value = value;

  get providerData => rx.providerData.value;

  set providerData(value) => rx.providerData.value = value;

  get type => rx.type.value;

  set type(value) => rx.type.value = value;

  get receivedEventsUrl => rx.receivedEventsUrl.value;

  set receivedEventsUrl(value) => rx.receivedEventsUrl.value = value;

  get eventsUrl => rx.eventsUrl.value;

  set eventsUrl(value) => rx.eventsUrl.value = value;

  get reposUrl => rx.reposUrl.value;

  set reposUrl(value) => rx.reposUrl.value = value;

  get organizationsUrl => rx.organizationsUrl.value;

  set organizationsUrl(value) => rx.organizationsUrl.value = value;

  get subscriptionsUrl => rx.subscriptionsUrl.value;

  set subscriptionsUrl(value) => rx.subscriptionsUrl.value = value;

  get starredUrl => rx.starredUrl.value;

  set starredUrl(value) => rx.starredUrl.value = value;

  get gistsUrl => rx.gistsUrl.value;

  set gistsUrl(value) => rx.gistsUrl.value = value;

  get followingUrl => rx.followingUrl.value;

  set followingUrl(value) => rx.followingUrl.value = value;

  get followersUrl => rx.followersUrl.value;

  set followersUrl(value) => rx.followersUrl.value = value;

  get htmlUrl => rx.htmlUrl.value;

  set htmlUrl(value) => rx.htmlUrl.value = value;

  get url => rx.url.value;

  set url(value) => rx.url.value = value;

  get gravatarId => rx.gravatarId.value;

  set gravatarId(value) => rx.gravatarId.value = value;

  get avatarUrl => rx.avatarUrl.value;

  set avatarUrl(value) => rx.avatarUrl.value = value;

  get updatedAt => rx.updatedAt.value;

  set updatedAt(value) => rx.updatedAt.value = value;

  get createdAt => rx.createdAt.value;

  set createdAt(value) => rx.createdAt.value = value;

  get following => rx.following.value;

  set following(value) => rx.following.value = value;

  get followers => rx.followers.value;

  set followers(value) => rx.followers.value = value;

  get publicGists => rx.publicGists.value;

  set publicGists(value) => rx.publicGists.value = value;

  get publicRepos => rx.publicRepos.value;

  set publicRepos(value) => rx.publicRepos.value = value;

  get facebookUsername => rx.facebookUsername.value;

  set facebookUsername(value) => rx.facebookUsername.value = value;

  get twitterUsername => rx.twitterUsername.value;

  set twitterUsername(value) => rx.twitterUsername.value = value;

  get bio => rx.bio.value;

  set bio(value) => rx.bio.value = value;

  get hireable => rx.hireable.value;

  set hireable(value) => rx.hireable.value = value;

  get assurance => rx.assurance.value;

  set assurance(value) => rx.assurance.value = value;

  get location => rx.location.value;

  set location(value) => rx.location.value = value;

  get phoneNumber => rx.phoneNumber.value;

  set phoneNumber(value) => rx.phoneNumber.value = value;

  get emailVerified => rx.emailVerified.value;

  set emailVerified(value) => rx.emailVerified.value = value;

  get email => rx.email.value;

  set email(value) => rx.email.value = value;

  get matriculation => rx.matriculation.value;

  set matriculation(value) => rx.matriculation.value = value;

  get length => rx.length.value;

  set length(value) => rx.length.value = value;

  get specialisation => rx.specialisation.value;

  set specialisation(value) => rx.specialisation.value = value;

  get activity => rx.activity.value;

  set activity(value) => rx.activity.value = value;

  get status => rx.status.value;

  set status(value) => rx.status.value = value;

  get companyName => rx.companyName.value;

  set companyName(value) => rx.companyName.value = value;

  get refreshToken => rx.refreshToken.value;

  set refreshToken(value) => rx.refreshToken.value = value;

  get tenantId => rx.tenantId.value;

  set tenantId(value) => rx.tenantId.value = value;

  get id => rx.id.value;

  set id(value) => rx.id.value = value;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenantId'];
    refreshToken = json['refreshToken'];
    companyName = json['companyName'];
    status = json['status'];
    activity = json['activity'];
    specialisation = json['specialisation'];
    length = json['length'];
    matriculation = json['matriculation'];
    phoneNumber = json['phoneNumber'];
    emailVerified = json['emailVerified'];
    email = json['email'];
    location = json['location'];
    hireable = json['hireable'];
    bio = json['bio'];
    twitterUsername = json['twitterUsername'];
    facebookUsername = json['facebookUsername'];
    publicRepos = json['publicRepos'];
    publicGists = json['publicGists'];
    followers = json['followers'];
    following = json['following'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    avatarUrl = json['avatarUrl'];
    gravatarId = json['gravatarId'];
    url = json['url'];
    htmlUrl = json['htmlUrl'];
    followersUrl = json['followersUrl'];
    followingUrl = json['followingUrl'];
    gistsUrl = json['gistsUrl'];
    starredUrl = json['starredUrl'];
    subscriptionsUrl = json['subscriptionsUrl'];
    type = json['type'];
    siteAdmin = json['siteAdmin'];
    providerData = json['providerData'];
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot? documentSnapshot) {
    id = documentSnapshot!.id;
    tenantId = documentSnapshot["tenantId"];
    refreshToken = documentSnapshot["refreshToken"];
    companyName = documentSnapshot["companyName"];
    status = documentSnapshot["status"];
    activity = documentSnapshot["activity"];
    specialisation = documentSnapshot["specialisation"];
    length = documentSnapshot["length"];
    matriculation = documentSnapshot["matriculation"];
    email = documentSnapshot["email"];
    emailVerified = documentSnapshot["emailVerified"];
    phoneNumber = documentSnapshot["phoneNumber"];
    location = documentSnapshot["location"];
    hireable = documentSnapshot["hireable"];
    bio = documentSnapshot["bio"];
    twitterUsername = documentSnapshot["twitterUsername"];
    facebookUsername = documentSnapshot["facebookUsername"];
    publicRepos = documentSnapshot["publicRepos"];
    publicGists = documentSnapshot["publicGists"];
    followers = documentSnapshot["followers"];
    following = documentSnapshot["following"];
    createdAt = documentSnapshot["createdAt"];
    updatedAt = documentSnapshot["updatedAt"];
    avatarUrl = documentSnapshot["avatarUrl"];
    gravatarId = documentSnapshot["gravatarId"];
    url = documentSnapshot["url"];
    htmlUrl = documentSnapshot["htmlUrl"];
    followersUrl = documentSnapshot["followersUrl"];
    followingUrl = documentSnapshot["followingUrl"];
    gistsUrl = documentSnapshot["gistsUrl"];
    starredUrl = documentSnapshot["starredUrl"];
    subscriptionsUrl = documentSnapshot["subscriptionsUrl"];
    type = documentSnapshot["type"];
    siteAdmin = documentSnapshot["siteAdmin"];
    providerData = documentSnapshot["providerData"];
  }

  Map<String, dynamic> toJson() => {
        'hireable': hireable,
        'bio': bio,
        'twitterUsername': twitterUsername,
        'facebookUsername': facebookUsername,
        'publicRepos': publicRepos,
        'publicGists': publicGists,
        'followers': followers,
        'following': following,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'avatarUrl': avatarUrl,
        'gravatarId': gravatarId,
        'url': url,
        'htmlUrl': htmlUrl,
        'followersUrl': followersUrl,
        'followingUrl': followingUrl,
        'gistsUrl': gistsUrl,
        'starredUrl': starredUrl,
        'subscriptionsUrl': subscriptionsUrl,
        'type': type,
        'providerData': providerData,
        'siteAdmin': siteAdmin,
        'assurance': assurance,
        'location': location,
        'phoneNumber': phoneNumber,
        'emailVerified': emailVerified,
        'email': email,
        'matriculation': matriculation,
        'length': length,
        'specialisation': specialisation,
        'activity': activity,
        'status': status,
        'companyName': companyName,
        'refreshToken': refreshToken,
        'tenantId': tenantId,
        'id': id,
      };

  static List<UserModel> listFromJson(list) =>
      List<UserModel>.from(list.map((x) => UserModel.fromJson(x)));
}
