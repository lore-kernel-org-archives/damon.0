Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FCB2417D1
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400827; cv=none; b=rNg78hhXzb8SHZceD80iJgVwvWjGyupl5PaJJge7zniehLA4v/WMzDrWdbtub0oZFV9kzbpDnE/J79E3QaRURs1uDPkuBZ3kEqwY45G4LdjuouwYbvk0kNYVcK8AoOIG/yrPLjvuDwiTwJrDsyRNwmZ575x4haA08WyNKJnr/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400827; c=relaxed/simple;
	bh=/CP95G0PR3H0g0ykJcTxUmn6njWoypYNANPsfaXRf3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw5LgIg2O5TGTbUHAzUkXuTr80bCMDCRkVnSwOYSiQNeNHVEenl6PdsHHnzuXum9bO366JEIDghn5vb/Nrp3K9InJSjAlS40EBT48Kblm9epVhXA5lbwAEDDqQDZO53uCeF0XgWnuJjJT3oTkHWU6z5E++qMS78r3zcV2Xf80zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEzJUyOe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEzJUyOe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d72ae08fa1so16217925ad.2
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788400825; x=1789005625; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozJ9M4cDK/IvV3gntKv2Fb/293HION6/QD0PdVWp1Zs=;
        b=MEzJUyOeEOyjzAIWZI4SxYgemsGufTsLEZbZC0S/DjsXf+M3DOiUHcAyjiCMli6zxu
         NKlChK52I6SSXD3DhGEtTnePe/uJfnU7RhPjD4Cq+jkHzHuQ+xWNDvjLNaeshFk2kzzK
         490rZhXYSmtE/zBSo6O7oIOSYSqR+MgPdy37eIuMhOQPdz8ZNOu+i06d2fhoZJEs69u4
         NPHzR5ltZKqD4XreqK7u8EM7wJCBjExcPpsm2mjV508yNNls6LZt0L8v6uVLfiq56ZTZ
         EGOUJsQ47AB0jzbX17ngnNJAuQNPGnenEL1LeI8h0mzrryQaDxygDOQPIi2nfMj6Ch5r
         MngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788400825; x=1789005625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozJ9M4cDK/IvV3gntKv2Fb/293HION6/QD0PdVWp1Zs=;
        b=AuMGwgGZdrfepHiUyetaPigMyS6B/XrLp5Sc7GGwjLrSvlswHzF/3JASDpxsFccOiZ
         PwWL+Hq3YB66R8p9qB1QXtRzQ1U5WZ8wMfmcNz7Noye9uMidd7fJBVl1hgAa1Rbs5ZlO
         ngYpZuCc1dAJX4fUB5LEcAUbegiAdZ5FypWmALMHz0dZ0gujTr5jTCHbeSwtAAoQMU4y
         bdHrncUbt6KXPxIt5dAMtP6b2cyhdF83kxqUcT9ouUC0ugnJnrw03GVX9INsFLb2g8YJ
         R3FbwwD9fRAEhsJEZ4EkTaWNImZNw0P2RNI+brj7SJ38nFdCAx4mq/5y5hMmTxVqGZIe
         seNg==
X-Forwarded-Encrypted: i=1; AKwUvBzUaF0zkRCk1zAtvk+w8hw97eR0WImGuOSwzdJ6COtME1Br/opg6xAEWgNoUk3cNW50CnJywA==@lists.linux.dev
X-Gm-Message-State: AFuF++m1NIsbmMXpYHfNr7IB9+WNlvch1nS0h65aEIaBNOzznWpaQi3f
	FK+QLB1TwdGJ0stRWmfpoLnVhwOmTr9LjSKwatUelISOc2o/01HcFmvVCekFnS1+
X-Gm-Gg: AYBFou2y62/R75BrTnnkEAPokJMylGfRc/f76udkppLySDRiOpWRXXJj/76LrM8WaDo
	eULksdEYktknMQm5XGWr4ZEaPx7VRz6EMR41bU9qdY+vN63DcBUsWS7G9OpYoLEDlEmdqbRVaev
	5t35n224U4ft1MtRFi02YUIQSQ315S0jnTEnrftXcqELg19NInQ5Hmvncz3kCHH/E25ZjdMlVgh
	Xzl/KZL5GokbCpcPhYmfbrEojWQyC7/nTNJirYcmDKIAwo4mbpbhN3fEp3DZeRPJeTU0NIpquoY
	TDDorbaXJkOqvkcGWXQt6J2rd4bWHEmveYgURBBg1StuHwpwBXLGOpXGaRe910XT7AhmpQCInCz
	OCJVHL3k1i+NWM+j2pwaO5uRc2aCCmmS/kfpLkyah2p4EqTTBceMykXTeOIxJz2pr0HTRX5x7Gw
	vMuTTedPgPnNsX11NE7eO4+hZw4g3YOmmZ1bsIglymMLWOtoVKrGhnJfby/0uaiOGSso/1lA==
X-Received: by 2002:a17:90b:5107:b0:398:e6b6:acc1 with SMTP id 98e67ed59e1d1-39aee066eaamr13504509a91.15.1788400824555;
        Wed, 02 Sep 2026 19:00:24 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm2179825a91.14.2026.09.02.19.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:00:24 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 01/12] mm/damon/core: use damon_nr_samples_per_aggr() for max merge threshold
Date: Thu,  3 Sep 2026 10:00:08 +0800
Message-ID: <20260903020012.4160595-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902054747.99370-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:34 -0700 SJ Park <sj@kernel.org> wrote:

> kdamond_merge_regions() open-codes max region merge threshold
> calculation.  What it does is fundamentally the same as
> damon_nr_samples_per_aggr() but missing a few corner cases.  The
> unhandled corner cases should be rare and make only a negligible level
> of monitoring results degradation.  But having the inconsistency could
> increase future maintenance burden.  Use the dedicated function.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f748acd6bbd5b..846da6df5b552 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3509,8 +3509,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
>  	unsigned int max_thres;
>  	bool count_age = true;
>  
> -	max_thres = c->attrs.aggr_interval /
> -		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> +	max_thres = damon_nr_samples_per_aggr(&c->attrs);

The helper replacement makes sense to me, and it also keeps 
the corner-case handling centralized.


Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu


>  	while (true) {
>  		nr_regions = 0;
>  		damon_for_each_target(t, c) {
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
