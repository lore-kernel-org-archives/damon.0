Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B543128B8
	for <damon@lists.linux.dev>; Fri,  5 Dec 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764929744; cv=none; b=MLJe/5GriZsuwcNrLWBWSV4rfWdN5cz9T3voRl0GWl9BQSgeFPUH4c0fDEpJyMfD28EOYqPUVXvlho1Oi7KzkwTGaBGvExmVWlozfBt08KVf7a2MHXTPNYKZJtFkX9Y5FQWBAtRSO+mhI/lpxW5BVcmxU/y1mwHaxG17qh0RMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764929744; c=relaxed/simple;
	bh=1+WXuoOh5kjX/p6qM3X9llii9TYOsxXHJxFFzUhF4V4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ll8HayL+j+CBtid5lL3MBFd71+VGsziK16dxh293iT2Mij2n0yeLzetTcroPzc5NEt0/SsQkKqhYqXJ4Qs5+A/w6VOvYecVjVvzTABVN60Dyqs14vn00WXxq+UUdR7IIuoWbQdEpbB9GUuG+ok+DFggN6b1vubulkT4tBNSG3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 535366cad1c311f0a38c85956e01ac42-20251205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:955f59a5-3b4b-429d-bd7a-dea09183ef29,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:955f59a5-3b4b-429d-bd7a-dea09183ef29,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:8a994e7d01d71d9bcc814bd90862e641,BulkI
	D:251205181532NSGTDAPV,BulkQuantity:0,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:
	nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 535366cad1c311f0a38c85956e01ac42-20251205
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1541234963; Fri, 05 Dec 2025 18:15:29 +0800
From: Enze Li <lienze@kylinos.cn>
To: Jung-JaeJoon <rgbi3307@gmail.com>
Cc: sj@kernel.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  rgbi3307@naver.com, enze.li@gmx.com
Subject: Re: [PATCH v2] mm/damon/stat: deduplicate intervals_goal setup in
 damon_stat_build_ctx()
In-Reply-To: <20251203080440.16096-1-rgbi3307@gmail.com> (Jung-JaeJoon's
	message of "Wed, 3 Dec 2025 17:04:33 +0900")
References: <20251203080440.16096-1-rgbi3307@gmail.com>
Date: Fri, 05 Dec 2025 18:15:24 +0800
Message-ID: <875xal44lf.fsf@>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hello JaeJoon,

Thanks for your patch!  I've a trivial comment inline, see below.

On Wed, Dec 03 2025 at 05:04:33 PM +0900, Jung-JaeJoon wrote:

> The damon_stat_build_ctx() function sets the values
> of attrs.intervals_goal structure members.
> These values are applied to damon_ctx in damon_set_attrs().
> However, It is resetting the values that were already applied previously
> to the same values.
> I suggest removing this code as it constitutes duplicate execution.

Would you mind reformatting the patch description?  The kernel community
documentation recommends wrapping lines at 75 columns [1].  While the
current length is within the limit, adjusting it for more balanced line
lengths would improve readability.  Also, I suggest using two spaces
after a period instead of a line break.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#subject-line

Thanks,
Enze

>
> Signed-off-by: Jung-JaeJoon <rgbi3307@gmail.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/stat.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index bf8626859902..51dd29685915 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -173,14 +173,6 @@ static struct damon_ctx *damon_stat_build_ctx(void)
>  	if (damon_set_attrs(ctx, &attrs))
>  		goto free_out;
>  
> -	/*
> -	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
> -	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
> -	 */
> -	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
> -		.access_bp = 400, .aggrs = 3,
> -		.min_sample_us = 5000, .max_sample_us = 10000000,
> -	};
>  	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
>  		goto free_out;
