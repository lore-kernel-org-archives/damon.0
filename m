Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2526299
	for <damon@lists.linux.dev>; Wed,  1 Apr 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005319; cv=none; b=ct3nthQwmwBDn6143dPBFZENXaRWgKbjbW2pNNqPYk1NwCzTmoSxnrVGlsMELS+Bbfz+f4SyY2R2/MikTsFczPrrjs0uPaFmKsipVEFw+l5jnIvNkzAf86yKM2Zt9Oy7nHhP0YMwGmGNN7Ub717DcqdQZBX/dD/e9ubNIycgSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005319; c=relaxed/simple;
	bh=jcORolmk2pu3U1KnRXM+xvp+DaiomzAMbEur1rQS6PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwWpVDGxGHPIE2ZBQTbaUZFKpzbhFp458QBpxBkX46g7NB+pCc+ZSoiFW/8Jn/ZrBA5oU78JJlQH442n1oKwiCn5m1Ozn4Md86sZx8JvIW3XnUK6ioydbKeKJNuL28PASqduBOjlOsh8bBoZyvwrQTAm1Hz92EbKhP7TPcrkMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZDeVQJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZDeVQJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBDEC19423;
	Wed,  1 Apr 2026 01:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775005319;
	bh=jcORolmk2pu3U1KnRXM+xvp+DaiomzAMbEur1rQS6PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZDeVQJw4GASOjNYX8+ocjkJYyN3ReMmn6javnl04Oau69d7Wl/6H4cvUhTVfwRPx
	 +BYTI0tkNnsaV0C3QQ9KSj41eUL6LVtnClbc6wipxwdEU3i0GWn4567J8llXXFVBz2
	 IlXw7OvBoKEArkvIBXWb8GVWxyp5uy0yIVRHcHwXEmc4lTsch74QGTyjIWpw/x0ph1
	 Hmt7SwgqOytbGavQH8UqtzMcJ03Ihnm/yUZwnPcOFcWIfK2BkAp8XEoeG7njazXdU6
	 o8PGB4ElirT/dagWyJfTs3TQbzzlwkdy+GZlJllB1DfSsNlInQKYUUb0gN9cdan7/h
	 bUcqd890l5EIg==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate min_region_size to be power of 2
Date: Tue, 31 Mar 2026 18:01:56 -0700
Message-ID: <20260401010157.86136-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331073231.30060-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 15:32:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Problem
> =======
> damon_commit_ctx() checks if 'min_region_sz' is a power of 2. But if it
> is not, kdamond will terminate unexpectedly due to the user's invalid
> input.
> 
> Solution
> ========
> Add the same check to damon_{lru_sort, reclaim}_apply_parameters(), but
> return -EINVAL immediately. This is to prevent user's invalid input
> causing kdamond to terminate unexpectedly.

Seems sashiko found an issue, and you are preparing the next revision, right?
Assuming so, I will skip code review of this version.
> 
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> ---

Weren't there previous versions of this patch?  Could you please add changelog
here, from the next version?


Thanks,
SJ

[...]
