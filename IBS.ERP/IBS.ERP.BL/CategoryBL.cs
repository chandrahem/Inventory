using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IBS.ERP.DataAccess;
using IBS.ERP.Models;
namespace IBS.ERP.BL
{
    public class CategoryBL
    {
        public List<Category> GetCategoriesList()
        {
            CategoriesDAL categoriesDAL = new CategoriesDAL();
           return categoriesDAL.GetCategories();

        }

        public ReturnResult SaveCategory(Category category)
        {
            CategoriesDAL categoriesDAL = new CategoriesDAL();
            return categoriesDAL.SaveCategory(category);

        }

        public ReturnResult DeleteCategory(int categoryid)
        {
            CategoriesDAL categoriesDAL = new CategoriesDAL();
            return categoriesDAL.DeleteCategory(categoryid);

        }
        public Category GetCategoryById(int id)
        {
            CategoriesDAL categoriesDAL = new CategoriesDAL();
            return categoriesDAL.GetCategoryById(id);

        }
        
    }
}
