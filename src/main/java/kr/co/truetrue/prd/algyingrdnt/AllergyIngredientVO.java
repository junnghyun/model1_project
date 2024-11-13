package kr.co.truetrue.prd.algyingrdnt;

public class AllergyIngredientVO {
	private int ingredientId;
    private String ingredientName;
    
    
	public AllergyIngredientVO() {
	}
	public AllergyIngredientVO(int ingredientId, String ingredientName) {
		this.ingredientId = ingredientId;
		this.ingredientName = ingredientName;
	}
	public int getIngredientId() {
		return ingredientId;
	}
	public void setIngredientId(int ingredientId) {
		this.ingredientId = ingredientId;
	}
	public String getIngredientName() {
		return ingredientName;
	}
	public void setIngredientName(String ingredientName) {
		this.ingredientName = ingredientName;
	}
	@Override
	public String toString() {
		return "AllergyIngredientVO [ingredientId=" + ingredientId + ", ingredientName=" + ingredientName + "]";
	}
    
    
}
