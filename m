Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6663783AC;
	Mon, 27 Jul 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162374; cv=none; b=Lza4+m3aVTHLiugYednZDxmBaSs2Fdf9x1XmeaA1M8iBM1HCoMqFKZ+/VqrczBrBrQh9Z+Mw/Dw1onasltq2MQi9Pzq+al9ToqHHYPA4Fj5Zld8A3J7uBqdjE+ZWjVgfw2Qm7SPSXamdFX/6dglgVyFqJPj4zVRnx79ydAO9w4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162374; c=relaxed/simple;
	bh=KAZVAAcL8p4XYdZPRd8PTDREFkoJpz6DDka1flBl/ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEi6ZvF9ShAhEbNL9cqSZ2vbxTpcg2lnIsx+iltntOEYP+PSU8wbQH13SxYUyPbyc25SBJycmayGjDwsIJzm4vrDCvFh5zFRRkDUkVtf4Po6Deo1uJcGAGYjKEti622GS3e5/LiE8LOpoJV6h0LHtdP1ZTIB705Oya5pt0fZ6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCFTFoFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCFTFoFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9081F00A3A;
	Mon, 27 Jul 2026 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162372;
	bh=SSYcZBFPuC4PDoWkR8v2euqsjdGGE1vamaXLhHYCmrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCFTFoFBLMD9idxq2HbdTAda/SlM8MutA1Intqy1oP0WrRvrjXO3eR4WCDpv0VOb8
	 7r1iYGpdhEstIu25vsbXS0FBiNRcpHAflnWXZAMWwbAPS75aD+eNMa9ycWuXF2drvm
	 Rzw+SIsGelKwLS6NGckfBPV55mEf9R4LinYPOLGM1A4CwHtjGRvr1cpQMD5k/7CIyZ
	 O2aEWUkEgGqL7nMMwvLZs/lL+Uhqan4iwYUokSOFe7in16GXHl4I5b2CItB9Y3GvoK
	 s/r8bQgnX/UZrfxpxhrpNWkDodb4N82p9c8NEPiYKQavi7i8OPjlg2jfMvkdfDPEyK
	 WILqzK9iMFT/g==
From: SJ Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas with per-range regions
Date: Mon, 27 Jul 2026 07:26:03 -0700
Message-ID: <20260727142604.85548-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727095429.143527-1-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jiayuan,

On Mon, 27 Jul 2026 17:54:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> damon_set_region_system_rams_default(), introduced by commit 70d8797c15d6
> ("mm/damon: introduce damon_set_region_system_rams_default()"), is used by
> DAMON_RECLAIM, DAMON_LRU_SORT and DAMON_STAT to set the default monitoring
> target address range covering all 'System RAM' when the user does not
> specify a range.  It walks the 'System RAM' resources but keeps only the
> start of the first resource and the end of the last one, and then sets a
> single monitoring region spanning that whole [first_start, last_end] range.
> 
> On systems whose RAM is split into discrete areas that are far apart in the
> physical address space, that single region also covers the holes between
> them.  For example:
> 
>   $ sudo cat /proc/iomem | grep RAM
>   00001000-0009ffff : System RAM
>   00100000-4848c017 : System RAM
>   4848c018-48550c57 : System RAM
>   48550c58-48551017 : System RAM
>   48551018-48615c57 : System RAM
>   48615c58-48616017 : System RAM
>   48616018-486dac57 : System RAM
>   486dac58-4e563017 : System RAM
>   4e563018-4e627c57 : System RAM
>   4e627c58-4ef39017 : System RAM
>   4ef39018-4ef3f057 : System RAM
>   4ef3f058-4efe6017 : System RAM
>   4efe6018-4efec057 : System RAM
>   4efec058-50247fff : System RAM
>   50317000-56720fff : System RAM
>   56722000-59c19fff : System RAM
>   6bbfe000-6bbfefff : System RAM
>   6bc00000-777fffff : System RAM
>   100000000-1007effffff : System RAM
>   67e80000000-77e7fffffff : System RAM
> 
> Here the last two areas (about 1TB starting at 4GiB, and about 1.1TB
> starting at ~6.5TB) are separated by a ~5.5TB hole, and the single-region
> setup makes DAMON treat that entire hole as if it were memory.
> 
> This is harmful in a few ways.  The monitoring target regions are limited
> by max_nr_regions, so regions that fall into the hole waste that budget and
> leave fewer regions for the real RAM, coarsening the adaptive regions and
> degrading the monitoring accuracy.

The hole would look like not accessed.  As a result, the whole region will be a
few regions that very cold.  That wouldn't waste the budget that much.  Do you
have some specific setups that this cannot help?

> In addition, DAMOS actions on the paddr
> operations set walk such a region page by page, so a region that covers the
> hole is walked for its entire (empty) span on every application.

That makes sense.

> 
> Set a separate monitoring region for each discrete System RAM area instead,
> coalescing only truly adjacent (no gap in between) resources into one
> range, so holes between the areas are excluded.  The reported *start and
> *end still carry the overall first-start and last-end, so the user-visible
> default range reported via the module parameters is unchanged.

I'm concerned if this could result in having too many regions.  The gap between
user-visible parameters and internal state is also a concern.

A quick workaround would be adjusting the memory layout in BIOS, using DAMON
sysfs interface instead, or setting the monitor_region_{start,end} to cover
only the single area.  Have you considered such workarounds?

Let's complete this high level discussion first.


Thanks,
SJ

[...]
