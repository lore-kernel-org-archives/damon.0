Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DA2FFDDF;
	Thu, 18 Sep 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185824; cv=none; b=iegZE0l8NxM/VkobkaFNybCz05fZZTI3ElBhZGfQmR9h+a2GFCLXHWQgi5ynqWz/XH4lyN0LiGjZbbyTcK79cIAG2K59XGkrP6SwuuSm3wZWiZwB5M9yBYfMWBLw4P6BRYAgo2wRv7YoDMEmH2dx9XVHERImyY5zmQ94ImlrmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185824; c=relaxed/simple;
	bh=yxVfx5vksXDs9huAM4+ZQ9ZyJNmrE6WNGXBbv/HqT44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G3hQ2cd9zVgxmvn9yesV6nIOlpHmwxlvi5vqCIBt2Now5T3lpyl/g3ES1S5/a9md/eP9cDQdIEx2c0pF8PpxHplt0KA5UfXuVYeEoYlQ1F8VnQ7WDqTRJ48xg2g404nIEhLFZo0WxrWtBr/NbuS6ukmZAO+yEbHI2RTRi/7pY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIpu3YQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIpu3YQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68A4C4CEE7;
	Thu, 18 Sep 2025 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758185824;
	bh=yxVfx5vksXDs9huAM4+ZQ9ZyJNmrE6WNGXBbv/HqT44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIpu3YQaEHDt818JLn/nm2GtOYrzyhdhz83htetfkYXX6SkNWnA27Ed6d7kfqctDl
	 w8vd+J+NGkBYxCi6K5+2x7Gh7Bcoc7wWp7dH25eD+6B2jn3FjZgO7PDND3TotLoy4y
	 4MNePD7xijGTBV9FQWDU0l7IsSF86fJ7V+RC4Ux1FCY1Z/fFE2JsFZWYz5dDMB+g1N
	 TPHf53GH4+yWYDOG7uKDawE9o2N1T+2GiungfCsM8LL4AP/f635yUz+QdiUWjTY5xg
	 yBsXvKT3gJV06lsfFfS/J/I9njYtM04lmqEjq83f6/tphV9MkRWhfiIuX5PT5n0DZC
	 Q0obo36sVHc4A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Xinyu Zheng <zhengxinyu6@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zouyipeng@huawei.com,
	Hugh Dickins <hughd@google.com>
Subject: Re: [BUG REPORT] mm/damon: softlockup when kdamond walk page with cpu hotplug
Date: Thu, 18 Sep 2025 01:57:00 -0700
Message-Id: <20250918085701.59085-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250918085249.58966-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 01:52:49 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Thu, 18 Sep 2025 03:00:29 +0000 Xinyu Zheng <zhengxinyu6@huawei.com> wrote:
> 
> > A softlockup issue was found with stress test:
[...]
> damon_mkold_pmd_entry() calls pte_offset_map_lock().  If the call returns an
> error, damon_mkold_pmd_entry() sets walk->action as ACTION_AGAIN, to retry.  If
> the pte_offset_map_lock() continues fails, infinite loop can happen.  I
> understand the loop you mentioned above is this case.
> 
> The error handling (retrying) was introduced by commit 7780d04046a2
> ("mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails").

I added Hugh to this thread from the original mail of this reply, because he is
the author of the commit.  I should clarified this on the original mail but
forgot saying that, sorry.


Thanks,
SJ

[...]
