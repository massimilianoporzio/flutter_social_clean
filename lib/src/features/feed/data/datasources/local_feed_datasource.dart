import 'package:hive/hive.dart';

import '../../../../shared/data/models/post_model.dart';
import '../../../../shared/domain/entities/post.dart';

abstract class LocalFeedDatasource {
  //fetch Posts from local
  Future<List<Post>> getPosts();
  //add post to the local storage
  Future<void> addPost(Post post);
  //delete all posts from local storage
  Future<void> deleteAllPosts();
  //get only the posts of current logged in user
  Future<List<Post>> getPostsByUser(String userId);
  //delete POst by Id
  Future<void> deletePostById(String postId);
}

class LocalFeedDatasourceImpl implements LocalFeedDatasource {
  String boxName = 'posts'; //salvo i post nella scatola chiamata 'posts'
  Type boxType = PostModel; //tipo di dato che salvo
  @override
  Future<void> addPost(Post post) async {
    Box box = await _openBox();
    await box.put(post.id, PostModel.fromEntity(post));
  }

  @override
  Future<void> deleteAllPosts() async {
    Box box = await _openBox();
    await box.clear();
  }

  @override
  Future<void> deletePostById(String postId) async {
    Box<PostModel> box = await _openBox();
    return box.delete(
        postId); //Hive registra chiave valore e ho usato post.id quando l'ho messo in cache
  }

  @override
  Future<List<Post>> getPosts() async {
    Box<PostModel> box = await _openBox();
    //lista di postModel poi mappo ogni postModel in un post entity e ottengo
    //iterable che trasformo in lista che è quello che mi aspetto
    return box.values.toList().map((post) => post.toEntity()).toList();
  }

  Future<Box<PostModel>> _openBox() async {
    return Hive.openBox(boxName);
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    Box<PostModel> box = await _openBox();
    return box.values
        .where((element) => element.userModel.id == userId)
        .toList()
        .map((post) => post.toEntity())
        .toList();
  }
}
