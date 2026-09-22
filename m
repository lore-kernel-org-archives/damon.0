Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5937DADD
	for <damon@lists.linux.dev>; Tue, 22 Sep 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080036; cv=none; b=ZwOb/1S8ZrM4rk3EWe9N41u6A2F5scq7gCVDByzeRhkwuyhne4143fwyHXld7O7BW7qhfVeWScK0gpOeEsPKodMDWKwcySIQ92djOxgtNpeYHJ2BDtin6kq+VP/rHmQJ+vFOXYfucS8kpvM3/R//FoRfFTjVxy/drfOmhDXFyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080036; c=relaxed/simple;
	bh=mxyZrLDdatfw9KRBKpuYgN37Ik4Lt9OlhT3vVMxnDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtmYhSd1NjJ/PbOYhdJ5W1tQFSIPXVe2IMKAJ9PX0mlFQ03l1LfMxYjPwwTtbcF2WsL0YmFDG7+Y/gHVkOsT4wfGUOup4kTzZKkZoxwOrmVS4tKjfiSts0GVSwZSX1uzQT/G3dMZ4yn1t7zphloP8NlpayDKJklmtNZmKtROqzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EidYkE5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EidYkE5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED201F00893;
	Tue, 22 Sep 2026 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080034;
	bh=OTkrLQNgZQmW3sLUCc4OixOC/8K5rO9H2BZYQOc9HxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EidYkE5L6XO1OH4VsNzYp9GCunn2tw55fXtvwlbfvoYjT19m3iCHFWzW0dBdvoTBI
	 D6tdvYl8/2JgVyP37RsDRBAdM81zDEEpeQsxWBQWyv5CdDMpiqmPMCZIlhmFcaBWWf
	 10XxnR59wiX2atlWWqH5y02vpmTQlhLuViMgD9wNr5bSIWg8LelYYBR/b/nJ3W+HAY
	 lASBE6MQMlxlp2UQ+DQJ6RP+clQbrXxo6qLy/Mhokt+ScOvoCMTsEHlR8KnQlUnnn8
	 EUgizoNEzVTifnW9LLQ03POqrefXmvUAWSKpFG8dyxh+V6CH8WauYhOVnjbnpFeRj5
	 qkQXD0OW5oSXg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 1/8] mm/damon/core: safely validate src on damon_commit_ctx()
Date: Tue, 22 Sep 2026 05:27:10 -0700
Message-ID: <20260922122711.2449-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702213558.96934-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 14:35:58 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu, 02 Jul 2026 21:21:42 +0000 sashiko-bot@kernel.org wrote:
[...]
> > [Severity: High]
> > This is a pre-existing issue, but does this unintentionally corrupt the running
> > quota state?
> > 
> > When __damon_commit_ctx() is called with the running context (dst) as the
> > source, it copies the schemes via damon_commit_schemes(), which calls
> > damon_new_scheme() and passes a pointer to the active scheme's quota:
> > 
> > mm/damon/core.c:damon_commit_schemes() {
> > 	...
> > 	new_scheme = damon_new_scheme(&src_scheme->pattern,
> > 				src_scheme->action,
> > 				src_scheme->apply_interval_us,
> > 				&src_scheme->quota, &src_scheme->wmarks,
> > 				NUMA_NO_NODE);
> > 	...
> > }
> > 
> > damon_new_scheme() then calls damos_quota_init() on that provided quota
> > pointer:
> > 
> > mm/damon/core.c:damon_new_scheme() {
> > 	...
> > 	scheme->quota = *(damos_quota_init(quota));
> > 	...
> > }
> > 
> > damos_quota_init() zeroes out the fields in-place:
> > 
> > mm/damon/core.c:damos_quota_init() {
> > 	...
> > 	quota->esz = 0;
> > 	quota->total_charged_sz = 0;
> > 	...
> > }
> > 
> > This mutates the running scheme's quota state, which would make the quota
> > effectively "full" mid-interval and prevent the scheme from applying its
> > actions until the next reset interval.
> 
> That doesn't matter because it is only testing purpose scheme, not the schemes
> of the running context.
> 
> > 
> > Since this patch moves this test context logic into the core
> > damon_commit_ctx(), doesn't this expose all API users like damon_reclaim
> > and damon_lru_sort to this state corruption when parameters are committed?
> 
> So, no problem.

I was misunderstanding Sashiko's point.  Karl is thankfully working [1] on
fixing this.

[1] https://lore.kernel.org/20260921003047.12041-2-kmehltretter@gmail.com


Thanks,
SJ

[...]
