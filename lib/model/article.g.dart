// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return new Article(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      contentHTML: json['contentHTML'] as String,
      image: new ImageDTO.fromJson(json['image'] as Map<String, dynamic>),
      author: new Author.fromJson(json['author'] as Map<String, dynamic>),
      tags: (json['tags'] as List).map((e) => e as String).toList(),
      blogId: json['blogId'] as String,
      blogTitle: json['blogTitle'] as String,
      publishedAt: json['publishedAt'] as String,
      url: json['url'] as String,
      paginationValue: json['paginationValue'] as String)
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$ArticleSerializerMixin {
  String get crudOperation;
  String get id;
  String get title;
  String get content;
  String get contentHTML;
  ImageDTO get image;
  Author get author;
  List<String> get tags;
  String get blogId;
  String get blogTitle;
  String get publishedAt;
  String get url;
  String get paginationValue;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'title': title,
        'content': content,
        'contentHTML': contentHTML,
        'image': image,
        'author': author,
        'tags': tags,
        'blogId': blogId,
        'blogTitle': blogTitle,
        'publishedAt': publishedAt,
        'url': url,
        'paginationValue': paginationValue
      };
}
