Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DC2DF68;
	Wed, 13 Aug 2025 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103751; cv=none; b=DzCloNr1wECXICn/XpaGPzqvtdUoDq/LN8OeFz7tGpD8NXDlY47SnHFJfdy3Rzkt9h4PXOYlyNa9g/ZESIfmnLpfSGNbAaZ+gdlQshW/zpevHW/PAge9p1MbXnYPxBl5XeIPZ4EHxv3hDe+aeekt79LG2q18mqNJ/HJOTVe7d2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103751; c=relaxed/simple;
	bh=CSFaSozMOw3PaXtP/V3KWHY28EmmlL/o1GQ0agoqXDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxabVoyPH3fFvA0TOFVjYr7TgIPTOrWTvR+7HeGtDUrFnBJKK890urL6DLAXAyEV/DnyvGMeJ/vK3qaDC5MHQSsP3s/orXTOgUiSQRx4t1yLe/5C40wds+xE03fiLkEHIKkVGxe3DVe0x2iX8hzznpfdI7H5ttIMNWPhKV5Q1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK1WJO+x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK1WJO+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16452C4CEEF;
	Wed, 13 Aug 2025 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103751;
	bh=CSFaSozMOw3PaXtP/V3KWHY28EmmlL/o1GQ0agoqXDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UK1WJO+x86Xc9PmtfdbEVJHuMZOa/tpxzVdWXSB+H8OpvyNUYzl/9EUmEqQUGy6WI
	 OO+/Kma3G6O4zOfWkPLIZxMyi4l9HsxxmtqLjFdzUcsWjaNpNZEZd3TZIJDlGsfFM0
	 bzjHt7SAMVmhX5u6y7O+KeEa2HqxycRLJLpC0DpkXCpVa7cY92EOOoUyZsezSVr7p0
	 LjayP5I9fN2JKiVuMMkzzGE+m7+7EEFNvVuZA6xEIjatd2fBOxKSYTsXLugNCAhTG3
	 BIoTsI+9BJhOcHzxD7cFysUSe2skX6y/qyQe7NGcmhauOGbNgMzO4vHOUcMh+RL8dw
	 74RkYcechA7ZA==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 12/16] mm/damon: add damon_ctx->min_region and damon_target->min_region
Date: Wed, 13 Aug 2025 09:49:07 -0700
Message-Id: <20250813164907.5885-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-13-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 13:07:02 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
> bytes and cause data alignment issues[1].
> 
> Add damon_ctx->min_region to change DAMON_MIN_REGION from a global
> macro value to per-context variable,

Nice!

> let target inherit the min_region
> from its associated ctx to avoid excessive passing of ctx.

To me, keeping the synchronization seems more complicated than just passing the
addr_unit value to relevant functions.  I'd prefer passing the addr_unit to
relevant functions.  It could require more changes and might make code uglier,
but I think that's easier to maintain, and we can cleanup/refactor the code
later.

Could you please do so in the next version?


Thanks,
SJ

[...]
