Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4F13A258;
	Wed,  4 Feb 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164948; cv=none; b=hLDqnI0ycN5u17Zg0F8n+ltKZBSRxulkKMgoe8YG1KMTU13VWbRA2n0L49OfXe9crZwxTnzjuATyJ+u1e60RpLK8Q0bK+36W6Iacptxt6zoUynB/ZxWIPtu79xMHICy6tMh2GmwTRjKWR14NabHT4N3h7TxeEAHoWHuQMRNg4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164948; c=relaxed/simple;
	bh=qXE3g6jBKd0Y66pW7cPox46N88wlCWyAaIJYLCmu0uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaKrN1TYsSp/Iu7SgPqHEZqzpGH5V7sWTkLInlTsmZr0v1XVsxk42XPq4vg3WopbkULekHFyBT4AK7YS4LJD14eG2Oji08mfgBrXpd3l+t3XDCGsSi3pwyMCgyScp7JCWu0vWYKKXo/beIHJ4Q4119DqKOUwOzOznXheeB3+CxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU8Q6VfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU8Q6VfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6442BC2BC86;
	Wed,  4 Feb 2026 00:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770164947;
	bh=qXE3g6jBKd0Y66pW7cPox46N88wlCWyAaIJYLCmu0uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU8Q6VfBQMpLFZ67aNKfIJIqzkP9TvOhTNtI59fwSZSXV6YqPxKwrWdmpHBv1dwSg
	 0VX5XZAN2rHTJ0fg32vC10Tsf1IkW0dCshjF1o730hypxasYnFn7LYpV9dECkI+2ji
	 ID09hCOwY7aUJJA2j5qoXyaGuhMo+MWELNg3FAYKxAf5zf6fdPhQ/ZaqY5ZxiM/zKn
	 G7+fEneH8mR2fRK4JYehWvbxOT9ag3t7+WbSuwXO99Hwcpf/mqviuc1hWzmw4/IHbz
	 7aGM2i79izcajfS5FS0mr/49sCoZxV1zCtmF82l5Sy08MXY7wRjrxOR27yq85g47gW
	 mtTmJPdG6tunw==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v2 0/3] mm/damon: Introduce node_target_mem_bp Quota Goal Metric
Date: Tue,  3 Feb 2026 16:28:58 -0800
Message-ID: <20260204002900.49291-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y1475VSnrNTn-AQtTTnye+sdAGu9sVO0YMEtLidNW53_=A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 3 Feb 2026 11:48:06 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Sat, Jan 31, 2026 at 11:54 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 29 Jan 2026 17:48:06 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > On Thu, 29 Jan 2026 13:58:11 -0800 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> > >
> > > > This series introduces a new DAMON quota goal metric, `node_target_mem_bp`,
> > > > designed for controlling memory migration in heterogeneous memory systems
> > > > (e.g., DRAM and CXL memory tiering).
> > > >
> > > > v1: https://lore.kernel.org/linux-mm/20260123045733.6954-1-ravis.opensrc@gmail.com/T/#u
> > [...]
> > >     Context 0: monitors node 0, migrate_hot -> node 1
> > >       goal: node_ineligible_mem_bp, nid=0, target=4000
> > >
> > >     Context 1: monitors node 1, migrate_hot -> node 0
> > >       goal: node_target_mem_bp, nid=0, target=6000
> >
> > In offline, Ravi enlightened me that using a single context with two schemes
> > instead of the above two contexts setup can be more efficienct and useful.  I
> > agree that.  It will be able to only single kdamond, and there could be more
> > flexible use cases that can use the whole-memory access pattern.
> >
> > That is, we can use single context with the two schemes, but adding a core
> > layer DAMOS filters for applying the schemes to only memory of node 0 and node
> > 1, respectively.  Similar for memory tiering use cases.
> >
> > But I was recommending the multi contexts approach to people because the
> > current implementation of DAMOS is not efficient when both quota and core layer
> > filters are used.  I was actually working on making it improved, and just
> > posted an RFC patch series [1].  After the patches are merged, hopefully the
> > single context approach will be useful and effcient enough for varying use
> > cases including the memory tiering.
> >
> > [1] https://lore.kernel.org/20260131194145.66286-1-sj@kernel.org
> >
> Thanks for providing the DAMOS_FILTER patch update SJ.
> 
> For v3, I plan to introduce two complementary metrics:
> DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
> and DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP.
> 
> This will support the following approaches for hot memory migration:
> 1. Single context with two schemes using both metrics.
> (along with DAMOS_FILTER_TYPE_ADDR)
> 2. Two DAMON contexts each using
> DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP.

Sounds good!

> 
> Will provide more details on the implementation and usage in the v3 series.

Looking forward to it!


Thanks,
SJ

[...]
