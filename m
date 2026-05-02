Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BB1B86C7
	for <damon@lists.linux.dev>; Sat,  2 May 2026 01:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777686707; cv=none; b=ZeuGyCM3lKEW9m3nKe58wqiEzzIrbZcZAYAjjWfSdwp3YlKUUp+N5fWbiizzdrNypiBygYT0YTMA9hxwzuwvXp6gFiIb7Y8Q8jOmWdKTSSd4fT/plMGL6Ek2Ih49HOzb3owzyz9Dx8TDBB+aLZjpQHAHd3nOS5Zs4cExG5uVtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777686707; c=relaxed/simple;
	bh=t8Z7xK5A6tKGFKdT0lgn7E7AJKpyNn35b6497y/htpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am+I6HGvqt/gy7MkXPHFSssHfuFpl1Lqz/us1g4klluc7PXAVE2A3fLrVerG2S6dA9cvowZyRKRl31JHUkoCG22U+/cKwpPghJD3fa/amRxA4Is6AopnKmc3bnFCFIyA9vjdKvnYCSXL5xvyJdFpx+FKFy1+L5h8fqUss5faZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oig1iwIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oig1iwIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8454C2BCB4;
	Sat,  2 May 2026 01:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777686706;
	bh=t8Z7xK5A6tKGFKdT0lgn7E7AJKpyNn35b6497y/htpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oig1iwIpdrkj/8Mfse/ppBN+IIrjv6wDZuDTKHtKNF0zBmJgkSL7qmpgwNGWnLc4h
	 m3GPQLfywqmVh5GoENJfNgzVZhuEXNNEHyLbbD1RfKMsc/iqa4/e8W6F/DwXTcaqHT
	 yFrTuZzmxN6pTg5lcYGhnec2M2bp9WFPRGIlcDs9EQXra7kv960AswriYtJhyfWP+l
	 NDZCAggD/6Dkirvbjj0pOGZl7iMdZjOB8oKMQ3i/DoeUwD6nAfkshl6iCFEWW8ZsXZ
	 FyMrDSi1w/KJJ21+yj+W1GXf9LMTnCE65Lewolt8dHX00auKfAfBRLJkYiND2FNvzL
	 zL8MHON6ourKA==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  1 May 2026 18:51:37 -0700
Message-ID: <20260502015138.78551-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501013750.71704-2-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  1 May 2026 09:37:49 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> When a user sets an invalid 'addr_unit' (e.g., 3) via DAMON_LRU_SORT,
> 'min_region_sz' becomes a non-power-of-2 value. While damon_commit_ctx()
> correctly detects this and returns -EINVAL, it sets the
> 'maybe_corrupted' flag during this process.
> 
> This flag causes the running kdamond to terminate. While the termination
> is a safety measure, it is suboptimal in this case because the error is
> just a simple invalid input from the user, which shouldn't neccessitate
> stopping the kdamond.
> 
> Reproduction
> ============
> 1. Enable DAMON_LRU_SORT
> 2. Set addr_unit=3
> 3. Commit inputs via 'commit_inputs'
> 4. Observe kdamond termination
> 
> Solution
> ========
> Add an early validation in damon_lru_sort_apply_parameters() to check
> 'min_region_sz' before any state change occurs. If it is non-power-of-2,
> return -EINVAL immediately, preventing 'maybe_corrupted' from being set.
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
