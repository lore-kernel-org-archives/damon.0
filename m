Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DBB28EB
	for <damon@lists.linux.dev>; Sat, 24 May 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748104154; cv=none; b=ZDsKJNGtB4ji9GS4JcpVpxMVn/Spvi8kcqkCXD+KopZYWZzvPd0F/g0xl28Y+VtoNKOHObQmB7JIOG22H4eZKm3imlrqQ5Aoa35lyj97YKTcubf2kj5h1mUWDiCmON1HMQNFbB9IxvURzMzlm5MzwB4qptV0CM3b4hJlFQGRAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748104154; c=relaxed/simple;
	bh=RuxtQQu2rqdKNDy/24jUv4A1KuBO696D+ML/w/cSZ90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NXqxx9K/D/KKTDN04Ag4uFxfygOQJ7M2XnhDs+v6jgUyXSqstmccH+BGS44m6iAI9G8KsIbjKPyNL/uT5RLOpDER/TT0mxi8/cVoXwxiuuL4UiGKVLax7ogIDvPWel/Cb5s/aHsbxZGWbJcj6XCbci+eqFqPlZg4bwwHJjR58Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnXrbfAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnXrbfAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D4DC4CEE4;
	Sat, 24 May 2025 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748104153;
	bh=RuxtQQu2rqdKNDy/24jUv4A1KuBO696D+ML/w/cSZ90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnXrbfATJLjU7Xp8OT9TWZQJ/yYvrm0lPaSVBDFBAH5nsPytoy1vb+u/6t8zUZy4e
	 BClLHsHDahJgkER2tlwpC4AnfB9UkWjEuDiEiQdMQ69lk5HdJsQYjZ9H1W1yLtwqZC
	 oCyX1L76vLUwtcCNAdSl5cbGxdl8DsfF3BdB6rsDw3njPbWwGB0mmvjku/rNAwBkOM
	 IenCeu2z1k99KCM20M+f3S5s86f1BvVhJz2O5EsjR8Ps69ZV6FI01MaOdL2LUN+7IZ
	 9Dv+ncyW0ZeLITg0HtuOHTXSiFscDD6BS4J/MhvyhHkSaa3ovzC1vGPdWWDQiXZvdV
	 glvlgBetzXEow==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon: rename primitives to operations
Date: Sat, 24 May 2025 09:29:10 -0700
Message-Id: <20250524162910.67889-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250524125536.13267-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Enze,

On Sat, 24 May 2025 20:55:36 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The word 'primitive' is not explicit and has been deprecated in DAMON's
> context since commit f7d911c39cbb ("mm/damon: rename damon_primitives to
> damon_operations").  To make the code easier to be understand, this
> commit renames remaining 'primitives' to 'operations' in header comments
> of DAMON source files.

Thank you for this patch!  The description makes sense to me.

The title makes me bit confused, though.  By reading it, I was assuming this
patch is changing some code.  But this is changing only comments.  Could you
please make the title more clearly specify that?  E.g., "fix outdated comments
for monitoring primitives"?

> 
> Fixes: f7d911c39cbb ("mm/damon: rename damon_primitives to damon_operations")
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  mm/damon/modules-common.c | 2 +-
>  mm/damon/modules-common.h | 2 +-
>  mm/damon/ops-common.c     | 2 +-
>  mm/damon/ops-common.h     | 2 +-
>  mm/damon/paddr.c          | 2 +-
>  mm/damon/sysfs-common.c   | 2 +-
>  mm/damon/sysfs-common.h   | 2 +-
>  mm/damon/vaddr.c          | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

But, the term (primitives) on the comments of the files means the DAMON
monitoring primitives (old name of DAMON operations) only in {p,v}addr.c files.
On the comment of other files, the term means code for basic and common uses.

Using 'Operations' term on the files look ok to me.  But in the case, the
commit message may better to slightly be updated to clarify this.

Just keeping those files to use 'Primitives' term, or using a more neutral
term, say, Code (e.g., Common Code for DAMON Modules) could also be options, in
my opinion.

I have no strong preference among these three options.  Please pick what you
prefer.

Could you please revise as abovely suggested and resend?


Thanks,
SJ

[...]
