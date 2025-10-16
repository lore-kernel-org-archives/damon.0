Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70F1A9F83;
	Thu, 16 Oct 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644140; cv=none; b=O04ob7o6gnE6k2/panmmgS7qXZySwDVoMhe2R02bxbQQ4mjKeDwA+mFFimKV3ZkXHtLq4uItcMyuk/zna6s4PTGjJefReCnTC+I7pZvwIOsWCmEUAbkAJ5C8eg6MD/bVmsd/AoaIk1X25LcaoZyDj4hH5QYQ22ykmWbZG9xtfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644140; c=relaxed/simple;
	bh=iWpeYViYVT9Q3c2NgGbuKH0/3JN3NmmA/uSOtQHdCBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecZe893T6ERsG+1Ijn6iQjIGKpaeuCZ+4K/b0emgfPcFae14vIPKaPX+CeM19mFXnYF3rq54zVlwj55tsvHxsx8vxUahlokIvh5RIo33sLfmmQYZRw8PE0R4gyd6uGzwksYNkLPAQ3mbMcpKmYadwwPXQxk82v5bB/0kw4zBQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEUHIbNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEUHIbNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A638C4CEF1;
	Thu, 16 Oct 2025 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760644139;
	bh=iWpeYViYVT9Q3c2NgGbuKH0/3JN3NmmA/uSOtQHdCBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEUHIbNzVacKEiIWE3We6lJnjqsAO2iEPZyWGmwRfasxmn2EEiqxpCGfYxsBecrMp
	 nnOEZLjFdAzwPFNArr6FPy7H0mi+m7yURLGxbEx1fQG7gaK0L3i/pPdKAZFk/Z4rtQ
	 HKpmlTsTh5vIk3mEklgcyzNgydLmZp/kQ7LEjtNj7WXANxBbrM1jVFzfmEWVcTUh3w
	 uRswj1U6SCfqKAq3GXF0lBHAUT8ltxMjGJtCEoXYYzDH6NOUSAt/Pa/5IH6bccrO5A
	 HFyKMD36Xn4S3ocVjN1HL1UGu+CI039D1c3XLAQ0q8CfYOdI4w4wfQzyEhKnPHCZu4
	 rj8P8ntWDkbWw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH] mm/damon: add a min_sz_region parameter to damon_set_region_biggest_system_ram_default()
Date: Thu, 16 Oct 2025 12:48:50 -0700
Message-ID: <20251016194851.65981-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016104717.2194909-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Oct 2025 18:47:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> After adding addr_unit support for DAMON_LRU_SORT and DAMON_RECLAIM,
> the related region setup now requires alignment based on min_sz_region.
> 
> Add min_sz_region to damon_set_region_biggest_system_ram_default()
> and use it when calling damon_set_regions(), replacing the previously
> hardcoded DAMON_MIN_REGION.

Can we add more detailed description of the end user issue on the commit
message?  My understanding of the issue is that the monitoring target address
ranges for DAMON_LRU_SORT and DAMON_RECLAIM would be aligned on
DAMON_MIN_REGION * addr_unit.

For example, if user sets the monitoring target address range as [4, 8) and
addr_unit as 1024, the aimed monitoring target address range is [4 KiB, 8 KiB).
But damon_set_regions() will apply DAMON_MIN_REGION as the core address
alignment.  Assuming DAMON_MIN_REGION is 4096, so resulting target address
range will be [0, 4096) in the DAMON core layer address system, and [0, 4 MiB)
in the physical address space.

So the end user effect is that DAMON_LRU_SORT and DAMON_RECLAIM could work for
unexpectedly large physical address ranges, when they 1) set addr_unit to a
value larger than 1, and 2) set the monitoring target address range as not
aligned in 4096*addr_unit.

Let me know if I'm misunderstanding something.

Also, if you encountered the issue in a real or a realistic use case, adding
that on the commit message together would be very helpful.

> 
> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
> Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")

Let's break this patch into two patches, so that we have one fix per broken
commit.

> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
> ---
>  include/linux/damon.h | 3 ++-
>  mm/damon/core.c       | 6 ++++--
>  mm/damon/lru_sort.c   | 3 ++-
>  mm/damon/reclaim.c    | 3 ++-
>  mm/damon/stat.c       | 3 ++-
>  5 files changed, 12 insertions(+), 6 deletions(-)

The code change looks good to me.


Thanks,
SJ
