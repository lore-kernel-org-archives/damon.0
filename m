Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724A35B65D;
	Wed, 22 Jul 2026 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727933; cv=none; b=sAZ6t/a7yTFWhURGUNyv6Hl35cJc/8O1oUPHWrIlRwhT7I7EKQKM0qMqpkt2Ib8ymXjEcsqC6+g10iwRKhoa2pbEFu7Yk+1mXueexnjjhsI2LoPbuxEcm/lWdT6Em1oMqn/eZ0rSrPIHdpanVvKucYqZoAJfeq5XluEVffVASgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727933; c=relaxed/simple;
	bh=VR9o9rnHA9tLUmx8Ek/FGAtfuBBHpAeGbbG2t0LFiM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo1x9BNpOdgyX2Nxjbgk7ccw3izhClMvGC3ks3QJqSiuRF2dQZpa70zQFDWTbqhu7OWDi4CB5MFnUMNbbTkSo67/mopKdLA67ZYCbYYPEt9+QrSc5YzvK4YxY+q4/yIaXX+0SkSWHmRr9rl7Fj6qxiTJTogsUdLd+R5u7ZNw3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJWegH0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJWegH0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5AD1F00ADB;
	Wed, 22 Jul 2026 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727931;
	bh=W3vYwSW4UujfgSMcU5g5Qb19b6BNp6jfqJHAfwMNJHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJWegH0/RLjcksN2vqderqOYhQ9eWMrvzDt5295YLB/S3X3EZ0v380dfSamggSPEG
	 TVP7s8UFmheAbEgBv9yaFV3OuTn9uUQcIe8KAIZW0KXPGhpE+cjXlMt/9FdUdjm9XZ
	 agBD6Rh8Ady3BBoT0diaBBbNtQ/bjZcDOrsc6V0y9No+2M94lnhkApJ1GzclAF7rem
	 js395LCWqzwq/SfBRYcnE8qI/fQ9/WZxTx7Wc99Lou97N1TRsFDADph+Gpmpocyd9d
	 7W4dbQ+eiHFeDQQZBIVJmQ4clllbMPu1NnVLx9dfs8+qnk6H4HAx6kllqK61GZ+PlK
	 AN17LF64p95bQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: gutierrez.asier@huawei-partners.com,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Wed, 22 Jul 2026 06:45:22 -0700
Message-ID: <20260722134523.87856-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721035848.147455-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Jul 2026 20:58:47 -0700 SJ Park <sj@kernel.org> wrote:

> Hello Asier,
> 
> On Mon, 20 Jul 2026 12:01:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:
> 
> > From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> > 
> > Overview
> > ========
> > This patch set introduces a new autotuning which allows to collapse
> > hot regions into hugepages.
> 
> Thank you for making this series well done like this!
> 
> [...]
> > Patches Sequence
> > ================
> > Patch 1 -> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP and autotuning
> > Patch 2 -> sysfs support for the new quota goal
> > Patch 3 -> Document hugepage_mem_bp parameter
> 
> I'd prefer handling 'total' underflow and returning 10,000 instead of INT_MAX
> from damos_hugepage_mem_bp() corner cases.  But definitely that is no blocker.
> For the series,
> 
> Reviewed-by: SJ Park <sj@kernel.org>
> 
> This series is applied to damon/next [1] tree.  If this series is not added to
> mm.git in short term (~3 days?), I will ask mm.git maintainer (Andrew Morton)
> to pick this.  In the case, I will update patch 1 to do what I mentioned as
> preferred change if you don't mind.  So, no action from your side is needed for
> now.  If it seems I also forgot doing that or you cannot wait for my action,
> please feel free to directly ask that to Andrew.

We (mm community) now want to focus on making mm.git more stabilized and
therefore ready for the next merge window, rather than adding more changes that
are not really urgent.  I agree and want to help [1] that.  For the reason,
unless Andre pick this first, I will request adding this to mm.git only after
next -rc1 release.  Let me know if you think this is really urgent.

[1] https://lore.kernel.org/20260722133829.87607-1-sj@kernel.org


Thanks,
SJ

[...]
