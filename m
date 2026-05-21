Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62ED3FD130;
	Thu, 21 May 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373854; cv=none; b=JqeQtjKVi2wYujrRNudjMfXmM9KemQLEg7S+lpRNAC0r7EXfJZ/H7yFRpreNxfBiybP6tlBreHKanNTijsB1Y1Z2D/9CjQAyxDhZT1RtjR6Pm4bZTH3GUS4Xc/1NfaEcGS+Ckpb/WcQ+bNVnrgSf7Lz63SAHjzb9Ec1+7LSzi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373854; c=relaxed/simple;
	bh=f0FUG+j+0NjmwZBRP4vZPJzQf0vOEGkxaBlzMKyrgKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR6+gitopLxpa0oj+QkUFDHniQj9yMFdcixtk8cf7sJwLU5/5pZzvFUoVia0F3EKDqukHfnH8TxNTwVM/MW4GXklxk2GeOGCWj0XMJ+wPmmGGLZHTg+r8HxCjRasiTHR3+vBoEMjeuB6kJ0aWwZOxDWIuevfQMnlXlqaDGomero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvRGgHMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvRGgHMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C4E1F000E9;
	Thu, 21 May 2026 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779373853;
	bh=ytCtYAbDMoi50EVmKyGwP8l3Bc1iyOOpcTsBTsqE27Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BvRGgHMCe08HiDzpk54AlIL9OaxfRvKXudxABSaibuH+gLfHbJg0Vm787J6VLebpF
	 OClo1gXqbzHmRx4zOyL2i6R1MDvDVD0tKRbZKpK44itxD6Zk0b6y2oBJGCoyujWLZZ
	 kpi6b3a/z+uHFabnDqd+RoOH5h3u+DR8oG2I1un3Vm6gG5eqQdBZEWeZIhaYY2Lbly
	 0gLkdeLGBjYZGUUnLj10fon1L4CqlOArgJpcuotXU4Yj6Ag93UlriEmlwq2KYbl5DP
	 KMAbR/umSaW2R3DdI7k6Bc9MPYMmgUn7YdUsmjK8RnyEMch4qzGth7n8raLO1bTivA
	 UHzOsQ5N0K45Q==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/damon/core: detect internal variation above max_nr_regions/2
Date: Thu, 21 May 2026 07:30:48 -0700
Message-ID: <20260521143049.82745-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521045236.115749-1-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jiayuan,

On Thu, 21 May 2026 12:52:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> kdamond_split_regions() bails out early when nr_regions is already
> above max_nr_regions / 2.  A large region that picks up new internal
> variation after that point never gets split, so we lose visibility
> into its hot/cold structure.
> 
> We hit this with damon-paddr on hugepage workloads and damon-vaddr
> on processes that mmap a large anonymous range.
> 
> On our production tree we added a current_nr_regions counter (no
> good upstream home for it yet, so it's not in this series).  We saw
> nr_regions never getting close to max_nr_regions, and the picture of
> the access pattern was too coarse.

Is 'current_nr_regions' somewhat showing the number of DAMON regions?  If so,
you could also get the information from nr_regions field of damon_aggregated
tracepoint.  I'm wondering if you considered using that but found a problem
that made you have to implement the internal change.

I will be happy to help removing such downstream changes.

> 
> Example with max_nr_regions == 1500.  A target ends up with 799
> small hot/cold regions plus one big region (an earlier merge
> collapsed a uniformly-accessed range into a single piece):
> 
> H:hot
> C:cold
> 
>       r1     r2     r3                 r800
>     HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|
> 
>     nr_regions = 800  >  max_nr_regions / 2 = 750
> 
> Now a cold subarea shows up inside r800:
> 
>       r1     r2     r3                 r800
>     HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|
> 
> The small regions can't merge with each other (their access counts
> differ), so budget never frees up.  r800 can't be split because
> nr_regions > max_nr_regions / 2 returns early.  The cold subarea
> stays invisible.

I agree this corner case could theoretically happen.  But, would the small
regions have the current pattern forever?  On real world systems having dynamic
access pattern, I guess those small regions may not keep the shape forever, and
give chance for the large region to be split.  Am I missing something?

My theory also implies that this kind of situation could happen at least
sometimes for temporal periods.  In other words, it could happens too
frequently and too long to be problematic.  But, in the case, maybe the user
could mitigate the issue by increasing the max_nr_regions.  I'm curious if you
considered that direction and found a problem that I don't expect for now.

> 
> Patch 1 lets this path still split regions that just changed
> (age == 0),

Why 'age == 0' means it is a good candidate to split?  Because it means its
access frequency is anyway unstable?  Or are there other reasons?  More
clarification would be helpful.

> up to whatever budget is left under max_nr_regions.
> If a split turns out useless, the next merge cycle undoes it.

I'm again curious why the user cannot just increase max_nr_regions.

> 
> Patch 2 adds a KUnit test for the case where nr_regions is already
> above max_nr_regions / 2.

Adding tests for new features is always nice, thank you!

I will review each patch in detail after the above high level questions are
answered.


Thanks,
SJ

[...]
