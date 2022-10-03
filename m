Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A28F4D
	for <damon@lists.linux.dev>; Mon,  3 Oct 2022 06:18:15 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id r185so140797pgr.12
        for <damon@lists.linux.dev>; Sun, 02 Oct 2022 23:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RvW7NqWWcmsZSOmiqcmfGnzINMQt2bw0vz9RsBO9kPs=;
        b=HXb3QAu2zKmNgf7gcgI3SCkJyErQhqouY5lkfPhocgQOtCQKCNyq57wJ9ncZNM7I/e
         rEuT3hCHAvdQm+WtfinCBuu3TVo7pvSc0YzaimSu9awPZFi/Ru/VHe2ImbfEfO3AePGV
         DwNeCQU+5ys1FtQludDCUj1R7axXNS8PJQXh5YpKrTuAaImyZoeWZr5gbxqGE4rViZTK
         WpbZP3lbDJYhihKcEA3rM8WLrhHZhJwEwuQ32FnTrkn1dyC6BGUF0En9Bs3T8ZbCyFvw
         +gf+gfrYNi1Mi2mCbqDIfBWzqywXnunO7Z5xcGRXr30PQqU4unEIetPwdIRfxKIYeZWt
         HCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RvW7NqWWcmsZSOmiqcmfGnzINMQt2bw0vz9RsBO9kPs=;
        b=aVmveto7uau0bCOwj4G8wGShObDRUCJ46rZFtiYHBr2sbeS4b8n07DgmljocL2r7hO
         xxC4k65YygNJ769VTbrgc2KnOjs9WWqZSZLx2q/x4bbUxoCt4n+ImByj/LNvqHosYG/6
         DvdeTTiK7wnPv7FvH434YB5Je29ZH7rVa52Z7NXk8mSXGn9RzF5PhWaqxOPIKoCw+h6N
         iaVHJXTlTC8lDl3PxQvg/usRd1kU61JZ4GKSD4IMm9QkPXZQrM4BiyVn/iN5CK0B88qE
         7PR1+Ez8w3JMW+o6KkgVWnQ+weoOUG1QKWuyafb1bStc8tbCvN9yWulz+nZW/qhaHt7G
         yLQQ==
X-Gm-Message-State: ACrzQf2iG4DhjSQtzAPnO9vT2WvugYWzxAzD51w0kc8PHmqXpEE/hXrz
	yppVLCNbQ2UNrOLt7WVh1Ac=
X-Google-Smtp-Source: AMsMyM7+2PlYiGHAqlP0quWhZ+Moh87Ezx8cHWOsO4fWe2zjII533A6lbECVW6gCU/qHSwma7mjJ2Q==
X-Received: by 2002:a05:6a00:180a:b0:540:a7f6:4393 with SMTP id y10-20020a056a00180a00b00540a7f64393mr21440326pfa.65.1664777894701;
        Sun, 02 Oct 2022 23:18:14 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b005615beef41fsm1768695pfr.187.2022.10.02.23.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 23:18:13 -0700 (PDT)
Date: Mon, 3 Oct 2022 15:18:09 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: initialize damon_target->list in
 damon_new_target()
Message-ID: <Yzp+oTYs4s7stUIC@hyeyoo>
References: <20221002193130.8227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002193130.8227-1-sj@kernel.org>

On Sun, Oct 02, 2022 at 07:31:30PM +0000, SeongJae Park wrote:
> 'struct damon_target' creation function, 'damon_new_target()' is not
> initializing its '->list' field, unlike other DAMON structs creator
> functions such as 'damon_new_region()'.  Normal users of
> 'damon_new_target()' initializes the field by adding the target to DAMON
> context's targets list, but some code could access the uninitialized
> field.
> 
> This commit avoids the case by initializing the field in
> 'damon_new_target()'.
> 
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Fixes: f23b8eee1871 ("mm/damon/core: implement region-based sampling")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> 
>  mm/damon/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 1d952fa7ba3e..1e6691771a95 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -345,6 +345,7 @@ struct damon_target *damon_new_target(void)
>  	t->pid = NULL;
>  	t->nr_regions = 0;
>  	INIT_LIST_HEAD(&t->regions_list);
> +	INIT_LIST_HEAD(&t->list);
>  
>  	return t;
>  }

I tried again with it and this fixes the bug I reported.
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thank you for such a quick fix!

> -- 
> 2.25.1
> 

-- 
Thanks,
Hyeonggon
