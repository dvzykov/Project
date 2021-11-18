using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using Story.Models;
namespace Story.Models
{
    public class Bike
    {
        //Id велосипеда
        public virtual int BikeID { set; get; }
        //Картинка велосипеда
        public virtual string Img { set; get; }
        // Название производителя
        //public ICollection<Maker> Makers { set; get; }
        [DisplayName("Марка")]
        public virtual string Maker { set; get; }
        //// Тип велосипеда
        [DisplayName("Тип")]
        public virtual string BikeType { set; get; }
        //public ICollection<BikeT> BikeTs { set; get; }
        //public Bike()
        //{
        //    Makers = new List<Maker>();
        //    BikeTs = new List<BikeT>();
        //}
        // вес велосипеда
        [DisplayName("Вес")]
        public virtual string Weight { set; get; }
        //Колеса велосипеда
        [DisplayName("Диаметр колес")]
        public virtual string Wheel { set; get; }
        //Рама 
        [DisplayName("Рама")]
        public virtual string Frame { set; get; }
        //Кол-во
        [DisplayName("Кол-во")]
        public virtual int Number { set; get; }
        //цена
        [DisplayName("Цена")]
        public virtual string Price { set; get; }
        //комментарии
        [DisplayName("Особенности")]
        public virtual string Comment { set; get; }

      
        
    }
}