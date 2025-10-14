Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6121B9DE
	for <damon@lists.linux.dev>; Tue, 14 Oct 2025 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466345; cv=none; b=X56Ug7hyXUy5XsjkwFosrCH6byDuqenS7iIJBUiFPRGdwqm/m5zHQNoedwC1K7r5+NuFsS96ujqLTM1rYDrQ9G6RRqa5Lz1TBiCy9InmPeIHv5zlay6Ed/cd7p7XfMBctzfylneih7BV7uLUnjOSNO8UVbVfk+cKvcf+FHFBxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466345; c=relaxed/simple;
	bh=Y9Tu1SuK1U50HGeWWFYQ+9vjydcCGD17mbmw+C/L+jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5IdhKTN6WFxZCIRxoW7ALkx4I7Yon19w65EiXrxcuGDbfqHDtvjzMOwH9TY+CcgJuU++4uZd0z1wHqmWqDDwN3KA8cZagKTQEzwv9hbPbXxuKzdmdPZD+oAPFQS+8N79qMZaM9PMWwLRrTP08fm85aI81Ihnxkd/CzgYHC+VgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2AyN+Ce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2AyN+Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA96C4CEFE;
	Tue, 14 Oct 2025 18:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760466344;
	bh=Y9Tu1SuK1U50HGeWWFYQ+9vjydcCGD17mbmw+C/L+jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2AyN+CehSRvFD/j7+72y7eCCx5KD9lOnW44xvaH8EcNmnjIwBBM5Iex5eJKgoJJF
	 aV675fWSmz8FYbykCkaVNnXbCCrhsGyw8HYiGYFiAc9aXZPKySyRpq/QWzRjC7AqOu
	 OtJze5iSOjj+BC38p54cQxWMmR0/pbfmngU0Fy8EfjjzKEfgHmL1XGrxm44+8VOppI
	 lx6FEMTXDf7w59st2U6h0c5fiaaIUE7flkXphoS6fhA4Oin4a7K1BknfGcBrXmwZDp
	 +UwgJ+gPwEZ7033tWzkzYfUT0cyfa8bJ9qmxk57G89vFXFX92eCsyFDMDDWxGdtn8v
	 p8AR5OGYabQXA==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/core: fix potential memory leak by cleaning ops_filter in damon_destroy_scheme
Date: Tue, 14 Oct 2025 11:25:38 -0700
Message-ID: <20251014182539.50115-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014084225.313313-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 16:42:25 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Currently, damon_destroy_scheme() only cleans up the filter list but
> leaves ops_filter untouched, which could lead to memory leaks when
> a scheme is destroyed.
> 
> This patch ensures both filter and ops_filter are properly freed in
> damon_destroy_scheme(), preventing potential memory leaks.

Thank you for fixing this!

FYI the leak is not only potential but can easily be reproduced using the ops
damos filters.  For example, I was able to reproduce it using DAMON user-space
tool (damo), like below.

    $ sudo ./damo start
    $ sudo ./damo report access --snapshot_damos_filter allow anon

After the above steps I confirmed it leaks the memory using kmemleak.

> 
> Fixes: ab82e57981d0 ("mm/damon/core: introduce damos->ops_filters")
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
