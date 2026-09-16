Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E1361973;
	Wed, 16 Sep 2026 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789520306; cv=none; b=nhejYe+2R0T2dlu0yBEE8J3wZfpMZU2Z6bzNozUPqoW0CAFRtX3M3Wv4cVSbTf3H1/8cThFY3sN8X7DJi+1G8f0YF1+Fyrj+K6WCQJD+u69WvVVkXGuJTb10VWHlvuigc1nEsjpMe1RYVKTgg17SYavqHvg9XR2+hVh1m0jsn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789520306; c=relaxed/simple;
	bh=YkL2dHG2NNAhGHoLaq8TL4l3RtmhbKg16eOq7hcUi3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsFQX7ar26BMlv0mQ5eWNuhHHEM0Eo3rRmjpdbyWCHoVWTTWRTMB7umK812TaDDmSyY3YMXpWfvc+r2G79UK4MoiiMb8JngWCIwIe7YqtGUA83G/SMqNtLmHUUVv6w7K9jZRHDmTl7vqP7jpiC3oLUn88+OqbIecHQCV8oPB8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvauvRPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvauvRPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6871F000FF;
	Wed, 16 Sep 2026 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789520302;
	bh=KwdyHdv4MnQJM3h6YHH803Ox/K0l+mlSFgFkCNPYbYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NvauvRPrJvajpFZpLH57aY0fnKI0MrpEwDocwhlvNxlhitzUAEG1AjRQF0oH+wQP3
	 MWU2ycopmmE5EBaM4XTUqnGWsFjLOqf+TsnyvgN5qRbDYOFIjm7YZEy5auL/3ITcd7
	 Cu38tdUCRb2G7X4lhYdowX2GKEUyB9YQCltLSkoWHfX2fQlUdvuoMz+7FLJkF8TCuT
	 gXFljaNWwWacPpijchGAOBJWwo0Q0CIZOn2hjPgAQoD55QTWOU8Ef1CUAy+gUp/YeF
	 WoVLeKCl1I9WTmtZMO9ac0uuFVwyUiRjbBn9MMpbA67DsdNCOxmnEQiTF3HiMeR5YN
	 zUFWdJBywhiyA==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports
Date: Tue, 15 Sep 2026 17:58:09 -0700
Message-ID: <20260916005810.101606-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915025514.2434-1-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lian,

On Tue, 15 Sep 2026 10:54:51 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> From: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>
> 
> Hi Ravi and SJ,
> 
> Thank you for sharing this work.  The report path looks potentially useful
> for a DAMON observation-granularity problem that we are investigating.
> 
> The scenario originated from an issue reported by SXF, and we are planning to
> share and discuss it at LPC.  We have now reproduced the underlying observation
> difference on both a local PC and an x86 server.  The server run below is our
> larger, controlled reproduction.
> 
> Our test monitors a QEMU process whose guest memory is backed by a shared
> tmpfs file.  The guest repeatedly writes one 4 KiB page in every 2 MiB range
> of a resident 48 GiB data set.  The unique 4 KiB spatial coverage of one sweep
> is about 96 MiB, or 0.195% of that data set.
> 
> Using vaddr DAMON with a 500 ms sampling interval, 20 second aggregation
> interval, and 500--2000 regions, two opposite-order runs reported a mean hot
> ratio of 1.751% without shmem PMD mappings and 75.836% with them.  A control
> that writes the full 2 MiB ranges reported 75.366% with PMD mappings.  Hence,
> in this workload the current observation does not distinguish spatially sparse
> 4 KiB activity from dense activity once the large mappings are present.

The observation makes sense.  However, does the sparse access pattern
realistic?  If so, what is the purpose or expected benefit of using huge page
for workloads having such access pattern?

> 
> We are testing existing DAMON strategy mitigations first.  As a next step, we
> plan to replay recorded access addresses through the report/probe decision
> path, independently of a live PMU, and check whether DAMOS can distinguish the
> sparse and dense cases.  In that experiment, raw report frequency and unique
> 4 KiB spatial coverage will remain separate quantities; lack of reports will
> remain unknown when source coverage or loss is insufficient.
> 
> If the report evidence makes the decision reliable, the response we want to
> evaluate is an internal, bounded PMD mapping demotion (splitting the mapping
> while retaining the underlying THP folio), rather than exposing physical folio
> split as a DAMOS action.  We will first keep the response stat-only and archive
> the would-act ranges.  After the replay result is repeatable, we can replace
> the replay producer with an appropriate hardware source and share the results.

I'm not very sure if this is the right direction.  PMD mapping demotion sounds
like you just don't want to use huge pages.  If so, you could disable huge
pages.  Answers to my above questions would be helpful for me.

> 
> This seems like a useful consumer experiment for the report interface, even if
> the vaddr and optimized transport parts belong to the later phase.  Please let
> us know if this direction conflicts with the intended report semantics.

I believe this doesn't conflict with the project, though.  Nevertheless,
technically speaking, it is not the report semantics.  Reporting allows any
information to be reported.  Page faults like information could be coarse
grained, same to the current page table accessed-bit based one.  Only finer
grained access primitive reports, like those from perf events, would increase
the accuracy for the sparse access pattern monitoring.

Whether sparse access pattern is realistic and using huge pages on systems
having such access pattern makes sense are different questions, though.

> 
> We will share the strategy, replay, and mapping-decision results once they are
> repeatable.  We are also reviewing and testing this series, and will follow up
> with the appropriate tag(s) for the exact revision if that work justifies them.

Looking forward to!  Nonetheless, it would better to make sure we are on the
same page for the above questions before digging deeper, in my humble opinion.


Thanks,
SJ

[...]
