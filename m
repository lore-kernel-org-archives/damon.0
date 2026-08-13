Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC1471252;
	Thu, 13 Aug 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633959; cv=none; b=hD13yKqV1Oq/go54z7AzankUN+wFLiN8gFOvbyF6yJflTzFDkyKXDI61qHHSvYRyuDYUxeWR3RfELp3Z3pTZvFRDnFCYkNAN8b83QeV59y4Nh3Yyz83AmX9QFLgLgHjSEROu4z+owmclXu1rHwJ7PoeewGLZ+nV0Ho+vnRYaXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633959; c=relaxed/simple;
	bh=XnbqLiqIV1FQd4IiUzMGxYU3JyTzIy1oAgnuyMcJTIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGGHceejnONywkw9oT41hSA7yHGKs7XhyVTYk/twoN9sBvDpR7rPnF56ytZc9KfJIXhLLDuIO9FCifOWlrl8nkEpgtzkFZxS0vndYKW7CY7Lgkr88p8u3OKM355qyNDLfIx0Rzd/s49kj2dqqoua2FrC9BMCSnyxl1mDM1A9LHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE0pDsWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE0pDsWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B786B1F000E9;
	Thu, 13 Aug 2026 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633958;
	bh=mx0MxRllchl62Kevt41rGLqe9TQSGfKjDVe1jsUGnDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KE0pDsWi0VHvtpwwCUK7kkil0WqRMnS9XnkTYhjQvgpWLMtedMJrB/zdxB43FOWPV
	 V3dUtzRGG6c6fLo/ehOpSrSce0+DsJYj10kWs3ED/K/j0eLMzTRquSkSE9B1oGxmBQ
	 MazZC0ilcmg89Mhhe0BKDWWNIWpmC9LEdpvfjXJNionwU7VuyAgD0/e5ajOfIRfXDb
	 zEw1iUuwbjQG8oLmBn7rODq9Md1PtoVi5ZSE464lrYjDeTcUpOkYhjpG60n5+98ojR
	 tjaTkkX9AFthobROfM7NcJO3zXQfrao4+mlKGUUDv6Wv0jevbIy99WsLND4a9bogz+
	 y0bdXvUQFbOiQ==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] mm/damon/core: handle NULL ctx parameter in damon_call()
Date: Thu, 13 Aug 2026 08:12:29 -0700
Message-ID: <20260813151230.104083-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c55a94f4-6ad2-4b60-b0ce-bf670dcc2f7b@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Aug 2026 17:27:51 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 8/13/2026 4:55 PM, SJ Park wrote:
> > Hi Asier,
> > 
> > 
> > Thank you for your review!
> > 
> > On Thu, 13 Aug 2026 11:33:01 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> Hi SJ,
> >>
> >> On 8/13/2026 6:49 AM, SJ Park wrote:
> >>> When NULL damon_ctx pointer parameter is passed, damon_call() could do
> >>> NULL dereference.  The caller is responsible to avoid that.  It is easy
> >>> to forget, and there are many damon_call() callers.  Meanwhile,
> >>> damon_call() is never meant to be performance critical.  It uses mutex
> >>> and completion.  Add the NULL pointer check inside damon_call() so that
> >>> callers can pass the parameter without NULL checks.
> >>>
> >>> Signed-off-by: SJ Park <sj@kernel.org>
> >>> ---
> >>>  mm/damon/core.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/mm/damon/core.c b/mm/damon/core.c
> >>> index 92631a36d7b51..5882f9c94c47f 100644
> >>> --- a/mm/damon/core.c
> >>> +++ b/mm/damon/core.c
> >>> @@ -2188,6 +2188,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
> >>>   */
> >>>  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> >>>  {
> >>> +	if (!ctx)
> >>> +		return -EINVAL;
> >>>  	if (!control->repeat)
> >>>  		init_completion(&control->completion);
> >>>  	control->canceled = false;
> >>
> >> I know that this is a minor optimization, but how about moving INIT_LIST_HEAD(&control->list)
> >> to right before list_add_tail?
> >>
> >> It doesn't make sense to initialize the list before checking call_controls_obsolete.
> > 
> > I agree it might be more efficient.
> > 
> > I think my intention of the code was to to keep the call_controls_lock critical
> > section minimal with access to things that really protected by the mutex.
> > Moving the simple initialization should be fine.  As you mentioned, it should
> > be minor change.  I'm bit concerned if it will confuse people if the list head
> > is also protected by the mutex, though.  What do you think?
> Good point, I didn't think about it.
> 
> Given that damon_call is not called often, I believe user experience should be
> more important than efficiency. Anyway, you have the last word.

Thank you for the quick answer, Asier.  I understand you are find with keeping
this as is.  Let's keep this as is for now.


Thanks,
SJ

[...]
