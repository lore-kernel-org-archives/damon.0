Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F510A1E;
	Fri,  5 Sep 2025 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757036383; cv=none; b=dcbe99kNRXNR65VzwNC1QcsCqV5nFEewZuFjxWvmfbo7eLCT5Sce1ZOW6pVgZNgrZA6hyxXmxRrwXVhIWiOojM7j0dhmGuUhu3z2ZyFQPiMMHTqEbbvJLR0R5BtD2dzMSvw14ift81xd+pdna9842EpijzmLND9lnGUROjhSa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757036383; c=relaxed/simple;
	bh=gBxt9yJz2X4rnYGw4cOMBTPWUl+ly8t99jMd8+Q6yuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCSllgMmr6XgliSsad+Gk6kQxyvdyXit7w/icWEGYFWrAkl5SrOIhIsyR87X+GRzw6/gD3PmurFDrxX2l4pw/qA8IDpgVtI9HcKjLfsDgjYFSGLNQhwPmXgtcazmHytnZdL6cgCA3YnKTk+AciJB5wYuyIhG6pc5VWqRoY8k0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbFPG/w/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbFPG/w/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820A2C4CEF0;
	Fri,  5 Sep 2025 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757036382;
	bh=gBxt9yJz2X4rnYGw4cOMBTPWUl+ly8t99jMd8+Q6yuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dbFPG/w/wasGxE4JyWYdMLVevQhqjjL8DiEB8HyzOADOoZfXx/q/CD31Tbs1oZQE/
	 MrOMmlMejI+JVmjuunKLMWDqz76GpIrhFTn1WWiZZ3cdNWXo9gxEg7SiyIgUvgVDxW
	 TN++c3hMjuwAAeHjyzAX98RHWKyna0EuhShjcGUBUAc0kQJxvmcpOOl7LnTQAezrp0
	 s4dNFmyxXU424xbbKJHoWGSMDc/bL2TC7+bDGs//kVF8unwXKIm5OwIzwRoGEW1OfG
	 5CrzodZiFYxAOY8BgB0kgjjx59pB1Vk++SBvTsL4OrEuApZzyHCD58RdqM3mlNPXr6
	 LEsHA1021uj9A==
From: SeongJae Park <sj@kernel.org>
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: Re: [PATCH] mm/damon/sysfs: fix use-after-free in state_show()
Date: Thu,  4 Sep 2025 18:39:40 -0700
Message-Id: <20250905013940.94255-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904175549.88928-1-disclosure@aisle.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  4 Sep 2025 20:55:49 +0300 Stanislav Fort <stanislav.fort@aisle.com> wrote:

> state_show() currently reads kdamond->damon_ctx without holding
> damon_sysfs_lock. This creates a use-after-free race condition:
> 
> CPU 0                           CPU 1
> -----                           -----
> state_show()                    damon_sysfs_turn_damon_on()
>   ctx = kdamond->damon_ctx;
>                                 mutex_lock(&damon_sysfs_lock);
>                                 damon_destroy_ctx(kdamond->damon_ctx);
>                                 kdamond->damon_ctx = NULL;
>                                 mutex_unlock(&damon_sysfs_lock);
>   damon_is_running(ctx);        /* ctx is freed */
>     mutex_lock(&ctx->kdamond_lock);  /* UAF */
> 
> The race can occur with other functions that free or replace the context
> while holding damon_sysfs_lock, such as damon_sysfs_kdamonds_rm_dirs()
> and damon_sysfs_kdamond_release().
> 
> Fix this by acquiring damon_sysfs_lock before accessing the context,
> mirroring the locking pattern used in pid_show().
> 
> This vulnerability was present when state_show() was first introduced to
> access kdamond->damon_ctx.

Nice catch, thank you!

checkpatch.pl complains as below, though:

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#34:
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>

ERROR: patch seems to be corrupt (line wrapped?)
#77: FILE: mm/damon/sysfs.c:1279:
2.34.1

WARNING: From:/Signed-off-by: email address mismatch: 'From: Stanislav Fort <stanislav.fort@aisle.com>' != 'Signed-off-by: Stanislav Fort <disclosure@aisle.com>'

I know the reporting was made in a non-public mailing list.  Could you please
add a context though, e.g.,

Closes: N/A # non-publicly reported

The second and third ones should be properly fixed.

> 
> Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> ---
>  mm/damon/sysfs.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 1234567..abcdef0 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1258,17 +1258,24 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
>  		char *buf)
>  {
>  	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
>  			struct damon_sysfs_kdamond, kobj);
> -	struct damon_ctx *ctx = kdamond->damon_ctx;
> -	bool running;
> +	struct damon_ctx *ctx;
> +	bool running = false;
> +
> +	if (!mutex_trylock(&damon_sysfs_lock))
> +		return -EBUSY;
> +
> +	ctx = kdamond->damon_ctx;
> +	if (ctx)
> +		running = damon_is_running(ctx);
>  
> -	if (!ctx)
> -		running = false;
> -	else
> -		running = damon_is_running(ctx);
> +	mutex_unlock(&damon_sysfs_lock);
>  
>  	return sysfs_emit(buf, "%s\n", running ?
>  			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
>  			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
>  }

Other than the checkpatch issue, the change looks good to me.


Thanks,
SJ

[...]
