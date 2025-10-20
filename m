Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536E56B81;
	Mon, 20 Oct 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972788; cv=none; b=d91ZbCWwLMGh7ieHAMnAkqGAk1iSMlhkQPf4FqxkAd+mexM1+KSkRgdzctA0ML8Qt4e5KKpEkcsV2IGDHpfc2qidG28nOXnvic9V9i7JXkshI5uQXxVOUsiGhE/382YzeyDx+AnsmhL0JE+zCYlH7nnDjfftgVvRIy9eDS3pPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972788; c=relaxed/simple;
	bh=Jx+0bHoZRra68oiIu/Fb1T1NX9AirIX/qKXZ/176/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcGuCbPhVY1ZTyIpWhkuzL7xJq96YFqyF7+comNmKUpw00VHq5wSP2be4dreP0EIoHD5YWMgqrzxtaGLNfQWE6fUqXb6Y/mVG/+roUhb5Gyh4I1meT170wum2FjX4D+ER0kfgJd9NvWNOPpUk3kLsgmYVUAnD+pA7PLqUDa9Zv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZdcZcDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZdcZcDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC2EC4CEF9;
	Mon, 20 Oct 2025 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972788;
	bh=Jx+0bHoZRra68oiIu/Fb1T1NX9AirIX/qKXZ/176/eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZdcZcDBryJILGpdBSHUtPft7MCimeWMPyB0O+afFG7JVBbqrnkXhvMI12vtYWiFA
	 NAsGpNr5s45X6ortFiSnLfngd58KVOInHf2GHjurEgfx1c9pB7bUr5W754Vl1pJFIk
	 p9cFAxiyFRqhXAPnPNfWoTzdyhOJsTo94VkSV6U9zOy+7QLCTTYXEbKmJuD6YTypwv
	 fWrfYol2ndYIeWcWvjtP/BTgazY1luJhuCfoKnguZGmjjmNp2U2GFHKBlgsUfZypbn
	 lzp/sMEgkyjck01zD+xHEvKjydSAVpYCAjGHEVdF8C5gzTjyTgokiRPQ3JYw9wbpmw
	 Gydx1eD2T+9qw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH v2 0/2] mm/damon: fixes for address alignment issues in DAMON_LRU_SORT and DAMON_RECLAIM
Date: Mon, 20 Oct 2025 08:06:25 -0700
Message-ID: <20251020150625.34941-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020130125.2875164-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 21:01:23 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> In DAMON_LRU_SORT and DAMON_RECLAIM, damon_set_regions() will apply
> DAMON_MIN_REGION as the core address alignment, and the monitoring
> target address ranges would be aligned on DAMON_MIN_REGION * addr_unit.
> When users 1) set addr_unit to a value larger than 1, and 2) set the
> monitoring target address range as not aligned on DAMON_MIN_REGION *
> addr_unit, it will cause DAMON_LRU_SORT and DAMON_RECLAIM to operate
> on unexpectedly large physical address ranges.
> 
> For example, if the user sets the monitoring target address range to
> [4, 8) and addr_unit as 1024, the aimed monitoring target address range
> is [4 KiB, 8 KiB). Assuming DAMON_MIN_REGION is 4096, so resulting
> target address range will be [0, 4096) in the DAMON core layer address
> system, and [0, 4 MiB) in the physical address space, which is an
> unexpected range.
> 
> To fix the issue, add a min_sz_region parameter to
> damon_set_region_biggest_system_ram_default() and use it when calling
> damon_set_regions(), replacing the direct use of DAMON_MIN_REGION.
> 
> Changes from v1
> (https://lore.kernel.org/all/20251016104717.2194909-1-yanquanmin1@huawei.com/)
> - Added more issue description in the commit message.
> - Split the original fix patch into two separate patches.

Thank you for nicely revising this!


Thanks,
SJ

[...]
