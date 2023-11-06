Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179BAD21;
	Mon,  6 Nov 2023 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpFCHKcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52BDC433CA;
	Mon,  6 Nov 2023 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699281713;
	bh=Rdt3hTkEt0rry4dOU3WEMf9RmwFLUXqDzGIRpP0jJVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=bpFCHKcgiFORWu0nkbfmAvOWLbm/gLFQi9tT2UJ9w9CS+9XDXYJsp/sp5yg0IeL7+
	 0tLWVPAeArctdiC27TpswzOVLew+VueO9nJ4W5IrdDK3whDK+8yfchm1hkL430ISbi
	 HDwdLAp17wcmgCDsMaivy9yHSxYwqBtTCIdA5UHqfidGCxGfgA+Nd3UsEDXhqaBI9D
	 xCymGgc+PO95PA/aSa+fljDM/OEdnQMyUyRol3bFAIdQqQbKPjrD8xuFtYRGm2kptV
	 GMBRCql0/hp4jFb02CtcQ+PiOzz/71NUxhDfO+qCEZamoaRk2d53GO87nVMwWbvw0X
	 eiyJr1f+FL6Hg==
From: SeongJae Park <sj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: eliminate potential uninitialized variable warning
Date: Mon,  6 Nov 2023 06:41:37 -0800
Message-Id: <20231106144137.9772-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Hi Dan,

On Mon, 6 Nov 2023 17:07:40 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The "err" variable is not initialized if damon_target_has_pid(ctx) is
> false and sys_target->regions->nr is zero.

Thank you for fixing this.  I actually noticed this issue from Coverity Weekly
Scan of -next tree (CID 1570878), and was about to send very same fix, but you
were faster :)

> 
> Fixes: 0bcd216c4741 ("mm/damon/sysfs: update monitoring target regions for online input commit")

Cc stable?

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index e27846708b5a..1dfa96d4de99 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1172,7 +1172,7 @@ static int damon_sysfs_update_target(struct damon_target *target,
>  		struct damon_ctx *ctx,
>  		struct damon_sysfs_target *sys_target)
>  {
> -	int err;
> +	int err = 0;
>  
>  	if (damon_target_has_pid(ctx)) {
>  		err = damon_sysfs_update_target_pid(target, sys_target->pid);
> -- 
> 2.42.0
> 
