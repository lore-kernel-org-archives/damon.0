Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657117736
	for <damon@lists.linux.dev>; Thu, 14 May 2026 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724067; cv=none; b=H0W7eUdHQReuKX2q9Ldf9ttJvSZJel2GNXeuBQWXuzUtt5rQwMQwGd+vIjf7lHasPQ/PXUhW7e5v+/1Vllwa9Kh5RxyCbxAKcgZ/0NzxjDfh2sQzgVLFRDkaDU9WDK/6ZU8GcpFIpHIDJ9i1ze8YgQTQgIcrCRzmfm1nscLJ9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724067; c=relaxed/simple;
	bh=PVPkU3ne7pVBIY+H4ldRtFU0h2eXvyRq9QB2pPm3898=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGnrvYjxYXuINgyMi4WSIu1T4BQvaiyn+NtKoM/YMkB6aEWzwPMUcwKEDdiS09reZyWnZpsCdBOA6TrdDiMNVhE1LzHP/Gab/UtNiwU8ckZ9nb07IfxgOJobVdq5zRLdm/wHmiWof6o3cc/+G7vC3GbsUxmWzYQmI64DR3kGX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUTMkvAk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUTMkvAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4CBC19425;
	Thu, 14 May 2026 02:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724067;
	bh=PVPkU3ne7pVBIY+H4ldRtFU0h2eXvyRq9QB2pPm3898=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUTMkvAkpNWwVjP1QFFbLfKc2TIJxLZJTkFQ4CsNt8ZPIzoQIsvzERPUuIfHudzKc
	 JLk+T8i9wQGmSBCNhHM6GSWZihh6JU/g7OeBlHm9dJJ9YBVaI/nvZA1oKqFAXIR1Fq
	 Xmb0h0hrxlyzJQP+LmvFzu1nMUVKxVys1qo+QR03joB68UU1ICbAohRy+cC+jXwMWV
	 UlyWh5XMjgWf3d9XPv+2bljVkf1g/vAE2q4EPsVJabNH0/ZTX26+b8GPGwoYCCNYBJ
	 cy3Lwt++lbCFiMq3nOaSaDGrUQuHIYrLmSZkBcN2V5O/ZLlNCsxz0VAwC9LVr2TI3U
	 xOSXwe7ntqerw==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sunnanyong@huawei.com
Subject: Re: [PATCH v2] mm/damon/vaddr: attempt per-vma lock during page table walk
Date: Wed, 13 May 2026 19:00:58 -0700
Message-ID: <20260514020059.149541-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512151523.2092638-1-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 May 2026 23:15:23 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Currently, DAMON virtual address operations use mmap_read_lock
> during page table walks, which can cause unnecessary contention
> under high concurrency.
> 
> Introduce damon_va_walk_page_range() to first attempt acquiring a
> per-vma lock. If the VMA is found and the range is fully contained
> within it, the page table walk proceeds with the per-vma lock
> instead of mmap_read_lock.
> 
> This optimization is particularly effective for damon_va_young()
> and damon_va_mkold(), which are frequently called and typically
> operate within a single VMA.

Maybe this is not only making DAMON faster, but avoid DAMON blocking others.

And because we don't have performance measurements, how about making this
sentence less assertive?  E.g., "This optimization is particularly expected to
be effective for ..."

I guess Andrew could make the adjustment when he picks this into mm.git.  If
not I will repost this with the trivial change if you don't mind.

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> v2: avoid handling VMAs with the VM_PFNMAP for per-vma path, found by
>     Sashiko review.

This patch helped Sashiko finding [1] yet another DAMON bug (impact is minor
imho).  The bug is orthogonal to this patch so there is no blocker for this
patch.

> v1: https://lore.kernel.org/linux-mm/20260511132546.1973270-1-wangkefeng.wang@huawei.com/

[1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org


Thanks,
SJ

[...]
