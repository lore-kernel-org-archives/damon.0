Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40351CCEE0;
	Wed, 20 Aug 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719844; cv=none; b=K6QsMr9hAZKH/LdP+SkcHMWXaVwxUhkrm4tqqow/XTRmcdn1xla0/NKFZKmXcQ7d047z/v1q3uV2QK9HukEiQyPI2vu97rRkLwaWXGpzWBX6Ihsqkx+0NbVWSjfU6vvxUZeh/tt2IzbjumeOmz9PwSx5pzghlf8dT/zXTliEqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719844; c=relaxed/simple;
	bh=/7toDdEpBhsQBqYTyTJdjzxa4ZHZpXy/zoIFE07ExQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDr/E2M+9GIF9DDqBgusaEpymM8xswFLPTtq8Uj3x5+d+qr0rwUc5NZ8XanR4Jxj7Y3/bQI/Zbf/zaE/ZhfYgcR4RnVAIWZpVFRipgIFT4oEHVPNtlT5y7GtLDaL1Y3cuc4SgrcnCCWiDExMUgInZGph6UqPfFypwM8nYM048pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpYq/SIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpYq/SIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20FEC116C6;
	Wed, 20 Aug 2025 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755719844;
	bh=/7toDdEpBhsQBqYTyTJdjzxa4ZHZpXy/zoIFE07ExQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpYq/SIjO/qimCxn4qbvlE0wka6mshMcGxyb0WLRSHJug0/GgX4ZHUfnuJ9+KhyBL
	 JD+GCx3fT7NvlIwTKnJxISRbKR78JtCEux8juij0Zy3Wv/3LmLB/AZ7wu2IWbl8T1M
	 nQSc1xKSYkpS0eeUAX9CKuYnE3PYSY8FI7Pofn19zhEu03j/B+MVs2dSAQn8vutnvX
	 hofsbROuKU4qjNe07s3alWNWmxtUaRxXg1qJcKhHK2XCaabMFLqiK8CiApPT6gQNOO
	 GqGJ5HYWZ9cITpvD9VGmo+xtLLevgKyOyhX6p/wdJK1ciW+z2NJ9YwQw7GNwGvH08G
	 NY5oGp0Hy1Urg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 15/16] mm/damon: the byte statistics data type in damos_stat uses unsigned long long
Date: Wed, 20 Aug 2025 12:57:21 -0700
Message-Id: <20250820195721.85577-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <3b5a37a7-af37-4108-a0c5-bc147bb77842@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 17:54:32 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Hi SJ,
> 
> 在 2025/8/14 1:10, SeongJae Park 写道:
> > On Wed, 13 Aug 2025 13:07:05 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> >
> >> For 32-bit systems, damos_stat now uses unsigned long long for byte
> >> statistics data to avoid integer overflow risks inherent in the
> >> previous design.
> > I suggested using the core-layer address unit on stat, and ask users to
> > multiply the addr_unit value to stat values if they want bytes value.  If we
> > agree on it, I think this patch wouldn't really be required.
> 
> Thank you for the guidance, I agree with your perspective. However, this patch doesn't actually belong in the addr_unit series, my apologies
> for the confusion. It is actually intended to address potential overflow issues
> in statistical data on 32-bit systems, and it is not directly related to addr_unit.
> This patch has been dropped from the v2 series.
> 
> After introducing addr_unit, if it is set to a larger value, it can help mitigate
> the overflow issue. However, under the default setting of addr_unit=1, statistical
> data may still overflow after a sufficiently long runtime, for example, when sz_tried
> exceeds 4GB.

Thank you for clarifying this!  My opinion is that, since we use core-layer
address unit for DAMOS stats, as long as users set appropriate addr_unit, I
think the overflow wouldn't really happen in real problematic ways?

For example, if addr_unit is 2**10 (=1024) and the scheme has tried to 4 *
2**30 bytes (4 GiB) of region, the sz_tried value will be 4 * 2**20, so far
from overflowing.

I think still the chance to overflow is higher than 64bit, but maybe the user
space tools can monitor and handle the overflow...?  Maybe we can discuss
further, but let's focus on the essential part for now.

> 
> Besides, please allow me to mention one point in advance: if addr is extended for
> use in modules(e.g. DAMON_RECLAIM, LRU_SORT) in the future, the term "bytes" in
> module_param_named(bytes_##try_name...), although multiplied by addr would yield
> the actual byte count, might cause confusion due to its seemingly direct naming.

Thank you for heasdup!  I agree it could be confusing, but I have no real good
idea at the moment, sorry.  Let's revisit after the essential part work is
done.

> 
> Overall, this patch isn’t critically important at the moment, nor does it offer a
> sufficiently robust solution, but I’d still appreciate hearing your perspective on
> the matter — I’m all ears.

Thank you again for headsup of the remaining issues.  Yes, let's keep eyes and
revisit those later.


Thanks,
SJ
