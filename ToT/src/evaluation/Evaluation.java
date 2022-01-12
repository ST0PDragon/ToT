package evaluation;

public class Evaluation {
	
	int evaluationID;
	String userID;
	String restaurantName;
	String refereeName;
	int ateYear;
	String ateMonth;
	String foodMenu;
	String comment;
	String content;
	String totalScore;
	String tasteScore;
	String vibeScore;
	String serviceScore;
	int likeCount;
	
	public Evaluation() {
		
	}
	
	public Evaluation(int evaluationID, String userID, String restaurantName, String refereeName, int ateYear,
			String ateMonth, String foodMenu, String comment, String content,
			String totalScore, String tasteScore, String vibeScore, String serviceScore, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.restaurantName = restaurantName;
		this.refereeName = refereeName;
		this.ateYear = ateYear;
		this.ateMonth = ateMonth;
		this.foodMenu = foodMenu;
		this.comment = comment;
		this.content = content;
		this.totalScore = totalScore;
		this.tasteScore = tasteScore;
		this.vibeScore = vibeScore;
		this.serviceScore = serviceScore;
		this.likeCount = likeCount;
	}

	public int getEvaluationID() {
		return evaluationID;
	}

	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}

	public String getRefereeName() {
		return refereeName;
	}

	public void setRefereeName(String refereeName) {
		this.refereeName = refereeName;
	}

	public int getAteYear() {
		return ateYear;
	}

	public void setAteYear(int ateYear) {
		this.ateYear = ateYear;
	}

	public String getAteMonth() {
		return ateMonth;
	}

	public void setAteMonth(String ateMonth) {
		this.ateMonth = ateMonth;
	}

	public String getFoodMenu() {
		return foodMenu;
	}

	public void setFoodMenu(String foodMenu) {
		this.foodMenu = foodMenu;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}

	public String getTasteScore() {
		return tasteScore;
	}

	public void setTasteScore(String tasteScore) {
		this.tasteScore = tasteScore;
	}

	public String getVibeScore() {
		return vibeScore;
	}

	public void setVibeScore(String vibeScore) {
		this.vibeScore = vibeScore;
	}

	public String getServiceScore() {
		return serviceScore;
	}

	public void setServiceScore(String serviceScore) {
		this.serviceScore = serviceScore;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
	
	
	
}