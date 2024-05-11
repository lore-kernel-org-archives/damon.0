Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181143C2D;
	Sat, 11 May 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715458583; cv=none; b=WiEaO1IXeig/R+Mk/Hb5dXIfILEXaWUNc9VSnx6Ks4Bjue5Iv6hHfINOkizxwjYj6dnvsLHL4lclLMlmxUj6pNE1g5VDgfgpSVsAGU3EMsMw4VXWzIT1Uy9UfJC+9aNKjryEs1KgwKgiBuYD3GyLc9/BBn0W/kws7mUH+GeByb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715458583; c=relaxed/simple;
	bh=+LpkdgC+Wz7IOQEvnu/ilSBedx9vD5FOuP4V+JSN3Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9GKE94qc5D8Iu25YVKWOnhIZQSFbzX2UuMaoovtTDiqstPVrbZU6gi38YoA4GnXPs5AiVT89KYaMm+uIjffT/VKD1rE5yBk9HhGhk2qql1Bhg2FlSm/T7jz/25p5ECxEfLremw+vLpZt3giWkncTsUV7UosN5bFwLpqDVhiR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO8RqGiS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO8RqGiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B66C2BBFC;
	Sat, 11 May 2024 20:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715458582;
	bh=+LpkdgC+Wz7IOQEvnu/ilSBedx9vD5FOuP4V+JSN3Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hO8RqGiSiGIdbzIQNIjJaqd4zgy6EslWUiMHUweZkfie3pxeLyxEAbjda0l+zUC6o
	 Y58knSk9QRMq1/ZpO5GNaHVu59Vk9UxEQO6pXmTE2CMF5VBcB27rPgKPVZJVf0ivSO
	 nLZ8PHLf5xzaW3JshPYmUELWfhUi91dKzMHj5XQL3TZ8qjL7YXziEI3qwHQGKQoWED
	 kWraXXxWAX4Qrwcpkd/tZESwllbjt2dPY/NeBsJ82iBUc7OAlyUxMhdQUz0OBUERxV
	 UIpw/+wgG3IzoRjtgFoANMcgM81urgQNdnz1E1ZaoeTi5xgftjJOf17eEW2JPSUjU4
	 1nB2HyEV7YBew==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 1/7] mm/damon/paddr: refactor DAMOS_PAGEOUT with migration_mode
Date: Sat, 11 May 2024 13:16:17 -0700
Message-Id: <20240511201617.292811-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405191907.66958-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 12:19:07 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri,  5 Apr 2024 15:08:50 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > This is a preparation patch that introduces migration modes.
> > 
> > The damon_pa_pageout is renamed to damon_pa_migrate and it receives an
> > extra argument for migration_mode.
> 
> I personally think keeping damon_pa_pageout() as is and adding a new function
> (damon_pa_migrate()) with some duplicated code is also ok, but this approach
> also looks fine to me.  So I have no strong opinion here, but just letting you
> know I would have no objection at both approaches.

Meanwhile, we added one more logic in damon_pa_pageout() for doing page
idleness double check on its own[1].  It makes reusing damon_pa_pageout() for
multiple reason a bit complex.  I think the complexity added a problem in this
patch that I also missed before due to the complexity.  Show below comment in
line.  Hence now I think it would be better to do the suggested way.

If we use the approach, this patch is no more necessary, and therefore can be
dropped.

[1] https://lore.kernel.org/20240426195247.100306-1-sj@kernel.org


Thanks,
SJ

[...]
> 
> > 
> > No functional changes applied.
> > 
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > ---
> >  mm/damon/paddr.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 081e2a325778..277a1c4d833c 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -224,7 +224,12 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
> >  	return false;
> >  }
> >  
> > -static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
> > +enum migration_mode {
> > +	MIG_PAGEOUT,
> > +};
> 
> To avoid name conflicts, what about renaming to 'damos_migration_mode' and
> 'DAMOS_MIG_PAGEOUT'?
> 
> > +
> > +static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
> > +				      enum migration_mode mm)
> 
> My poor brain has a bit confused with the name.  What about calling it 'mode'?
> 
> >  {
> >  	unsigned long addr, applied;
> >  	LIST_HEAD(folio_list);
> > @@ -249,7 +254,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)

Before this line, damon_pa_pageout() calls folio_clear_referenced() and
folio_test_clear_young() for the folio, because this is pageout code.  Changed
function, damon_pa_migrate() is not only for cold pages but general migrations.
Hence it should also be handled based on the migration mode, but not handled.

I think this problem came from the increased complexity of this function.
Hence I think it is better to keep damon_pa_pageout() as is and adding a new
function for migration.


Thanks,
SJ

[...]
