Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FD4772B0;
	Thu, 13 Aug 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629345; cv=none; b=PtauUP5mX/8v1W4a20yGmOgwj2YfYEdyk1X8tsPtVsP0tq3RMpcONBxYleaG0ZChll9mRRVAdZlPcDeSrJJ74EdLscMrwGJ6+mIzFRUKD9eVQmwnJRUxAAIQaCZiiBJXLR3eIs7keFeGSGn4LYz3sm0tS0SDgdkcKS2IsOAxNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629345; c=relaxed/simple;
	bh=WkeH7yC/Twav4r1GKnReG59IJuuWUls+8H7HZl1Wu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFpq8isD1iJXajTzlR45jEHhzoK1xrwweh8chAaU5Ym442egZQV6BfNY1/4zGw0JdhaDbNEPT6iKSzRD8GhBu9nnxa1UC1cXZu/M4mwEQKGBqUufr0TFmE3ffXCxHr5TiV2UTudS2JqeyYH44mGY7zhP0eiZjeJj5e8XZH6CE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu23tjCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu23tjCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8ED21F000E9;
	Thu, 13 Aug 2026 13:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629344;
	bh=4O5XEeZocNetZ7qyN1aDqk/yfr0Rg6N9g8gJngopdVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yu23tjCZTaClsSYTUZVBfgHQKBSOkirzVAcnaBgutxH09oGFlO3vY8s84vCwbzaXa
	 3MsipDR3OXfZAOzTfFYI0hveMI8pfrQe3BXkS2cnK5T0nlhFL+/1f45+MvwdHV23mO
	 FpPBVSPHVKd53yQpWkMPBVQ/Bk1LqgTdpBkwegnAgQJN8p7thuOYHKUWQE8HUnNXKP
	 9WptMNFyWIjSThMt7zIdF7QA6EUC5lyB2X0tgNffQDjWX1V0/6toschDQ86Po6vtQz
	 hhWsda0gXwtJO8rLG8m5BSiMDFMCGUz6w8pJZZT6rGL2AeirNzH+9rILcqIJkewFZd
	 1cGx8HeJab9dA==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] mm/damon/core: handle NULL ctx parameter in damon_call()
Date: Thu, 13 Aug 2026 06:55:35 -0700
Message-ID: <20260813135536.103668-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ed32d112-2873-4e29-9d4b-d5bc72b70f52@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Asier,


Thank you for your review!

On Thu, 13 Aug 2026 11:33:01 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ,
> 
> On 8/13/2026 6:49 AM, SJ Park wrote:
> > When NULL damon_ctx pointer parameter is passed, damon_call() could do
> > NULL dereference.  The caller is responsible to avoid that.  It is easy
> > to forget, and there are many damon_call() callers.  Meanwhile,
> > damon_call() is never meant to be performance critical.  It uses mutex
> > and completion.  Add the NULL pointer check inside damon_call() so that
> > callers can pass the parameter without NULL checks.
> > 
> > Signed-off-by: SJ Park <sj@kernel.org>
> > ---
> >  mm/damon/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 92631a36d7b51..5882f9c94c47f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2188,6 +2188,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
> >   */
> >  int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
> >  {
> > +	if (!ctx)
> > +		return -EINVAL;
> >  	if (!control->repeat)
> >  		init_completion(&control->completion);
> >  	control->canceled = false;
> 
> I know that this is a minor optimization, but how about moving INIT_LIST_HEAD(&control->list)
> to right before list_add_tail?
> 
> It doesn't make sense to initialize the list before checking call_controls_obsolete.

I agree it might be more efficient.

I think my intention of the code was to to keep the call_controls_lock critical
section minimal with access to things that really protected by the mutex.
Moving the simple initialization should be fine.  As you mentioned, it should
be minor change.  I'm bit concerned if it will confuse people if the list head
is also protected by the mutex, though.  What do you think?

> 
> Maybe this suggestion should go in a different patch.

I agree.


Thanks,
SJ

[...]
