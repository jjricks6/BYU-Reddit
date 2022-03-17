<!-- eslint-disable -->

<template>
  <v-card elevation="0" min-width="300">
    <v-container>
        <div>
            <!--
            <v-card-title @click="goToUser(user)">{{ Comment[1].commenter }}</v-card-title>
                       -->

                    <v-card-text @click="goToUser(commenter)">{{ commenter }}</v-card-text>
                    <v-card-text >{{ commenttext }}</v-card-text>


        <v-col cols='2' v-if="isLoggedIn">
          <v-btn icon @click="downvote(commentid, comment_votescore)">
          <v-icon>mdi-thumb-down-outline</v-icon>
         </v-btn>
          <v-card-text >{{ comment_votescore }}</v-card-text>
          <v-btn icon @click="upvote(commentid, comment_votescore)">
          <v-icon>mdi-thumb-up-outline</v-icon>
          </v-btn>  
        </v-col>
        <v-col cols='2' v-else>
          
          <v-icon>mdi-thumb-down-outline</v-icon>
          <v-card-text >{{ comment_votescore }}</v-card-text>
          
          <v-icon>mdi-thumb-up-outline</v-icon>            
        </v-col>
          </div>    
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
    goToUser(commenter) {
      this.$router.push(`/u/${commenter}`);
    },
    upvote(commentid, comment_votescore) {
      comment_votescore = comment_votescore + 1
      Api.voteComment(commentid, comment_votescore)
    },
    downvote(commentid, comment_votescore) {
      comment_votescore = comment_votescore - 1
      Api.voteComment(commentid, comment_votescore)
    }
  },
  props: {
    commenttext: String,
    commenter: String,
    parent_commentid: Number,
    comment_votescore: Number,
    commentid: Number

  },

  data() {
    return {
      
    }
  },
  /*
  created: function () {
    console.log(this.commenttext);
  }
*/
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

