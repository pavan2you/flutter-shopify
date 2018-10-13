import 'dart:convert';

import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/image.dart';
import 'package:shopify/model/author.dart';

import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable(nullable: false)
class Article extends DataObject with _$ArticleSerializerMixin {

  String id;
  String title;
  String content;
  String contentHTML;
  ImageDTO image;
  Author author;
  List<String> tags;
  String blogId;
  String blogTitle;
  String publishedAt;
  String url;
  String paginationValue;

  Article({this.id, this.title, this.content,
    this.contentHTML, this.image, this.author,
    this.tags, this.blogId, this.blogTitle, this.publishedAt,
    this.url, this.paginationValue});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["content"] = content;
    map["contentHTML"] = contentHTML;
    map["image"] = image;
    map["author"] = author;
    map["tags"] = tags;
    map["blogId"] = blogId;
    map["blogTitle"] = blogTitle;
    map["publishedAt"] = publishedAt;
    map["url"] = url;
    map["paginationValue"] = paginationValue;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + title.hashCode;
    result = 31 * result + content.hashCode;
    result = 31 * result + contentHTML.hashCode;
    result = 31 * result + (image != null ? image.hashCode : 0);
    result = 31 * result + author.hashCode;
    result = 31 * result + tags.hashCode;
    result = 31 * result + blogId.hashCode;
    result = 31 * result + blogTitle.hashCode;
    result = 31 * result + publishedAt.hashCode;
    result = 31 * result + url.hashCode;
    result = 31 * result + (paginationValue != null ? paginationValue.hashCode : 0);
    return result;
  }

  @override
  bool operator ==(object) {

    if (this == object) {
      return true;
    }
    if (object == null || toString() != object.toString()) {
      return false;
    }

    Article article = object;

    if (id != article.id) return false;
    if (title != article.title) return false;
    if (content != article.content)
      return false;
    if (contentHTML != article.contentHTML) return false;
    if (image != article?.image) return false;
    if (author != article.author) return false;
    if (tags != article.tags) return false;
    if (blogId != article.blogId) return false;
    if (blogTitle != article.blogTitle) return false;
    if (publishedAt != article.publishedAt) return false;
    if (url != article.url) return false;
    if (paginationValue != article?.paginationValue) return false;

    return true;
  }

  String toString() {
    return "Article{" +
        " id ='" + id + '\'' +
        ", title ='" + title + '\'' +
        ", content ='" + content + '\'' +
        ", contentHTML ='" + contentHTML + '\'' +
        ", blogId ='" + blogId + '\'' +
        ", blogTitle ='" + blogTitle + '\'' +
        ", url ='" + url + '\'' +
        ", paginationValue ='" + paginationValue + '\'' +
        '}';
  }
}