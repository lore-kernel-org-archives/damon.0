Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BC3DA5A7;
	Tue, 15 Sep 2026 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484709; cv=none; b=M+RDeFsJLgnaa0yY62ZLLWWuSZ4V9a6Z8/zXb0tWqjZTLSHfeN+4SUsIWGrZ3QAMrGCD3fRqSBJdyiCSYA7BtsHbo9gNcY30nwWy7mG1jnUR/Jmn2GHKEOtwHAHZrbBWMVf5WFXqxFxDLeZVZ0/bqwbuqK+QfdLGOmfL8eHLYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484709; c=relaxed/simple;
	bh=0NzzyQPjuOAcuIMR/7l8UiOVmk0uwz8QlKyF4VoSZ/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H//tkBRINUlrCuDy6VvaXtjSbJWtYxE3A++d9BKhEbaPzbI35DreQS8fvJ73OHuYf6o1LonvkAXCHk8ZLkzNdXv0mL2+abb7cwsQ01xAqumiMycHu2r2homuzs11ezup9d17W77iucp/jW0ImKFl+q1y48FGj2Z/5T71TAbXz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTYQz+4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTYQz+4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2627B1F000FF;
	Tue, 15 Sep 2026 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484708;
	bh=mvY16KjcBiMArLy1iqWzVK3IRsX2lFN4G+miq/VqWjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTYQz+4sfDZQOxuxOs73OxykKi+NVW9swaQzxugs3lGVhAv6XnZ2+6ysW90CQMjFV
	 ocqXxiGWBx2KOO7h/4ST3SG47IeSVDu4QrAjuw6ie1A6wY5a6ZHVUwDz/az5X92a4n
	 HC0aXiwVmtAzXyy5FjuEoh89eJAv1+x4Ytb1TNx8gcsJnPuhsl1Ih0TJkHGI2gQ3yU
	 PO7+UEx+mjzP6zXNDljq6dpxF+jx5g/zWXFFHJIM5etu2OYmJ1wqxpgfalltDXGQtt
	 Rjy307DEA8I5og88N9dwrokYU5tIdvQKJXDgiidKRM5E69Se1cGCd9ddE0YfnCNlCZ
	 3bGM5b5KCrmlQ==
From: SJ Park <sj@kernel.org>
To: Xuewen Wang <wangxuewen@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/damon/sysfs: propagate damon_call() error in turn_damon_on
Date: Tue, 15 Sep 2026 08:05:00 -0700
Message-ID: <20260915150501.95021-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915093928.3389096-1-wangxuewen@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 17:39:28 +0800 Xuewen Wang <wangxuewen@kylinos.cn> wrote:

> damon_sysfs_turn_damon_on() ignored the return value of damon_call()
> for the repeat call control registration and always returned the stale
> result of damon_start() (0 at that point). When damon_call() fails,
> e.g., the kdamond is already exiting, the user still gets success from
> the state file write while monitoring is not actually on.
> 
> Save and return the damon_call() result instead. No rollback of
> damon_start() is needed since a failed damon_call() guarantees the
> context is stopped.

Nice catch, thank you for fixing this!
> 
> Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
