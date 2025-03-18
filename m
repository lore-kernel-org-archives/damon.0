Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C71C4A10;
	Tue, 18 Mar 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323919; cv=none; b=RCfAZHZHsuWQRdneW/wbJmL20KMvB6w0AcCZ3a4wVxHxIywKSIf2HzJ1lB80ATxGgPRvBwPkSLnStx0uJzIOSDoD7vtIg6IoFlfNYxXJT54SvU4ErX2Tn0dW6xgx1rms4qsTBwkO8lgr24J2v1qJzlKiKeClkQZ8zwbxwVBF1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323919; c=relaxed/simple;
	bh=81AwGyZXjC4TJiUj5WX42iADevcVba8Ulia4LcaVNJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBV0Nag+HUJIhJmH6Rqy4ZdmUyvdRXIzwcGDDFVGjsmR9R8k+lG8P9z3RMtNLlLNcmGXGMcXFxjFnFDZ5sckF/DciuhguarqgMnL28pMLLpe7Cj9y4Z406AIok4o5zfKldAV1JzvzgWYhk/Rgzmf3JBqUwgNjhH9WI03awoVU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuFC1uPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuFC1uPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2BBC4CEDD;
	Tue, 18 Mar 2025 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742323919;
	bh=81AwGyZXjC4TJiUj5WX42iADevcVba8Ulia4LcaVNJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuFC1uPE6yHdgvmtAq5fTuU4Y4McB8SCdbjn4D52fgqleSfvTqkKb+9PfW3bP3Yp5
	 UAwWm1sCpsERsiA1fne3s7/jcMIfG91LSFLkXDwu6jGslOtGR+q4aOmgiD0NVFGYAP
	 IhX/YFvVbyISYJqhImXCu7EOjWV2tIYGofzh0N0DGk2dpjXo1dnqrrQ/QDcOwLUJwQ
	 cO43zD3rOdTZ3Cs8wFky36R6V3yLbj84+w4RwlfEBgQLrErlI47KvLnaXhFJ0dNlET
	 CIKUhmaGYtiOMWkxVfk2jBH9rYVopwETnMUTXEcZla/jVoWP0Mo0Od1T9lns6Skx3y
	 mqzzkb7NKfrxw==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH 0/2] mm/damon: introduce DAMOS filter type for active pages
Date: Tue, 18 Mar 2025 11:51:56 -0700
Message-Id: <20250318185156.35448-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318183029.2062917-1-nphamcs@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nhat,

On Tue, 18 Mar 2025 11:30:27 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> The memory reclaim algorithm categorizes pages into active and inactive
> lists, separately for file and anon pages. The system's performance
> relies heavily on the (relative and absolute) accuracy of this
> categorization.
> 
> This patch series add a new DAMOS filter for pages' activeness, giving
> us visibility into the access frequency of the pages on each list. This
> insight can help us diagnose issues with the active-inactive balancing
> dynamics, and make decisions to optimize reclaim efficiency and memory
> utilization.
> 
> For instance, we might decide to enable DAMON_LRU_SORT, if we find that
> there are pages on the active list that are infrequently accessed, or
> less frequently accessed than pages on the inactive list.

I agree to all the points, and thank you very much for this great patch series.

For other readers' information, DAMOS filters are for visibility of not only
the human users, but also DAMOS itself.  This new filter type will also be very
useful at making DAMOS schemes that respects LRU information (e.g., reclaim
DAMON-found cold pages but only if it is on inactive LRU list).


Thanks,
SJ

[...]
