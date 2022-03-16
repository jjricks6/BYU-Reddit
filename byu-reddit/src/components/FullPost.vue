<!-- eslint-disable -->

<template>
  <v-card elevation="0" min-width="300">
    <v-container>
    <v-row>
      <v-col center-allign justify cols='1'>
        <v-avatar size='60'>
          <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/'+ community_picture"/>
        </v-avatar>
      </v-col>
      <v-col cols=10>
        <v-row dense>
          <v-col>
            <v-card-title @click="goToPost(community, id)">{{ title }}</v-card-title>
            <v-card-subtitle @click="goToUser(community)">{{ community }} </v-card-subtitle>
          </v-col>
        </v-row>
      </v-col>
      <v-col cols='1'>
        <div class='time'> <h6> {{ time_posted }} </h6> </div>
      </v-col>
    </v-row>
    <v-row>
      <v-img
        :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/'+ content" />
    </v-row>
    <v-row>
      <v-col cols='2' v-if="isLoggedIn">
        <v-btn icon @click="downvote(id, vote_score)">
          <v-icon>mdi-thumb-down-outline</v-icon>
        </v-btn>
        {{ vote_score }}
        <v-btn icon @click="upvote(id, vote_score)">
          <v-icon>mdi-thumb-up-outline</v-icon>
        </v-btn>
      </v-col>
      <v-col cols='2' v-else>
        <v-icon>mdi-thumb-down-outline</v-icon>
        {{ vote_score }}
        <v-icon>mdi-thumb-up-outline</v-icon>
      </v-col>
      <v-col>
        {{ num_comments }}
        <v-btn icon @click="goToPost(community, id)">
          <v-icon>mdi-comment-text-outline</v-icon>
        </v-btn>
      </v-col>
    </v-row>
    </v-container>
  </v-card>
</template>

<script>
import Api from "../api";
export default {
  computed: {
    isLoggedIn : function(){
      return this.$store.state.user.username != undefined }
  },
  methods:{
    goToPost(id) {
      this.$router.push(`/c/community/${id}`);
    },
    goToUser(user) {
      this.$router.push(`/u/${user}`);
    },
    upvote(id, vote_score) {
      vote_score = vote_score + 1
      Api.votePost(id, vote_score)
    },
    downvote(id, vote_score) {
      vote_score = vote_score - 1
      Api.votePost(id, vote_score)
    }
  },
  props: {
    id: Number,
    title: String,
    content: String,
    community: String,
    community_picture: String,
    time_posted: String,
    vote_score: Number,
    num_comments: Number
  },

  data() {
    return {
      
    }
  }
}
</script>

<style>
.buttons {
  justify-content: flex-end;
}

.title {
  justify-content: flex-start;
}

.missing-data {
  font-weight: lighter;
  font-size: 24px;
  color: #CCCCCC;
}

.time {
  color: #a0a0a0
}

@media only screen and (max-width: 600px) {
  .buttons {
    justify-content: center;
  }
  .title {
    justify-content: center;
    text-align: center;
  }

}
</style>

