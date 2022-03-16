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
