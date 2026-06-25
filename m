Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5182F60CC
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364869; cv=none; b=MBf989d1YBouvX0icxnLjj1uaTLtkGMoVvr3+NTQ1aOl4uk0E+lrTPxQ5bRsP0O1cKqHl95D1Xa7CTuDCwlKMNEriJlfTTB4ZijPb3P/z/jw1GGgpvEd/a0lZDZjKNbRGshbPkzawK9aDHXbpoL7jFpii4Q+IgfsUgGHO48FK8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364869; c=relaxed/simple;
	bh=QqibP5CgxDG8JyuEna7h1QfQ8cZyx6dWzOZ5p4ElTk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPjRZ27dSkVLEdmjpdDHPGaGAMu0uZ7G9MvlXVyRmZJsYIOCaVd6npHQWBZkyjPv9fdjfLtcf6Gxq4MPNkwq30rO/sIqsDuIWibBzm3a1W/sKyF6xOaf2ErDKOvJkrRnplDdJa40xbzmDLOTc52+RIz/Y/vRehoABbov7fi0nAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG3soMPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG3soMPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E531F000E9;
	Thu, 25 Jun 2026 05:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364867;
	bh=Roma0R9rmnLoi3JVWREQMy3S8BYENfq15SgoapklzmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WG3soMPeWYBP/PN6l/jAiURSL0Ow1PT0oJt/VekJNJcpeBL8v1tptPLBNBIAuYyiX
	 6cgpCx34lwbmkZEI4wPFBst+Xu9pRL3raJseIm41rfRcj36VaodbTi30DHa3byonEG
	 vlfuvz39NB4m7G8L+W30J0VOUohc7RKsz7V6toIj2CMvG8VjH4Mh7XpNQV3S3zjRDm
	 bx3iIO+kpzKEA/OpKSWPm9hAhA6M2sTrvtSRScKQkwnOnWJXqEN4yBuJL3eHCMSfSe
	 f12mR8TjCWadiPw7HroLs+7Zt98YVXKqGrZ31SaK44sMe5iHTSwJ0YFGN7zmHh57Qf
	 5ahkufozS90Fw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 01/11] Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Date: Wed, 24 Jun 2026 22:20:54 -0700
Message-ID: <20260625052055.92306-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625051351.419A51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jun 2026 05:13:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch introduces an internal inconsistency in the design document by documenting the `node_eligible_mem_bp` metric but failing to update the adjacent sentence that lists which metrics require the `nid` parameter.
> --
> 
> commit 77a1ee91d398d22fd9a42b16bbf085e55f72a94a
> Author: SeongJae Park <sj@kernel.org>
> Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
> 
> This commit updates the DAMON design document to include the
> node_eligible_mem_bp goal metric that was introduced in an earlier commit.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -686,6 +686,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
> >    (1/10,000).
> >  - ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size ratio in
> >    bp (1/10,000).
> > +- ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
> > +  of a node in bp (1/10,000).
> >  
> >  ``nid`` is optionally required for only ``node_mem_used_bp``,
> >  ``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
> 
> [Severity: Low]
> Since node_eligible_mem_bp is a node-specific metric, should it also be
> added to this list of metrics that optionally require nid? As currently
> written, the use of the word "only" implies that node_eligible_mem_bp does
> not use an nid parameter, which could be misleading for users trying to
> configure this metric.

Good catch!  I will do so in the next revision.


Thanks,
SJ

[...]
