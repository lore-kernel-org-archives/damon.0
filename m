Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CF3EBF2F
	for <damon@lists.linux.dev>; Tue, 17 Feb 2026 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771287210; cv=none; b=DF9XLYESnPTR2KFGKqlu9xXdeX/emnd+m26d1uxTEgtx5B32bIJ4QeJd+2Z+b/zybGu8q+2vPNW1DDBzw/jzEQTlK2hr5aa5VSw5P7mt1gtrUhJqBBxssBZIoc+TVVtcSO9ahNElBjqcCP+ATk9ofSdbyNno41JWwn0oe/u/+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771287210; c=relaxed/simple;
	bh=ip/RBWDdw9HJHNpuhUYZixgSxIZwtTtHs1lSkKTGCYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX25aOfpehYY47x0vnFeFXt0wb0oG/oUooA0E4Vsfc/DOKLxRxEkJEnQDDxRyAgDbg5sR7xEL7X1JjXUfmLQDBKBdYzZ1smZK87I32nqLYy2V8TsPp5AnnQl3AOKiE81CZbDTTx6Rn5cJOplT+V11knt1xJZFmmizAz/ijfcsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3HvoVkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3HvoVkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1F0C116C6;
	Tue, 17 Feb 2026 00:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771287210;
	bh=ip/RBWDdw9HJHNpuhUYZixgSxIZwtTtHs1lSkKTGCYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3HvoVkbCc27zBuAZ4eYMvvr/Ika5mjCjEHP7Tsr5LQ1pMKd4Gyh3kbHLUJMcrpsY
	 oYpSjtveXgfEaNKPIVPJziFXuWj66I+z67OgyIGRufqra8kSadXwBAqBi7y/Mh6jjs
	 90j2SGVbXYFnvHj3PZIZHx6AYRGfX11+lOPakGMzfTBJpggruWuLUeRQGE8zQUWwEZ
	 kze+9Ar5CVyPA020jqeDr1unawXbAG33uyDZkt5DNUJXDv8/p7jJ/vwkX0399MZZh3
	 XVKqJAWXTq6EguODD1KtrBf/M4ws4PRRS0gBvBOIbDJpa2HDwEToz2lVdm0BWFcjQr
	 P0RXT20T0R3Yg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: introduce perf event based access check
Date: Mon, 16 Feb 2026 16:13:23 -0800
Message-ID: <20260217001325.69633-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128011225.71964-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 27 Jan 2026 17:12:23 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Tue, 27 Jan 2026 21:56:43 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > 2026年1月27日(火) 15:43 SeongJae Park <sj@kernel.org>:
> > > Actually DAMON is internally setting such maximum region size based on the
> > > min_nr_regions parameter, via damon_region_sz_limit().  Nonetheless, the limit
> > > is applied only in regions merge time.  That's why it requires the regions
> > > split to happen sufficiently until the real fixed granularity monitoring is
> > > started.
> > >
> > > And I think this behavior is just a bug, or suboptimum implementation at least.
> > > That is, users set the minimum number of regions but it may not really be kept.
> > > That's definitely confusing behavior.  Actually there was a similar case that
> > > number of regions can be larger than the max_nr_regions.  We fixed it, with
> > > commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
> > > max_nr_regions is unmet").  I think we discussed about similar case for
> > > min_nr_regions, but I cannot find the discussion for now.
> > >
> > > So, I think it is better to fix this rather than introducing a new parameter.
> > 
> > I agree with that.
> > 
> > > Maybe we can split regions based on the min_nr_regions based size limit, before
> > > starting the main loop of kdamond_fn().  Similar to the max_nr_regions
> > > violation, there could be yet another corner case on online parameters commit
> > > situation, so it would better to check the case, too.  You could implement such
> > > fix on your own, or let me do that.  In the latter case, if you don't mind, I
> > > will add your Reported-by: tag to the fix.  Please let me know your
> > > preferrence.
> > 
> > You'll be better able to fix it, so please fix it at your convenience.
> > Adding Reported-by: tag is fine.
> 
> Sounds good, I will do so!

I just posted an RFC patch series [1] for this.  I will drop RFC tag after the
current merge window is finished.  Please let me know if you find something
wrong there!

[1] https://lore.kernel.org/20260217000400.69056-1-sj@kernel.org


Thanks,
SJ

[...]
