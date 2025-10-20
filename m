Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D37EEBA;
	Mon, 20 Oct 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972853; cv=none; b=j2wrbH0tSPYAhBqUlkivj/7R6p2hZ6+66DbP4gn5IBiLkKDqv5yyqioVSii6euNlSGJESwaMBojZqO01xSbkR5ApvZ8wkOAQ+90zS7ViVEGep+nNwGtEQYQ3quqDbptOPHpTQ489OISKLru6dcVGDrbE4LCbopsJxAgVXMDIaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972853; c=relaxed/simple;
	bh=bwQhCkgMC99Zv8LyOcM3w8mRBTrpsRR+wIqeIhD4C98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxlWUnZ5r2Asx32X6/52Al+Ad3l+mRHvuGjevZnzlsRqaYkBIrxBFEzLFMV+2HDa0L94KZSMuNnFJkkJ5HtPTwP7OwWN2s9IVDnzrYVq4Oa+3cmFeR5zaTNOmDf/4frMVjpH9O7UTaQtvWWe9wi1b2szq/VLyJl9nkrA8kchWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCTjzl4x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCTjzl4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FB3C4CEF9;
	Mon, 20 Oct 2025 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972853;
	bh=bwQhCkgMC99Zv8LyOcM3w8mRBTrpsRR+wIqeIhD4C98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCTjzl4xQQLSCh8BfOGlfloYGuPhOktRQn9TYbo7BRbisO/vuuEnbusYZxtHVts0S
	 Ap0LGagK2ejJlbWOt3zmBHsfNvJmwAJ1N1021RdYA8oh0TO4cvf094l2r+LYtuZlrk
	 Db+Mew64WEk7VQgTyAcldwPAXa4XInE7swqqVHm+hrhkNnbk6PiAjysjEV8AzWsMyq
	 45k9uGsnpbVx0JWgYrufPGtAnJ7f/o3R/bXyd6lX4uCIB3jQtk5yhEF+L6YAasSpT/
	 YpARKswuOiiqvqokaSHQrOEfwE9enhX+bqTNoLD2HT+jWJEEWLA0HHSVtZ5ID5Hj8V
	 JOjM4cgWAEHqQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH v2 2/2] mm/damon/reclaim: use min_sz_region for core address alignment when setting regions
Date: Mon, 20 Oct 2025 08:07:30 -0700
Message-ID: <20251020150731.45034-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020130125.2875164-3-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 21:01:25 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> When setting regions in DAMON_RECLAIM, DAMON_MIN_REGION will be applied
> as the core address alignment, and the monitoring target address ranges
> would be aligned on DAMON_MIN_REGION * addr_unit. When users 1) set
> addr_unit to a value larger than 1, and 2) set the monitoring target
> address range as not aligned on DAMON_MIN_REGION * addr_unit, it will
> cause DAMON_RECLAIM to operate on unexpectedly large physical address
> ranges.
> 
> For example, if the user sets the monitoring target address range to
> [4, 8) and addr_unit as 1024, the aimed monitoring target address range
> is [4 KiB, 8 KiB). Assuming DAMON_MIN_REGION is 4096, so resulting
> target address range will be [0, 4096) in the DAMON core layer address
> system, and [0, 4 MiB) in the physical address space, which is an
> unexpected range.
> 
> To fix the issue, use min_sz_region for core address alignment when
> setting regions.
> 
> Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
