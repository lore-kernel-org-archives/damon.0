Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E1244662
	for <damon@lists.linux.dev>; Sat, 20 Sep 2025 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370293; cv=none; b=BFqirHYQx9sMbpP5C1ER3ZJNne5EvX0UMMJUq/3XvPpc26FVGwTbLs6ti4fOUdB70HWkvq4/iny8/F8JRmKonwI7teYYD44bqt1vmZKOUYqRlDJpYD5hr2JW90y+WHO22csh/LxO2JF8Wt8d2e641vi3m0aiM57Ad1gh4UaZPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370293; c=relaxed/simple;
	bh=/jpAur8LtSXcT2WcXmQY8ihBcX3e5jjp9nxJv/MHF9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5sw82JcONTmgJi7ppTZTkkpYINqOKzP/0BdAF2s2Fh8CBQyWOyHm4E5u0aLDFQXlAvGBlXU7tB0xejdERrF3VYi/82okqqU0QgKFEZkNUPHjLtQGEM+pdYl4nsFPsYb+Jwj4hxAORdHHpWT+s7C92ro+Na/16QO+/3xtLnAbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkIcf5xT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkIcf5xT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388F4C4CEF7;
	Sat, 20 Sep 2025 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758370293;
	bh=/jpAur8LtSXcT2WcXmQY8ihBcX3e5jjp9nxJv/MHF9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkIcf5xTRCra+vv5+L66ZUsk0wPapkLFndgMQXI1OIXyByrP6iXscM49IbtNHoyqC
	 hUzZ1YRfUcORX9PCEgpTVsAI7cRsG1hOZvHGAq7RrGvlDqotyvomd+F0nmH3qM/4DG
	 diV409SWzO2tFdsewcmrQGbE5hDaspg4QcGd1DiM8GaxKWyeCijOBeNKdetTHH5dgS
	 T656ttjfGfWpiTYvSuPBhLmfQ7kmGkAU7Zwq7dDuzkVGEOCQLOVpSkafUb+WYudKmH
	 wBucQ5jN2D00YwKETiSEDxYzBVpEYvgcj+bw9wWQKqX+LNwX5NaIad1axDIad4lSzp
	 fDtRLqUrJHpmA==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	stable@vger.ekrnel.org
Subject: Re: [PATCH] mm/damon/sysfs: do not ignore callback's return value in damon_sysfs_damon_call()
Date: Sat, 20 Sep 2025 05:11:31 -0700
Message-Id: <20250920121131.83174-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250920105236.29952-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Sep 2025 19:52:36 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The callback return value is ignored in damon_sysfs_damon_call(), which
> means that it is not possible to detect invalid user input when writing
> commands such as 'commit' to /sys/kernel/mm/damon/admin/kdamonds/<K>/state.
> Fix it.

Thank you for finding this issue, Akinobu!  Before the introduction of
damon_sysfs_damon_call() and its usages, DAMON sysfs interface was returning an
error in case of such command failures.  So this is fixing a user-visible
unintended behavior change.  Hence this may deserve Cc-ing stable@ in my
opinion.

> 

So, below may better to be added?

Fixes: f64539dcdb87 ("mm/damon/sysfs: use damon_call() for update_schemes_stats")
Cc: <stable@vger.ekrnel.org> # v6.14.x

> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index fe4e73d0ebbb..97e16f00f23e 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1627,12 +1627,15 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
>  		struct damon_sysfs_kdamond *kdamond)
>  {
>  	struct damon_call_control call_control = {};
> +	int err;
>  
>  	if (!kdamond->damon_ctx)
>  		return -EINVAL;
>  	call_control.fn = fn;
>  	call_control.data = kdamond;
> -	return damon_call(kdamond->damon_ctx, &call_control);
> +	err = damon_call(kdamond->damon_ctx, &call_control);
> +

I think the above new line is not really needed, but it is definitely trivial.

> +	return err ? err : call_control.return_code;
>  }
>  
>  struct damon_sysfs_schemes_walk_data {
> -- 
> 2.43.0


Thanks,
SJ
