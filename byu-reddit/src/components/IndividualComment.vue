<!-- eslint-disable -->

<template>
  <v-card elevation="0" min-width="300">
    <v-container >
      <div>
        

        <v-card-text @click="goToUser(commenter)">{{ commenter }}</v-card-text>
        {{ commenttext }}
        <br><br>
        <v-row>

              <v-col cols="2" v-if="isLoggedIn">
                  <v-btn icon @click="downvote(commentid, comment_votescore)">
                    <v-icon small>mdi-thumb-down-outline</v-icon>
                  </v-btn>
                  {{ comment_votescore }}
                  <v-btn icon @click="upvote(commentid, comment_votescore)">
                    <v-icon small>mdi-thumb-up-outline</v-icon>
                  </v-btn>
                </v-col>
                <v-col cols="2" v-else>
                  <v-icon small>mdi-thumb-down-outline</v-icon>
                  {{ comment_votescore }}

                  <v-icon small>mdi-thumb-up-outline</v-icon>  
                </v-col>

                <v-col cols="10" v-if="isAdmin">
                  <v-btn icon @click="deleteComment(commentid)">
                    <v-icon >mdi-trash-can</v-icon>
                  </v-btn>
                </v-col>
        </v-row>
      </div>
    </v-container>
  </v-card>
</template>

<script>
import Api from "../api";
export default {
  computed: {
    isLoggedIn: function () {
      return this.$store.state.user.username != undefined;
    },
    /*isParentComment: function () {
      return this.$store.state.comment.parent_commentid != null;
    },*/
    isAdmin : function(){
      return this.$store.state.user.role == "admin" 
    }
  },
  methods: {
    goToUser(commenter) {
      this.$router.push(`/u/${commenter}`);
    },
    upvote(commentid, comment_votescore) {
      comment_votescore = comment_votescore + 1;
      Api.voteComment(commentid, comment_votescore);
    },
    downvote(commentid, comment_votescore) {
      comment_votescore = comment_votescore - 1;
      Api.voteComment(commentid, comment_votescore);
    },
    deleteComment(commentid) {
      Api.deleteComment(commentid)
    }
  },
  props: {
    commenttext: String,
    commenter: String,
    parent_commentid: Number,
    comment_votescore: Number,
    commentid: Number,
  },

  data() {
    return {};
  },
  /*
  created: function () {
    console.log(this.commenttext);
  }
*/
};
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
  color: #cccccc;
}

.time {
  color: #a0a0a0;
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

