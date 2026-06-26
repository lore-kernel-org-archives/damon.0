Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF33F9A16
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485361; cv=none; b=p2C8IHCXpYKIOLcyNLQoJrAA6dbpT8xFLsRDmTF24wtWUWeCz/o4G9VffWJc1oDUUSINi5oHLc6GihEl9m4dSdFHmZyFPr9wIiE8BiiAIM0EuHi4KJUlKSIlnttIxDylv/cVEaihsNv0IkJdqUfaT3kbzoUWWBpXUAtZxsq3VDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485361; c=relaxed/simple;
	bh=ht6hqVBA6+kPvkz8uIDL2bxBguw/DGfLnM3WZzSDb04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDkzJ7hEEu9zhsvFDn0Di4rI2+PfzzraOOURt2mWyArybAQhgIcdtnSgEfDaiSLi9A9siYxVhJdpniIgCiog0okSzsMCrtSQG5sKKCOBMOjIfreriiI5vzZr71l6Kr+8nxkr1NC3gqx35gNtl5tsEIwGdUJGs5xWkTZv+DwbOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4acX/wu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4acX/wu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1181F00A3A;
	Fri, 26 Jun 2026 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485358;
	bh=5z8jE8rdTjAljPQUocGynDQCUdCJWqD9QdNnHKt2pss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N4acX/wuG1KfI/7eyPruKNYwXmHqCdT5SjwZ/XUASSKY5D3mYDtikEPAt7fS5kkI8
	 oeJG41Txhv8KswIaFe6kvDojBoSG5DInCeMWhCptE6OsXkoQT7qnQ1hY/ZI96CVd6Q
	 McJzrXYun9y2Wsnm5LAzyKzwSJXHsf/7q45bNZWkuvM8CnVpQo3DoaD+Psmq40GFNm
	 QgCZLCe6YbRQcycVe22MxpsUhcdHl8F4pA6Td6sBaDJ6rGcddb+D3CjZhuSwmDmbSE
	 n9yGVVTJ4FrmGlMf1NMDPZ05uHjiFs0jPg3mW+Rkv4c0jHWADz1TebnkvdOQf9uhdm
	 f2CNvXns6HBbQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Jiayuan Chen" <jiayuan.chen@linux.dev>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 1/2] mm/damon/core: split a fraction of regions when nr_regions exceeds max/2
Date: Fri, 26 Jun 2026 07:49:05 -0700
Message-ID: <20260626144906.86649-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626090915.73D161F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 09:09:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Data race on the globally shared static variable `rotation` causes undefined behavior and inter-context interference.
> --
> 
> commit 2895b546218b4ccc570b82e50e62f788bac4157b
> Author: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> mm/damon/core: split a fraction of regions when nr_regions exceeds max/2
> 
> This commit modifies kdamond_split_regions() to split only a fraction of
> regions rather than returning early when nr_regions is above max_nr_regions / 2.
> It uses a rotating offset to ensure different regions are picked for splitting
> over time as the region count smoothly approaches max_nr_regions.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > +/* Split one in every @split_step regions into two, from a rotating offset */
> > +static void damon_split_some_regions(struct damon_ctx *ctx,
> > +				     unsigned long split_step)
> > +{
> > +	static unsigned long rotation;
> > +	struct damon_target *t;
> > +	struct damon_region *r, *next;
> > +	unsigned long offset = rotation++ % split_step;
> 
> [Severity: Medium]
> Will this cause a data race if multiple DAMON contexts are running concurrently?
> 
> Since rotation is declared static and locklessly incremented, independent
> kdamond worker threads could read and mutate it simultaneously.
> 
> This unsynchronized read-modify-write on shared state might trigger automated
> data race reports. Additionally, does this mean different contexts will step
> on each other's rotation offsets, breaking the intended round-robin behavior
> for each individual context?

I don't think this matters.  We don't really need strict round-robin but a
level of fairness.  Let me know if I'm wrong.


Thanks,
SJ

[...]
