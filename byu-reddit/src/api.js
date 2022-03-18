import axios from "axios";
import { authHeader, getJwtToken, getUserIdFromToken } from "./auth";

const API_URL = "http://50.112.37.217:8000";

class Api {
  getFeed(id) {
    return axios.get(API_URL + `/feed?userid=eq.${id}`);
  }
  getExplore() {
    return axios.get(API_URL + `/explore`);
  }

  getUser(email) {
    return axios.get(API_URL + `/USER?email=eq.${email}`);
  }

  getPost(id) {
    return axios.get(API_URL + `/post?postid=eq.${id}`);
  }

  getProfile(username) {
    return axios.get(API_URL + `/USER?username=eq.${username}`);
  }

  getCommunity(name) {
    return axios.get(API_URL + `/community?communityname=eq.${name}`);
  }

  votePost(id, vote_score) {
    return axios.patch(API_URL + `/POST?postid=eq.${id}`, 
    {
      "votescore": vote_score
    },
    {
      headers: authHeader()
    })

  }
  changeBio(userid, newBio) {
    return axios.patch(API_URL + `/USER?userid=eq.${userid}`, 
    {
      "bio": newBio
    },
    {
      headers: authHeader()
    })

  }

  createPost(title, picture, communityid, userid) {
    return axios.post(API_URL + `/POST`, 
    {
      "title": title,
      "communityid": communityid,
      "content": picture,
      "userid": userid,
      "votescore": 0
    },
    {
      headers: authHeader()
    })

  }

  addComment(comment, postid, userid) {
    return axios.post(API_URL + `/COMMENT`, 
    {
      "commenttext": comment,
      "postid": postid,
      "userid": userid,
      "votescore": 0,
      "parent_commentid": null
    },
    {
      headers: authHeader()
    })

  }

  deleteUser(userid) {
    return axios.delete(API_URL + `/USER`, 
    {
      "userid": userid,
    },
    {
      headers: authHeader()
    })

  }
  deleteComment(commentid) {
    return axios.delete(API_URL + `/COMMENT?commentid=eq.${commentid}`, 
    {
      "commentid": commentid,
    },
    {
      headers: authHeader()
    })

  }

  createCommunity(communityname, description, communitypicture) {
    return axios.post(API_URL + `/COMMUNITY`, 
    {
      "communityname": communityname,
      "description": description,
      "communitypicture": communitypicture
    },
    {
      headers: authHeader()
    })

  }
  voteComment(commentid, comment_votescore) {
    return axios.patch(API_URL + `/COMMENT?commentid=eq.${commentid}`, 
    {
        "votescore": comment_votescore
    },
    {
      headers: authHeader()
    })

  }

  addPost(post) {
    return axios.post(
      API_URL + "/POST",
      {
        ...post,
        // add user id from JWT token
        userid: getUserIdFromToken(getJwtToken()),
      },
      {
        headers: authHeader(),
      }
    );
  }

  login(email, password) {
    return axios.post(API_URL + "/rpc/login", { email, password });
  }

  signup(email, password, username) {
    return axios.post(API_URL + "/rpc/signup", { email, password, username, "role": "user" });
  }
}

export default new Api();
