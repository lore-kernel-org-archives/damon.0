Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6723D7CF;
	Mon, 20 Oct 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972821; cv=none; b=GCk/LEyVVupLfvmA9qaQWm7lIKvgXdbWWP5+o8SmJyXmlAmFH3vdLOOzU+UgoX1WVJOmNQXQxktb6+bJ6FFvGzI1Rf8wdhwYFJr3hv8YsGJvbrYnX4xIEqS5OcVUmh1HJLQeEjQX2rB8YO9fsKuCKakGWLwskN0Qw3uFau57pj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972821; c=relaxed/simple;
	bh=VkXbnXw/vuCVvpS9dasnvuX64xDMjhUIc9Ev+AKSHzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbhCJUDOTIFVXr5uMTPh07xGLUuWDj9iwjLTce+eGDe5T+1QtPRe4pSlwUd4dKaAsbZ2BBdMUV+oiUp1VRNrPz82zVfl5gX5CDFIUvqROnrP1aS0943eE0nCsn+Fcg4Poj4/nV9pfhcrw3gDEkUK7c2/AnUkr4n0mfbsgLcPnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPOwehLB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPOwehLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BCFC4CEF9;
	Mon, 20 Oct 2025 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972821;
	bh=VkXbnXw/vuCVvpS9dasnvuX64xDMjhUIc9Ev+AKSHzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPOwehLByObcO8jyMl928E2PZUJ+5wmYZZnzHF7xf4EZn86JaSmVPcs6UuAz1sd0Z
	 WUW1oWlxs/yxixr4j+aMNjU9rfFHtlWxcPpGiBP6OFCcsjhsBSxVwsb9GSUWyq7dE3
	 Azu1KpZNz5uwL27U1dHA60JUq9Hzv/25OQ7av08hICgBDacyTVLTABC5YoNiV2PStK
	 15DtZIjlBKzWuJkd1VryrUYi05W/uJpWL/iuisotNI7uTvsm8TPbPhtHIL+3ezxsgh
	 Ezs+HE2EpY9d0k7P3VXjP8mQrl4A+/1TGu9EeCuXLHtc+Wd8lqJ6C2GSvC6lis0PYD
	 GVSRDj3GK80mQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH v2 1/2] mm/damon: add a min_sz_region parameter to damon_set_region_biggest_system_ram_default()
Date: Mon, 20 Oct 2025 08:06:58 -0700
Message-ID: <20251020150658.39741-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020130125.2875164-2-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 21:01:24 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> In DAMON_LRU_SORT, damon_set_regions() will apply DAMON_MIN_REGION as
> the core address alignment, and the monitoring target address ranges
> would be aligned on DAMON_MIN_REGION * addr_unit. When users 1) set
> addr_unit to a value larger than 1, and 2) set the monitoring target
> address range as not aligned on DAMON_MIN_REGION * addr_unit, it will
> cause DAMON_LRU_SORT to operate on unexpectedly large physical address
> ranges.
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
> Fixes: 2e0fe9245d6b ("mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT")
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
