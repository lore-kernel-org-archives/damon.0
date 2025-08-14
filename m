Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BF2FF66B;
	Thu, 14 Aug 2025 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133062; cv=none; b=GOWg7U/mxG5hWn2adVe0LwqRf05s1xYZ0I+9+TCjL7E7rMRBMkO+XnyIsC4Zba+MS6b10nDUnESnJXX9qReuMSotT0qChGtFOONIiqIJHTwQqlpvX9Rq8YCqY3rkZMFxWRvoBjjIliuE/ccK1aFH+kipzzxFSvcFLIlHdHqkNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133062; c=relaxed/simple;
	bh=153zhUSGq/KWvkkdlqL7wLh94pOu0kTwnsKJAuOqD14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LKX1n7PrvWmFvm2TN/fvZDIxOLUc8exbZiBVkS/t3bkoG3s6IsOiJ+lIz9BLzVrt5BkI1EfHZfOVzx7TOSZq2v0Dr7ZfCfymDi2FYX+xgrcTg36RYkN1VzcgDrByRSMIma4WnzwRTqiLQ4bhXNn5qg+8P293+TqmDK9NBgh5kdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOcl/GGf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOcl/GGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EE4C4CEED;
	Thu, 14 Aug 2025 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755133061;
	bh=153zhUSGq/KWvkkdlqL7wLh94pOu0kTwnsKJAuOqD14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOcl/GGfHB4GpoAi6OiNe1lLxxd54T5fSjtzKKYyxnjje7GHL0MsHp/TYCJAB1XG+
	 QrZULcM+dWWj8pjXjiFwjTwmz4rfV/Duu4mrxP2+zauPGCN7TvrsK8iDYMynrGDYX9
	 wQ8vbSH4TFObnopKdvw/XE3rAaZ1N4cY0z53bdK+lpDtHbD6L5T4kyxEmqxJzXK9Cw
	 agUIel/yCiDCoa/nskdheQjzD74m8i+MUS3oRbwInZby0C8WFzTcm4/AgUDmrWUQ8M
	 6doSFc7I0n2F2gCu5r3CVbaBdxJW78ojMSsHtj/cCwoCFfZfMI8VF5GbHx+sZhVVEq
	 YEk2OQR/xJ70Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 00/16] mm/damon: support ARM32 with LPAE
Date: Wed, 13 Aug 2025 17:57:38 -0700
Message-Id: <20250814005738.52844-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813172545.6637-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 10:25:44 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello Quanmin,
> 
> On Wed, 13 Aug 2025 13:06:50 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> 
> > Previously, DAMON's physical address space monitoring only supported
> > memory ranges below 4GB on LPAE-enabled systems. This was due to
> > the use of 'unsigned long' in 'struct damon_addr_range', which is
> > 32-bit on ARM32 even with LPAE enabled.
> > 
> > Implements DAMON compatibility for ARM32 with LPAE enabled.
> 
> Thank you for working on this, Quanmin!
> 
> > 
> > Patches 01/16 through 10/16 are from the mailing list[1], add a new core
> > layer parameter called 'addr_unit'. Operations set layer can translate a
> > core layer address to the real address by multiplying the parameter value
> > to the core layer address.
> > 
> > Patches 11/16 through 14/16 extend and complement patches 01~10, addressing
> > various issues introduced by the addr_unit implementation.
> > 
> > Patches 15/16 and 16/16 complete native DAMON support for 32-bit systems.
> 
> Overall, looks good to me.  I have a few change requests including below major
> ones, though.
> 
> First, let's squash patches for fixing problems made with patches 1-10 into
> patches 1-10.  If you don't mind, I will post RFC v2 of those so that you can
> pick into your series.
> 
> Second, let's keep DAMOS stats in 'unsigned long' type.  This require fixups of
> patches 1-10.  If you don't mind, I will also do this in RFC v2 of those.

Instead of posting completely new RFC v2 of the ten patches, I think posting
fixup patches as replies to this thread might be a better approach.  I will
make fixups first, see what looks easier for working together with you, and
either post entirely new version of the patch series, or send individual fixups
as replies to each patch of this thread.

And one more questions.  What is the baseline if this series?  I cannot simply
apply these patches on mm-unstable or mm-new.  It would be nice if you could
share a git tree having these patches fully applied, since 'cherry-pick' is
easier than 'am' for me.


Thanks,
SJ

[...]
