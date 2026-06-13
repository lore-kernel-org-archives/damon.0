Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A637EFF8
	for <damon@lists.linux.dev>; Sat, 13 Jun 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365016; cv=none; b=HGqPxasbqPmbgT5RW5iSjRc8EgYMRs/d7084iS1Fn2hhDuoOpF3yoxZ4H8WkooSF0wq3FEohNjsu2HU1Y/bJu71tFGO9a/pGGDYSldSrl7BBhZ3sTw1pxm7gMvugRErY1l4rSPtvmkrRaw6fSqbS5KqjBHz01V4ZvQn+9blykQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365016; c=relaxed/simple;
	bh=5qsifoWP8fmSJQM5dHwZSEdbauOe3h4dtgn+oQ6R7fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAMzAThWKrcbzfBdxv8s6Np81vgBc4XAJqV1XrfzFbfdivBDgDlQibKEu1jqQBl6VYRig8u1/hkx+XZYNp+vmYegpL6maDpHh+eT9feNdLWROvtSC2t0kR89W20CKsHeLDnMDRiChDblL/LpkhU3TrQiXQ0F/GKLU0m7LHe/0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N4MmU8ye; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N4MmU8ye"
Message-ID: <683801c1-23a7-424c-ac8d-12a24961088d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781365009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAnta1paEwdFIQxih/xgWEJ4+KGJdhDjTjYkexN5zvo=;
	b=N4MmU8yeOUrd20h8DE2N3CrJynJuhtfy2OdKynqokByRbOz2lu15GrpNB3K1dOvVaJUE+N
	Z3cEr1BqUE2WZFHW+Wejet/iGlHgNbbc2zM60EMC7N9GfpAASmkSPZNWTVTRFoR4EeHDFJ
	ukvsUWELv05KfVVr/HIcMUzLDaYttmQ=
Date: Sat, 13 Jun 2026 23:33:30 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4 0/6] samples/damon: handle damon_{start,stop}()
 failures
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260610135546.64943-1-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/26 9:55 PM, SeongJae Park wrote:
> All DAMON sample modules are not correctly handling failures from
> damon_start().  Among those, mtier also has an additional problem for
> handling of damon_stop() failures.  wsse and prcl also have a problem in
> their damon_call() failure handling.  As a result, memory leaks, next
> DAMON operation disruptions, and use-after-free can happen.  Fix those.
> 
> Note that only the damon_start() failure caused issues can reliably be
> reproduced.  Reproducing those issues require the admin permission,
> though.
> 
> Changes from RFC v3
> - RFC v3: https://lore.kernel.org/20260610011420.3018-1-sj@kernel.org
> - Add damon_Call() failure handling fixes for wsse and prcl.
> Changes from RFC v2
> - RFC v2: https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org
> - Add damon_start() failure handling fixes for wsse and prcl.
> Changes from RFC v1
> - RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
> - Add damon_stop() failure handling fix to the series.
> 
> SeongJae Park (6):
>   samples/damon/wsse: handle damon_start() failure
>   samples/damon/prcl: handle damon_start() failure
>   samples/damon/mtier: handle damon_start() failure
>   samples/damon/mtier: handle damon_stop() failure
>   samples/damon/wsse: stop and free damon ctx when damon_call() fails
>   samples/damon/prcl: stop and free damon ctx when damon_call() fails
> 
>  samples/damon/mtier.c | 14 ++++++++++++--
>  samples/damon/prcl.c  | 11 +++++++++--
>  samples/damon/wsse.c  | 11 +++++++++--
>  3 files changed, 30 insertions(+), 6 deletions(-)

Looks good,

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>

Thanks,
Zenghui
