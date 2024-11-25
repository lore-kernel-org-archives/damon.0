Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220C1E49F
	for <damon@lists.linux.dev>; Mon, 25 Nov 2024 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732510194; cv=none; b=N6SXOWQZH0AJMTLsxKeEF8WIrmM8eteYQ8Ih7Bpt/T/s5E6S+SNrhoQBCFbn2c2dnw1rKUKnDgZ61WcxSrfp80R8mHB82lNqCTl/XmM7aQnyo1YZYlWu7u+2maqKlMuvVG5v5647p24wgOGDJJPC21sD3x53rJqh7phJGzlRXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732510194; c=relaxed/simple;
	bh=zyf0ARzCvxAQj33+jVDBiEM69ZSzG/w6s1nzY/6MWL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAfprw1Z3Ve/jkjSs9DQG3IH5zd/OZj5f+Pvg8i0wioXWUM8s6CraMUn5tS6j2lVMnmwOPkpdH33aiT+rAMfhItWX7yEwedW3DA+5QtaklsiFE4oh87IA4VrqpmT2iMFLqLHchPxW8Qt/n5dgUyH00Cm5Kqggq060ORZQpliink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-02-674401e9b505
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH] mm/damon/core: Refactor damos_set_effective_quota
Date: Mon, 25 Nov 2024 13:49:33 +0900
Message-ID: <20241125044938.1412-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241122192926.58718-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsXC9ZZnke4rRpd0g4WXWCye/P/NanH46xsm
	ByaPTas62TxebJ7JGMAUxWWTkpqTWZZapG+XwJUx+/FCtoJ7ohUrb3E0MH4V6GLk5JAQMJGY
	//ArC4y9aVoXG4jNJqAmceXlJCYQW0RAUeLc44usIDazQIRE08yTYHFhATeJ9Yt/ANkcHCwC
	qhL/mzJBwrwCZhLzZ3ezQozUlHi8/Sc7iM0pYCyxp3EvI4gtJMAj8WrDfkaIekGJkzOfsECM
	l5do3jqbuYuRC6j3KavE4ob/bBCDJCUOrrjBMoGRfxaSnllIehYwMq1iFMrMK8tNzMwx0cuo
	zMus0EvOz93ECAyuZbV/oncwfroQfIhRgINRiYd3QrRzuhBrYllxZe4hRgkOZiURXj5xoBBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbG/Ceita1lHy7u
	qdTm+Sz7NtxWUfajacLeluXPpLQ16qXXcvOkHJj35K7prhsaXMsvLvn2TW+jsXnx1kShG2WH
	9y4v2s+6MTM58uWS7QdOPChjeamjnqTvcqxqwTIezTVbFxyel7P+P+uZDdObF5Vu/jW5Xebc
	u8Urqr7v/HlkwtJApxXW7+MU5ZRYijMSDbWYi4oTAUohCAAqAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42LhmqGlp/uS0SXdYN0WE4sn/3+zWnx+9prZ
	4vDck6wWh7++YXJg8di0qpPN48XmmYwe3257eCx+8YEpgCWKyyYlNSezLLVI3y6BK2P244Vs
	BfdEK1be4mhg/CrQxcjJISFgIrFpWhcbiM0moCZx5eUkJhBbREBR4tzji6wgNrNAhETTzJNg
	cWEBN4n1i38A2RwcLAKqEv+bMkHCvAJmEvNnd7NCjNSUeLz9JzuIzSlgLLGncS8jiC0kwCPx
	asN+Roh6QYmTM5+wQIyXl2jeOpt5AiPPLCSpWUhSCxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl
	5+duYgQGz7LaPxN3MH657H6IUYCDUYmHd0K0c7oQa2JZcWXuIUYJDmYlEV4+caAQb0piZVVq
	UX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDY82nDuPMjCx+Fb09dWlJ
	Sfbbf5Ur6Pjxvwq5cSD8cVem9yv5nCT94u/S3rM+zz2aW75Q/qHZ12Du6h3+M7/EfhDcYqms
	fcZWyS/p33aGWZvWarkpWmZ46jQ+UevfvtJZp3O3a9FBv28vtzs+looXOeqwPnSZKUtZ3peV
	5utk7U59nio1d81WJZbijERDLeai4kQAcUT7GRoCAAA=
X-CFilter-Loop: Reflected

On Fri, 22 Nov 2024 11:29:26 -0800 SeongJae Park <sj@kernel.org> wrote:
> Hi Honggyu,
> 
> 
> Thank you for this patch.  Definitely DAMON needs many refactoring and
> cleanups.
> 
> The subject of the patch is a little bit ambiguous to me.  Could we make it
> more specific, e.g., "set esz of damos_set_effective_quota() as ULONG_MAX by
> default"?

Hi SeongJae,

Thanks for the review, but IMHO, setting the default value of esz is to remove
one of duplicate if statement, not the goal of this patch.

So I think the following title might be better.

  mm/damon/core: remove duplicate list_empty quota->goals check

Is this okay for you?

> On Fri, 22 Nov 2024 17:18:34 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > The damos_set_effective_quota checks quota contidions but there are some
> > duplicate checks for quota->goals inside.
> 
> >From the above, I was thinking the duplicates should be somewhat unnecessary.
> And indeed the function list_empty(&quota->goal) multiple times.  But, that's
> not for a unnecessary reason.  We need to know whether 'esz' is set or not.
> The check is for that.
> 
> > 
> > This patch reduces one of if statement to simplify the esz calculation
> > logic.
> 
> More technically speaking, this patch gives 'esz' a safe default value, and
> removes the checks of 'esz' initialization, which is no more necessary owing to
> the default value change.
> 
> Honggyu, could you please update the subject and message to more clearly
> explain the change?
> 
> > 
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > ---
> >  mm/damon/core.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 511c3f61ab44..eb2761866dda 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1542,7 +1542,7 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
> >  static void damos_set_effective_quota(struct damos_quota *quota)
> >  {
> >  	unsigned long throughput;
> > -	unsigned long esz;
> > +	unsigned long esz = UINT_MAX;
> 
> Let's use ULONG_MAX.

Ack. I will apply this and send v2 soon.

Thanks,
Honggyu

> >  
> >  	if (!quota->ms && list_empty(&quota->goals)) {
> >  		quota->esz = quota->sz;
> > @@ -1564,10 +1564,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  				quota->total_charged_ns;
> >  		else
> >  			throughput = PAGE_SIZE * 1024;
> > -		if (!list_empty(&quota->goals))
> > -			esz = min(throughput * quota->ms, esz);
> > -		else
> > -			esz = throughput * quota->ms;
> > +		esz = min(throughput * quota->ms, esz);
> >  	}
> >  
> >  	if (quota->sz && quota->sz < esz)
> > -- 
> > 2.34.1
> 
> 
> Thanks,
> SJ
