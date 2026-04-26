Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234C2264A7;
	Sun, 26 Apr 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777224834; cv=none; b=HbtDdnUFsJes18Q+Y8IO85lXOVarQVCvlpyJhn2N/BALfTKFUq5qO35nPUjQ7xXAn2uNSlRshgA+ZGQusvVcAu5XFfFzPCdDBd43irVcDh3yZKMvPx+BCNNPDXjGBL6pQHTKpBlokiDLc1Oypnhf6yRZr2igWv43EtQ74fqjoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777224834; c=relaxed/simple;
	bh=NyTBE653KUBU75B1Vw+ooRQPZJEKpc65dpXTTl/wexw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxF0LRF9jfRiF2/3MbQBo0VG//HwMXqPQhKV3H/0Z9jVmuo7fmfckooUBATpAI22qZztFdftQhAShaVOdu3/hpXsihU98qapUK3RVA8GvxJvw5x6hvzGv4xABSsp8wyrzuylxKn4oYNcyvRawgWLMNaBunwHETUXmwqmtpqlK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muNEjNIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muNEjNIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B48FC2BCAF;
	Sun, 26 Apr 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777224833;
	bh=NyTBE653KUBU75B1Vw+ooRQPZJEKpc65dpXTTl/wexw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muNEjNIn9bmjunSTmqEoWZ4JkfJ/h02Zn/c9cR8jvok9bIl5vFicBPprhkCdMm/Bc
	 GvRlyYtvl/Vs94USjM+3iRff/FILL1R3tBPquAiPjw8Q+azsH9ZZL2ttcfwssleBRy
	 iS1vE5pQY9pqSACHwsgWDKUdfoRceLFSoyEzRiQTOUEMZayNB8sQJdT/3siGEsFZo7
	 ZEyuz/v1wzF0oq1+2Z24l3X0NO4p/nXhNpCcO0T9z2mnl7xeFFpS31aSbN93G503gZ
	 ODra5De9gCAL8jUU4lqrcxEtmUcIkVoqA8gmuGCOr3GBVYJsW+us2+4aEoG9DV/fbW
	 h5sQtuOEu8TJw==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon: introduce damon_rand_fast() for per-ctx PRNG
Date: Sun, 26 Apr 2026 10:33:45 -0700
Message-ID: <20260426173346.86238-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <afcbb502-b91e-47d7-8fb7-2e4e237928c5@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 13:50:42 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> 
> Hello SJ
> 
> Thanks.
> 
> On 4/25/26 11:59 PM, SeongJae Park wrote:
> > On Sat, 25 Apr 2026 11:36:02 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >
> >> On 4/24/26 11:11 PM, SeongJae Park wrote:
> [...]
> >> With ~2 GiB
> >> default regions on a 2 TiB host, a small pod's pages are averaged
> >> with thousands of non-pod pages in the same region, and the
> >> region never reaches nr_accesses=0 even when the pod is genuinely
> >> idle.
> > But, the adaptive regions adjustment mechanism dynamically change size of
> > regions, down to 4 KiB.  If the small pod's page is really cold while its
> > surrounding pages are not, DAMON should down-size the region to capture only
> > the page and show you nr_accesses=0.
> >
> 
> Looking at kdamond_split_regions() / kdamond_merge_regions():
> the per-region floor is 4 KiB, but the *total* count is
> hard-capped at max_nr_regions, and split itself is blind --
> it picks the cut position via damon_rand(1, 10) without looking
> at access patterns.  What keeps a split in place is the next
> merge cycle finding the two halves have visibly different
> nr_accesses; if a small cgroup's signal is averaged with
> surrounding host pages on both sides of the random cut, the
> halves look identical and merge folds them back.  For a 1%
> cgroup on a 2 TiB host with max_nr_regions=1000, the
> split-merge loop never converges to cgroup-aligned regions --
> random cuts almost always land in "99% host + 1% cgroup"
> mixtures.  Raising the cap gives the random splitter enough
> attempts that some cuts happen to land on physically-clustered
> cgroup pages (THP, NUMA-local allocations) and stick.  That's
> why the cap matters in practice, not the 4 KiB floor.

Theoretically, you are rigt.  But the size of the impact would depend on the
workload.

In my previous testing on 1 TiB memory machine that was running a real world
workload, DAMON was able to find 4 KiB cold pages.

Is this somewhat observed on your products?

> 
> >> The cold signal is gone before any cgroup attribution
> >> happens.  Cgroup attribution itself is done at sample granularity
> >> (folio_memcg per sampled page), not at region granularity -- the
> >> regions just need to be fine enough that there *is* a cold signal
> >> to attribute.
> > Could you please share more details about what is the cgroup attribution, and
> > how it is done?  I guess that is the way to map DAMON's monitoring regions to
> > each cgroup to determine if each cgroup is hot or cold.  I'm unsure how it is
> > really be done.
> 
> 
> We sample physical pages within DAMON regions, look up
> folio_memcg() per sampled page to find the owning memcg, and
> accumulate cold bytes per memcg.  Userspace reads the per-cgroup
> result and sizes memory.reclaim per pod.  Conceptually similar
> to the page-level monitoring you pointed me at -- we'll evaluate
> whether [1] / [2] can replace this path.

Thank you for sharing this.  That all make sense.  I also hope the existing and
planned cgroup-aware monitoring will help your use case!

FYI, I removed [1] and [2] in my previous reply, so pasting those here again,
for other readers of this mail.

[1] https://lkml.kernel.org/r/20250303221726.484227-1-sj@kernel.org
[2] https://lore.kernel.org/20260423190841.821E4C2BCAF@smtp.kernel.org

[...]
> >>> So I think this patch is ok to be merged as is (after addressing my nit trivial
> >>> comments about coding styles), but we may still want to fix it in future.  So I
> >> damon_rand() is now only called by damon_split_regions_of() with
> >> the constant range (1, 10).  may by we can rename it to
> >> damon_rand_u32() to make the u32 constraint explicit in the API
> >> name; that closes out the truncation concern at the legacy helper
> >> without needing a separate series.
> > Good point.  I'm wondering if we have a reason to keep using damon_rand() at
> > all.  I find no such reason.  If you also find no real reason, how about simply
> > removing existing damon_rand() and renaming damon_rand_fast() to damon_rand()?
> >
> 
> Good idea.  v2 will remove the legacy helper, rename
> damon_rand_fast() to damon_rand(), and plumb ctx into
> damon_split_regions_of() for the new signature.

Sounds good, looking forward to v2!


Thanks,
SJ

[...]
