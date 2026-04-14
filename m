Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF9219303;
	Tue, 14 Apr 2026 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776127667; cv=none; b=QJYIYUbRevel0ol7RLzSRY5tNQPa7a/3g8AYTmWLl16+12sHwKz6M9oMSZYR8DghKZv1lSdRF+KsOMpIyqvZkufDPjkoenzfj4TdXShEzFLtxcEzTOMDuJjIUpY6Cl3RM3lX2m5RO9HE3EnqXLEVeU5Vx3j8XTim9GxIbBoO2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776127667; c=relaxed/simple;
	bh=kwCR6jNJyCy5Cp/beB01W/9pSDx/xZgjV5/dwIyldN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSKDv01dqrmI+0tXmrFlEMt9TwcskO77fWCv4+iaIxDXyb5JmIxysnp+nW1b5clsaZIqgDslj9Ly4qquxX18GQpvSBuL8sESSggv7seaymgC0w+DJKKonWZEsIJ43huqYgNQrd/zsFLcfhqYyUBgLrGwH633qBIG0b0lEpVjr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFbPd3zO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFbPd3zO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C89C2BCAF;
	Tue, 14 Apr 2026 00:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776127666;
	bh=kwCR6jNJyCy5Cp/beB01W/9pSDx/xZgjV5/dwIyldN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFbPd3zON/QBBLjsaBL9P4bAEnAhFOjdcnQ1A91hGh1Dgrup8rO7XCvvVgB5Rk4Qd
	 VURnfGuEv9yb9o8FcefA/FAeMjj6vv0nmBYrigQSE0A2mRjpib11zJa7rKsJr3KXBU
	 k74GIc5CLK9Hc09IePt5XQKVuGwf1dmNJ68rqAQQpsNI2F/cJFGILlt3GZ+vIhSBeL
	 n6xlOpnR1FZZAfIO7B1Socc3uoPZ5QvuDr5JHieb6HPN5EvQVca1+tvuwZJ6TxmxAT
	 0Nd8qyZ70fzfOgYeiDIhwCoU0G46U4Fxj9/rNCCns5YwfBUiW2A2nSeOh3V6KNqXLx
	 4H2I/ATLJOLyw==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] mm/damon: generalize ctx_target creation for damon_ops_id and add vaddr support
Date: Mon, 13 Apr 2026 17:47:38 -0700
Message-ID: <20260414004739.83961-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413145943.512192-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 13 Apr 2026 14:59:43 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch adds a new function damon_modules_new_vaddr_ctx_target.
> Since ctx_target creation for vaddr and paddr is almost identical,
> the logic is extracted to a new function,
> damon_modules_new_ctx_target, and vaddr and paddr functions are left
> just as interfaces.
> 
> This change was suggested earlier[1] and it is needed to allow
> developers to create DAMON modules that use DAMON_OPS_PADDR targets.

You mean DAMON_OPS_VADDR?

And I agree this can be useful if we will make a DAMON module that runs for
virtual address spaces.  But we don't add new functions without their callers.
So this patch should be submitted only together with the caller of the
function.

> 
> [1]: https://lore.kernel.org/damon/20260311005759.90440-1-sj@kernel.org/


Thanks,
SJ

[...]
