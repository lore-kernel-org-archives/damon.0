Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177315A2
	for <damon@lists.linux.dev>; Fri, 19 Aug 2022 02:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D861FC433D6;
	Fri, 19 Aug 2022 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660876133;
	bh=hlzfkU+1Cauv3f2NrQO+riFDY79o2Wb/uGUduVuAY/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yjo4zowxmdjgkvQnUobmcF0qq6ZHfoWfro2F+gk0qdsPU2NHlMWoEhEVvcIZTIwI6
	 KbycYs+9f4m0S+0h89mtUtOk3QnELuayoie+6fzss1zM/H8w6yslRJkv7gOw8tCO9B
	 ncBTKScfc5rNG+3F8tyBYN3R1AxvF3pad2xbMh7ry9QDfEm8PIrgf80chxBv4BzFjk
	 73Cc6OIWiwQ1rrou6JCWsKfL7ohkyRWGInSE/VHoCyzgfI4MTBer4YHTE9dJln0fUI
	 +L4MRrWSEtaRI7++wBzA5jQEfJJIJv6wTzJsSspO86LLTl3ojIOR7ou7NaXNyWJM1Z
	 0eh2t5vXOnEdw==
From: SeongJae Park <sj@kernel.org>
To: xhao@linux.alibaba.com
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mm/damon/lru_sort: Move target memory region check to head of func
Date: Fri, 19 Aug 2022 02:28:50 +0000
Message-Id: <20220819022850.52236-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5c1c4b01-5ada-5c25-7181-a6f6c2c1f6ed@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xin,

> 
> 在 2022/8/19 上午1:11, SeongJae Park 写道:
> > Hi Xin,
> >
> >
> > On Thu, 18 Aug 2022 18:57:31 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> In damon_lru_sort_apply_parameters(), if "monitor_region_start"
> >> and "monitor_region_end" is not a valid physical address range,
> >> There no need to run the remainder codes in it.
> > The function, 'damon_lru_sort_apply_parameters()', checks validity of
> > parameters and construct the DAMON context one by one.  For example,
> > 'damon_set_attrs()' returns an error if the parameters are invalid.  So the
> > intended flow is,
> >
> > 1. check DAMON attributes parameters,
> > 2. apply DAMON attributes parameters,
> > 3. check scheme parameters,
> > 4. apply scheme parameters,
> > 5. check target region parameters, and
> > 6. apply target region parameters.
> >
> > Therefore what this patch does is making the target regions validity check to
> > be done earlier than validity checks of other parameters.  There is no special
> > reason to check the region earlier than others.  Also, this change makes the
> > flow of the function a little bit weird in my humble opinion, as the flow will
> > be
> >
> > 1. check target region parameters,
> > 2. check DAMON attributes parameters,
> > 3. apply DAMON attributes parameters,
> > 4. check scheme parameters,
> > 5. apply scheme parameters, and
> > 6. apply target region parameters.
> 
> Ok, understand what you mean,   my fix looks ugly,  buy any apply above 
> are not not necessary if one of them checks failed, why not check all 
> fisrt and then apply them, like this:
> 
> 1. check target region parameters,
> 
> 2. check DAMON attributes parameters,
> 
> 3. check scheme parameters,

The parameter values could be changed by users after the check, so we should
cache those somewhere anyway.  In other words, we cache those in the DAMON
context.  Therefore I think the above works were not totally waste of the time.
Also, because the parameters applying functions like 'damon_set_attrs()' does
the check and applying of the parameters together, I feel like current flow is
natural.

If I'm missing something, please let me know.


Thanks,
SJ

> 
> >
> > So I'd argue this patch seems not really needed, sorry.
> >
> >
> > Thanks,
> > SJ
> >
> > [...]
> 
