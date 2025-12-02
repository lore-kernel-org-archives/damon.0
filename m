Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656E18BC3D
	for <damon@lists.linux.dev>; Tue,  2 Dec 2025 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642694; cv=none; b=Bf3K5iiqy+tlZYJdToJgpfvmroGNE/MkjcdnWS49jO08Za2xTGARaXu8drjSNhtW4KtB4XxY/Yrx6HKKfQdVrtHAg+LW2nN2l/4h3waKUBe1qlqSwcDjYiuewv52FoSewJtnnwNxsjAPnIBdIi0jK4txw4dP5DkhL3wLzPoam6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642694; c=relaxed/simple;
	bh=sHKzLp4p+J++iilUivyYsgD70RsWMbhqAcI3Lnlyo/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mL2yqn3tqad3kHeEfp0BM05o3tPuzaoCbbS/t2Y9yl7U5TEkXZqmGt+Dn9TfPnfqajMrLv9hrV7sUJjIa2YglnWhtjsNDYzGRFrOK9PD01s/pO9rxBB09Qg+Q/fYOxpIexDmzl89CM0/Pna525N1sQNf4PRi6bxHcqoJCfaBorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fda16c16cf2611f0a38c85956e01ac42-20251202
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:0340e088-8886-4e8b-b737-9cd91a7a2b38,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:0340e088-8886-4e8b-b737-9cd91a7a2b38,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:20bd76f10c9bd4ad895830f7141bf70e,BulkI
	D:2512021031260E6B9Z8S,BulkQuantity:0,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fda16c16cf2611f0a38c85956e01ac42-20251202
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1310363433; Tue, 02 Dec 2025 10:31:21 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com,lienze@kylinos.cn
Subject: Re: [PATCH] mm/damon/core: support multiple damon_call_control
 requests
In-Reply-To: <20251202021407.11818-1-lienze@kylinos.cn> (Enze Li's message of
	"Tue, 2 Dec 2025 10:14:07 +0800")
References: <20251202021407.11818-1-lienze@kylinos.cn>
Date: Tue, 02 Dec 2025 10:31:14 +0800
Message-ID: <87zf818vil.fsf@>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


FTR, this is my testing patch for samples/damon/prcl.c based on tag v6.18.

8<------------------------------------------------------
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index b7c50f2656ce..94fd6184fb14 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -39,6 +39,7 @@ static int damon_sample_prcl_repeat_call_fn(void *data)
        struct damon_ctx *c = data;
        struct damon_target *t;
 
+       pr_info("repeat_call\n");
        damon_for_each_target(t, c) {
                struct damon_region *r;
                unsigned long wss = 0;
@@ -52,11 +53,22 @@ static int damon_sample_prcl_repeat_call_fn(void *data)
        return 0;
 }
 
+static int damon_sample_prcl_repeat_call_v2_fn(void *data)
+{
+       pr_info("repeat_call_v2\n");
+       return 0;
+}
+
 static struct damon_call_control repeat_call_control = {
        .fn = damon_sample_prcl_repeat_call_fn,
        .repeat = true,
 };
 
+static struct damon_call_control repeat_call_control_v2 = {
+       .fn = damon_sample_prcl_repeat_call_v2_fn,
+       .repeat = true,
+};
+
 static int damon_sample_prcl_start(void)
 {
        struct damon_target *target;
@@ -109,6 +121,9 @@ static int damon_sample_prcl_start(void)
        if (err)
                return err;
 
+       repeat_call_control_v2.data = ctx;
+       damon_call(ctx, &repeat_call_control_v2);
+
        repeat_call_control.data = ctx;
        return damon_call(ctx, &repeat_call_control);
 }
>8------------------------------------------------------

Thanks,
Enze

On Tue, Dec 02 2025 at 10:14:07 AM +0800, Enze Li wrote:

> The current implementation only supports repeated calls to a single
> damon_call_control request per context.  This limitation introduces
> inefficiencies for scenarios that require registering multiple deferred
> operations.
>
> This patch modifies the implementation of kdamond_call() to support
> repeated calls to multiple damon_call_control requests.  To demonstrate
> the effect of this change, I made minor modifications to
> samples/damon/prcl.c by adding a new request alongside the original
> damon_call_control request and performed comparative tests.
>
> Before applying the patch, I observed,
>
> [  381.661821] damon_sample_prcl: start
> [  381.668199] damon_sample_prcl: repeat_call_v2
> [  381.668208] damon_sample_prcl: repeat_call
> [  381.668211] damon_sample_prcl: wss: 0
> [  381.675194] damon_sample_prcl: repeat_call
> [  381.675202] damon_sample_prcl: wss: 0
>
> after applying the patch, I saw,
>
> [   61.750723] damon_sample_prcl: start
> [   61.757104] damon_sample_prcl: repeat_call_v2
> [   61.757106] damon_sample_prcl: repeat_call
> [   61.757107] damon_sample_prcl: wss: 0
> [   61.763067] damon_sample_prcl: repeat_call_v2
> [   61.763069] damon_sample_prcl: repeat_call
> [   61.763070] damon_sample_prcl: wss: 0
>
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  mm/damon/core.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 109b050c795a..66b5bae44f22 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2526,13 +2526,19 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
>  			list_add(&control->list, &repeat_controls);
>  		}
>  	}
> -	control = list_first_entry_or_null(&repeat_controls,
> -			struct damon_call_control, list);
> -	if (!control || cancel)
> -		return;
> -	mutex_lock(&ctx->call_controls_lock);
> -	list_add_tail(&control->list, &ctx->call_controls);
> -	mutex_unlock(&ctx->call_controls_lock);
> +	while (true) {
> +		control = list_first_entry_or_null(&repeat_controls,
> +				struct damon_call_control, list);
> +		if (!control)
> +			break;
> +		/* Unlink from the repeate_controls list. */
> +		list_del(&control->list);
> +		if (cancel)
> +			continue;
> +		mutex_lock(&ctx->call_controls_lock);
> +		list_add(&control->list, &ctx->call_controls);
> +		mutex_unlock(&ctx->call_controls_lock);
> +	}
>  }
>  
>  /* Returns negative error code if it's not activated but should return */
>
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
