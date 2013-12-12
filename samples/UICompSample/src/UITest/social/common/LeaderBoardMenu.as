package UITest.social.common
{
    import com.mobage.air.ErrorCode;
    import com.mobage.air.social.PagingOption;
    import com.mobage.air.social.common.Leaderboard;
    import com.mobage.air.social.common.LeaderboardData;
    import com.mobage.air.social.common.LeaderboardTopScore;
    import com.mobage.air.util.AlertDialog;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    
    import util.ButtonList;
    import util.LabelList;
    import util.define;
    import com.mobage.air.social.PagingResult;
    
    public class LeaderBoardMenu extends Sprite {	
        private var userID :String = null;
        private var leaderFields :Array = new Array (
            LeaderboardData.USER_ID,
            LeaderboardData.VALUE,
            LeaderboardData.ALLOW_LOWER_SCORE, 
            LeaderboardData.APP_ID,
            LeaderboardData.ARCHIVED,
            LeaderboardData.DEFAULT_SCORE,
            LeaderboardData.FORMAT,
            LeaderboardData.ICON_URL,
            LeaderboardData.ID,
            LeaderboardData.PRECISION,
            LeaderboardData.PUBLISHED,
            LeaderboardData.RANK,
            LeaderboardData.REVERSE,
            LeaderboardData.TITLE,
            LeaderboardData.UPDATED
        );
        private var options: PagingOption = new PagingOption({count:10, start:1});
        
        public function LeaderBoardMenu(_userID :String) {
            userID = _userID;
        }
        
        public function createLeaderBoardMenu() :void {
            var lbButtons :ButtonList = new ButtonList(0);
            addChild(lbButtons);
            
            var labels :LabelList = new LabelList();
            addChild(labels);
            
            var text_scoreValue:TextField = labels.add(define.LEADERBOARD_SCORE, true);
            labels.add("Score Value", false);
            var text_leaderboardId:TextField = labels.add(define.LEADERBOARD_ID, true);
            labels.add("leaderboard Id", false);
            
            lbButtons.add("Get Current User Score", function() :void {
                Leaderboard.getScore(text_leaderboardId.text, userID, leaderFields, 
                    function(topScore :LeaderboardTopScore) :void {
                        trace("getScore() Succeeded")
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "Rank: "+ topScore.rank +"\n Score: "+ topScore.value
                        });
                    }, function(error :ErrorCode) :void {
                        trace("getScore() failed: " + error);
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            lbButtons.add("Update User Score", function() :void {
                Leaderboard.updateCurrentUserScore(text_leaderboardId.text, parseInt(text_scoreValue.text),
                    function(topScore :LeaderboardTopScore) :void {
                        trace("updateCurrentUserScore() Succeeded")
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "Rank: "+ topScore.rank +"\n Score: "+ topScore.value
                        });
                        
                    }, function(error :ErrorCode) :void {
                        trace("updateCurrentUserScore() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            lbButtons.add("Delete User Score", function() :void {
                Leaderboard.deleteCurrentUserScore(text_leaderboardId.text, 
                    function() :void {
                        trace("deleteCurrentUserScore() Succeeded")
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "User score deleted"
                        });
                    }, function(error :ErrorCode) :void {
                        trace("deleteCurrentUserScore() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            lbButtons.add("Get Friends Score List ", function() :void {
                Leaderboard.getFriendsScoresList(text_leaderboardId.text, leaderFields, options,
                    function(topScores :Array, result :PagingResult) :void {
                        trace("getFriendsScoresList() succeeded: " + JSON.stringify(topScores));
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "Friends Score: "+ JSON.stringify(topScores) 
                        });
                    }, function(error :ErrorCode) :void {
                        trace("getFriendsScoresList() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            lbButtons.add("Get All Leaderboards ", function() :void {
                Leaderboard.getAllLeaderboards(leaderFields, 
                    function(leaderboards :Array, result :PagingResult) :void {
                        trace("getAllLeaderboards() succeeded: " + JSON.stringify(leaderboards));
                        AlertDialog.show({
                            title: "Succeeded",
                            message: "All Leaderboards: "+ JSON.stringify(leaderboards) 
                        });
                    }, function(error :ErrorCode) :void {
                        trace("getAllLeaderboards() failed: " + error);
                        
                        AlertDialog.show({
                            title: "Failed",
                            message: error.toString()
                        });
                    });
            });
            
            lbButtons.add("Go Back To Common Menu",function() :void {
                var common:CommonMenu = new CommonMenu(userID);
                addChild(common);
                common.createCommonMenu();
                removeChild(lbButtons);
                removeChild(labels);
            });
        }
    }
}