Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8602FE566
	for <damon@lists.linux.dev>; Wed, 10 Dec 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358105; cv=none; b=izsxq0lvcIjl0hmVmPIR9gLElW6M/33qflQtrbVIxjB7ef/kpsthkYGbF0jrQ6d74lzJxwwcvgPqIq6/6qIDBjV/yZGj1BDlu+nltMmmlTF8RXsBWoCT7Px7xe18mjAZzfE2fXpcbeFMj/6ph9vhRfYvpUVhAMbiU+LTNV3/okA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358105; c=relaxed/simple;
	bh=S42l+IFg4lVCAaNGZ+4P62KXbqFkfaIiQw3CI15+7Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBtDkeIsJGSbkW+4/kDsUZ2lttV0OZGHFN4mwmrO0cQiF62cJDTrllGTbJ78/ftsIhTSC1JdZQ0csN7grk+rg1jBKhGI4KrsfY26EOcEtksZ3rHpkVIVieo708ktmUTrRKt/Mwxn6Dy7xWcmT3M8Ls/48qBlRy8fhpA9ohD52I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plrM2pE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plrM2pE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3594CC4CEF1;
	Wed, 10 Dec 2025 09:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358105;
	bh=S42l+IFg4lVCAaNGZ+4P62KXbqFkfaIiQw3CI15+7Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plrM2pE3U3Vag97KDesGNar970xndDRJj+JiE8XGe7L4liZ+BT8BKsqKhdvjipJGv
	 4wB1lFfFKPyDehP0wxoANWPzk6DIYi8boK/5DsUbHiMRqAMl1fQOf9OcWML+M0FW1l
	 TIEo6BD+hVL4PHMe4KPcOWYiHHZcdgVJAZeyfveQJDvGBlcAcEPOsw3CDEHRkvO0Y7
	 qg0/kSls5yt8X7Je2pDoaAEWI0J/7rBZdjoWS6WTpB2Vb70u4UMPRRiuXDV7DsMxE/
	 l0MGtf2hS+K5bPiZkaQO/bMsxp2be/ygYZah5wprJChAUcH+EJyg1NQxuW/zZYqPCp
	 AqbtrKgWJTAKQ==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/core: fix wasteful CPU calls by skipping non-existent targets
Date: Wed, 10 Dec 2025 01:15:00 -0800
Message-ID: <20251210091501.55277-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210052508.264433-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Dec 2025 13:25:08 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Currently, DAMON does not proactively clean up invalid monitoring
> targets during its runtime.  When some monitored processes exit, DAMON
> continues to make the following unnecessary function calls,
> 
>   --damon_for_each_target--
>   --damon_for_each_region--
>       damon_do_apply_schemes
>         damos_apply_scheme
>           damon_va_apply_scheme
>             damos_madvise
>               damon_get_mm
> 
> it is only in the damon_get_mm() function that it may finally discover
> the target no longer exists, which wastes CPU resources. A simple idea
> is to check for the existence of monitoring targets within the
> kdamond_need_stop() function and promptly clean up non-existent targets.
> 
> However, SJ pointed out that this approach is problematic because the
> online commit logic incorrectly uses list indices to update the
> monitoring state.  This can lead to data loss if the target list is
> changed concurrently.  Meanwhile, SJ suggests checking for target
> existence at the damon_for_each_target level, and if a target does not
> exist, simply skip it and proceed to the next one.

Thank you for making this patch, Enze!

> 
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
