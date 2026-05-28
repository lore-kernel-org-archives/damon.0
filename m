Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6882641CA
	for <damon@lists.linux.dev>; Thu, 28 May 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976829; cv=none; b=DDLx+l3/I6LoG7tAXOjN6hW/euU+UzI0aYoTefY8WkxxSKCQx0Hst0ude4SJhBMdqc7Fyg1UwcY+4M7R8j076ddMLBo7Duktmzu7Fh5j5eHEXJ7EJrph1Cuo18MmfnzPkTid4JF27Nlgok+4sMFXXZC1sMt9obKRbNrHICT84Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976829; c=relaxed/simple;
	bh=Thha2VfvUBLNOuJbeUVYHPgpw0c+H+ptt4e7fcsbIo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha+gIli8xBgUKC+Elmti2IQyOvII5/Tb/nEAdGhSNkASnlIy7y2FatHkEpK+hKojkE4jNsNvk+ZZ7+BiOQJUsuvij2PnApaxx+LiVbqsxmTwHVfLfuBW9s0XS8AecemTwxsABSNfrB6WR8oYD/CKVZfQQFO8hH3qyZPQVyAaK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ3mkcqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ3mkcqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6421F000E9;
	Thu, 28 May 2026 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779976828;
	bh=0SW8BTFWiQiMKkX7KFZEmrRnv79jciYkRW07BCqPj8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oZ3mkcqTbI23Y89qUuW43YB1xM1W1B1Qmr8aUbvKgaczPBN9h/y+3NUhDujrgdP8z
	 EtqIQlIRC5h1AkB9WySOTSxFrfaLA9953WZm1lNKj63ESOy/zyhU9rzcmtZAjOUKmW
	 X12p+RhMs4qRSZYTBXJl7/I2KZEiPyhUth2G/yTBDAMHApkbJ7uUxtcaNskIWbyrDK
	 TS/jvgeLNSsl7wPAR1YeTVzFuFfawav63sBXcn5s4RmqXt1a03uS96AXr9rLe4Jl33
	 1Vfp6VcYCNCZqsJWSz/Ts24oy7PksFgrVxvvQ+XgpsbA8WN0uEK/Bpmjrw/hXInPMq
	 ndG7VHHkMec5Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/2] mm/damon/reclaim: handle ctx allocation failure
Date: Thu, 28 May 2026 07:00:24 -0700
Message-ID: <20260528140024.152957-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528065054.471371F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 May 2026 06:50:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch prevents loading the damon_reclaim module with the 'enabled=Y' parameter by returning -ENOMEM during parameter parsing.
> --
> 
> commit d55c0d692febe0a6f116ac49f1c1187ff2f47d7b
> Author: SeongJae Park <sj@kernel.org>
> mm/damon/reclaim: handle ctx allocation failure
> 
> This commit adds a check in damon_reclaim_enabled_store() to return -ENOMEM
> if the ctx pointer is NULL. This is intended to prevent a NULL pointer
> dereference if the context allocation failed during initialization.
> 
> Cc: stable@vger.kernel.org # 6.18.x
> 
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index ed446d00ef1cf..ce4499cf4b8b0 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -399,6 +399,10 @@ static int damon_reclaim_enabled_store(const char *val,
> >  	if (!damon_initialized())
> >  		return 0;
> >  
> > +	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> 
> [Severity: High]
> When the damon_reclaim module is loaded with the enabled=Y parameter,
> load_module() calls parse_args() before running the module's
> damon_reclaim_init() function. At this point, damon_initialized()
> returns true since the damon core is already initialized, but ctx is
> still NULL.
> 
> Will this new check return -ENOMEM and abort the entire module loading
> process during parameter parsing instead of successfully loading?

DAMON_RECLAIM is not a loadable but static module.  So this cannot happen.


Thanks,
SJ

[...]
