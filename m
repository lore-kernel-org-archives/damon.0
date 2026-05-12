Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349E13635E
	for <damon@lists.linux.dev>; Tue, 12 May 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549480; cv=none; b=LaPf3Fp5ZHro5/KzoIKMC0smKElVff2naJEPVyIAcKPCYPG76vHmIdZAdKZzKCVZHXVV72X1OM+JMYebuRAjLnqSSvX9IY+lsYLKuMiXkea8kSQfeublrkeCqlhVTc5em2SHH7GVZCtjd40GqlCtiwgomhGj9EEHyrzvZU1T6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549480; c=relaxed/simple;
	bh=LwUaYMXJHdUhH6+TL9aRCB1P0uKI2mUXjW0mb49u3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Njgd47dRl6qfefbvc4L/+qd3tq80g1I1AiO74W6IonKo+sRxPYymxmvGuvS6dWcRrqMHl6FuXR8L9dJEhFwrCh/6f0QYiHo8s4zJjF0SkxVFHIPkOKrbsyBEoBi4exnTTRmC7Bn7amUmZH5G7InrlDknSbexW0dn+tUfsmy2bbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUFTzikz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUFTzikz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5664DC2BCB0;
	Tue, 12 May 2026 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778549479;
	bh=LwUaYMXJHdUhH6+TL9aRCB1P0uKI2mUXjW0mb49u3oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUFTzikzItrtUlko3n6C3LvCjx/JvnCMWkKLdlem/PpTyZE/FGS+Nq2o5AY3rDAaa
	 NgBo0S5Ih821wBlAQ5L4oaL5YIDF1i6kg4l2I/3K1EDCatj7I95X6A/FAo2ubM3hoH
	 CbD/zhbR7PNelKLBIPEFyzZ8Rgylqp0pK+eTMB768ZxsTNRDM9pubG2GRDg6d9juRP
	 IhZmXgQDFj4ojcYW1b68Z7OBPjVZ5fNKM//OTGpvLcRWVkScwvFxVJ7SR/A+vqKA67
	 B1n8xt2jxqKbMtUYsOhRjeFjcivub1YFVotx3p8udVAqMOLeR66IuhxYW7nDYShuSu
	 KpeJ2ZZvtoZAg==
From: SeongJae Park <sj@kernel.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sunnanyong@huawei.com
Subject: Re: [PATCH] mm/damon/vaddr: attempt per-vma lock during page table walk
Date: Mon, 11 May 2026 18:31:15 -0700
Message-ID: <20260512013116.80435-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511132546.1973270-1-wangkefeng.wang@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 May 2026 21:25:46 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

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

Makes sense.  Do you have some measurements?

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Looks good to me.  Nonetheless, because I'm not familiar with per-vma locking,
I'd like to wait for Sashiko review.


Thanks,
SJ

[...]
