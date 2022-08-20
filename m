Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA117EF
	for <damon@lists.linux.dev>; Sat, 20 Aug 2022 02:29:29 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id s4-20020a17090a5d0400b001fabc6bb0baso5675887pji.1
        for <damon@lists.linux.dev>; Fri, 19 Aug 2022 19:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=h/HJ65cb2+nIGwhv5QH5QTgJ4jWxy0giXVXsSHB7yko=;
        b=iuCRhwHvRBHWpZ+AfOlPMiIE4kR6hweHfR1SBEN6YW20gjBM2ixZbR8hui4zb1FfIH
         KONz0WtxxHeYRsbXWN+bjJviEfSFdSqRGJdlYqSqh5cRn/Px1liqn3nUwC/MUpWEDAEN
         WlbKswo9JvZGBBdDfcbkhIz9dANcSE7v1j1JETjYFPobMcWHjdOPimg+iKnFUaGrIEgX
         vtxMk8zhKjKbYER1nFnXhJikpbg6sBLINjhe6EkPkFRBJsyYXLaD+70sjpXYUbpihqFO
         deEFYRZKvN3dcYDAA4FHkW7+m5urs0X7b06MlsxndKKUnI27es9IuyGrEWZ22Fw4uaIR
         6hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=h/HJ65cb2+nIGwhv5QH5QTgJ4jWxy0giXVXsSHB7yko=;
        b=m06SuRt5CJv8VvSRmvy6P/ngJRvr0AdJFJehFbh5RDggbA8CZJ/mxH27Vz+KW8AqOy
         NvFCHV+FvwOE2ZEg4cnft323FFTvQp0XxRl/AQanFHrMy7wD6ODgXvf4/ro91tM3egGg
         cryV+CaFXJt4B6kRw6MoFHhNJPu5suoCEKUdnsnhv3G0wFi3/WLRcjnbUyx/HymkZaQA
         8BcahdIeUSie46GPt7bAhLSSwmSva1MqoNxbHhu92bzJW7qHZxf9ZH+WvLAe2D7lfb1+
         wPZZXM/ooy/4rLyux40sJWijzpLoCykSyG5rTXmzeQO6PpE/DpAno+tPgfQJbw3lEi5r
         ksMg==
X-Gm-Message-State: ACgBeo03+Y82fOX5ksSwPsuvyaE6Z+pxE849AOH3XWaQgNisHKblTLhH
	uyQL2Wl9YJDwNPyf4gMH6vY=
X-Google-Smtp-Source: AA6agR6Zpo21opq2l8HWg7HLYMOJyGVGl/tr0rum0zXAixFaKrG0xIztTBKPV4VCL7tZ2YidfzXR0w==
X-Received: by 2002:a17:902:ef96:b0:172:abb9:657e with SMTP id iz22-20020a170902ef9600b00172abb9657emr10056786plb.48.1660962569323;
        Fri, 19 Aug 2022 19:29:29 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b0016d88dc7745sm3793478plf.259.2022.08.19.19.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 19:29:28 -0700 (PDT)
Message-ID: <69366c8b-9bbb-7d4c-4d0d-4948d04e71bb@gmail.com>
Date: Sat, 20 Aug 2022 09:29:24 +0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] mm/damon/dbgfs: avoid duplicate context directory
 creation
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc: badari.pulavarty@intel.com, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20220819171930.16166-1-sj@kernel.org>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220819171930.16166-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/22 00:19, SeongJae Park wrote:
> From: Badari Pulavarty <badari.pulavarty@intel.com>
> 
> When user tries to create a DAMON context via the DAMON debugfs
> interface with a name of an already existing context, the context
> directory creation silently fails but the context is added in the
> internal data structure.  As a result, memory could leak and DAMON
> cannot be turned on.  An example test case is as below:
> 
>     # cd /sys/kernel/debug/damon/
>     # echo "off" >  monitor_on
>     # echo paddr > target_ids
>     # echo "abc" > mk_context
>     # echo "abc" > mk_context
>     # echo $$ > abc/target_ids
>     # echo "on" > monitor_on  <<< fails
> 
> This commit fixes the issue by checking if the name already exist and
> immediately returning '-EEXIST' in the case.
> 

Meh...

SJ, I have seen most (if not all of) your patches uses descriptive mood
instead of imperative. Better say "Fix the issue by checking ...".

-- 
An old man doll... just what I always wanted! - Clara
