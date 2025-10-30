Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2409272811;
	Thu, 30 Oct 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834684; cv=none; b=IwkyNvqlAoiqs/pl0McQ2904eE598dcuUPMJLY46lAeDYi6FImprySEUKgEG4q7Ythoa9WoJMHSkrcS75LQWZOXZqUKXSMbfnOhhTPms4hNsAP80960/fQt45ea8rhDoq7MKxycjQuUIUhagLCjFhfVYFeUV0Zn81X75tjeZsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834684; c=relaxed/simple;
	bh=wVeI2bnXMnl1w241QzL6qX0vCpn21BM863M6E2kLIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANDBHG3ZlJpXH0X71ELV2UHbXtGpgHinLJJKGf97VMyoK1v0u6uWHWx0SXzxFSmw5tu8wUveq3FNNq04hqlsdInliS2Ucg8cmiCZzRrnNv2TYE7gZr5+ejMoBNz7sa3tBEfsTm/5Qs/ENwT/3lxSsLqGfXyZfdcvw27iKkD7WrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmmw5/Dx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmmw5/Dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BEAC4CEF8;
	Thu, 30 Oct 2025 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834684;
	bh=wVeI2bnXMnl1w241QzL6qX0vCpn21BM863M6E2kLIP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zmmw5/DxF/Q7Hn3z5GWlK4KKI+8xA4rJZuQbGWiaovZxVH59927YB0QXzb74DAoRe
	 +ns92p7RyrWSP6aTuFeb37I6lJ5inAlGAvzQuDpibr6DDp+Ak8dLCt6vqtusQohnOv
	 YTxZLxLo20oI6dAhGO+tIz9P0jIcdBnHWmLhAWgoHarexv43JujzLGCai58myLDssS
	 my4arN+0SUr9abOWKzoD3lSV/7FTPxXb9PDSeGt5aYs4nlDlizX387iJGHMxGW+p1J
	 zukfGgVZ524yqGT6oad3PhLYHQKiPUIerTI7m+Nvp41d0d0I2gSDVqDz/0AlfMI1p5
	 FFv55IqYizoZQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH v2 1/2] mm/damon/stat: change last_refresh_jiffies to a global variable
Date: Thu, 30 Oct 2025 07:31:15 -0700
Message-ID: <20251030143116.46746-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251030020746.967174-2-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Oct 2025 10:07:45 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
> avoid unnecessarily frequent stat update.
> 
> On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
> jiffies wrap bugs appear earlier. However, this causes time_before_eq()
> in DAMON_STAT to unexpectedly return true during the first 5 minutes
> after boot on 32-bit systems (see [1] for more explanation, which fixes
> another jiffies-related issue before). As a result, DAMON_STAT does not
> update any monitoring results during that period, which becomes more
> confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.
> 
> There is also an issue unrelated to the system’s word size[2]: if the
> user stops DAMON_STAT just after last_refresh_jiffies is updated and
> restarts it after 5 seconds or a longer delay, last_refresh_jiffies will
> retain an older value, causing time_before_eq() to return false and the
> update to happen earlier than expected.
> 
> Fix these issues by making last_refresh_jiffies a global variable and
> initializing it each time DAMON_STAT is started.
> 
> [1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
> [2] https://lore.kernel.org/all/20251028143250.50144-1-sj@kernel.org/

Thank you for finding and fixing these!

> 
> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
