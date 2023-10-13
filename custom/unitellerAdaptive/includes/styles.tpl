<style>
:root {
--text-color: #2D3A53;
--background-white: {%$secondaryBackgroundColor|default:'#fff'%};
--light-green: {%$mainBackgroundColor|default:'#F0FBF4'%};
--green: #6FC05F;
--white: white;
--gray: #A6AAB1;
--border-color: #D1E6D9;
}



    @media (prefers-reduced-motion: no-preference) {
      :root {
        scroll-behavior: smooth;
      }
    }

    .timer__items {
      display: flex;
      font-size: 30px;
      align-items: center;
      justify-content: center;
    }

    .timer__item {
      position: relative;
      min-width: 40px;
      margin-left: 10px;
      margin-right: 10px;
      padding-bottom: 15px;
      text-align: center;
    }

    .timer__item::before {
      content: attr(data-title);
      display: block;
      position: absolute;
      left: 50%;
      bottom: 0;
      transform: translateX(-50%);
      font-size: 14px;
    }

    .timer__item:not(:last-child)::after {
      content: ':';
      position: absolute;
      right: -15px;
    }

</style>
