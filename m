Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52A1798F;
	Tue, 19 Aug 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618967; cv=none; b=YScrIpvXm/OXJCW8q8BzDngK4OqEsrOGbXy3jS/sgDuSRfqw0+W41yJmT0z37+q6Y9mXlZVvRAyYTHFbLn/1FOJHsX1RRgvsWw4jmstamV7IdnFi59IpSqByZw5G41XRk3hULSkhmQmO7c1ukI2rNK6oNzpHo0s18t8OFnQac54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618967; c=relaxed/simple;
	bh=398xSgeKockn+VZiMVa3lgHKcNI7Vuh9qOLHZCyHk1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7YdLytbknMFXnICzbWFLNPE+b61P2js0ADicSOTMKOeBsaHPPWIP1JpjN2RzQo5oeXq3YOOxIL7Gx8i5KFJVZotI6hf3DwpUDaVSut8fF3sMfZicPiGJ2HpLt8vgJRT+aI6OiUlPQjpoMyg9sMLODyMoLuOrvdrNzzlEBEhWPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+FnP8Ll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+FnP8Ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F00C4CEF1;
	Tue, 19 Aug 2025 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755618967;
	bh=398xSgeKockn+VZiMVa3lgHKcNI7Vuh9qOLHZCyHk1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+FnP8LlLp7ASlisgI3sVzfWvuMXSm1BvTxfqwLdTIgy2ARBLytzAJvpb64jBtfuR
	 9Ge304LXAJSyB6Mr7oR3sRZ9rALxVUjvR666lFoIguqGUix6I3CM10NWFmnpGBlc2r
	 dZcmObCMzld1Q73JWSWk06PSlGsEPamlo6HfcMBVuw/mf7W/Fa3MsYlNjLMywDu4L3
	 wEm/199F/QMOyGf253LuAjQs7akb4UFnkpQGt9vuaDZ5case9fZ2qq5touwUrV7Vbt
	 d3TnrtEgzzeB7kWmgItQ2FL0tE7twzGlwCj2BwakafuLtFVouPERms35kFkltVA1ZM
	 8Ljs5MgQqUtwg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 07/16] mm/damon/sysfs: implement addr_unit file under context dir
Date: Tue, 19 Aug 2025 08:56:04 -0700
Message-Id: <20250819155604.43810-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <c3050ee1-a3f6-4f3f-8cd3-a5d67dcdcacc@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 22:45:58 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Hi SJ,
> 
> 在 2025/8/19 14:24, SeongJae Park 写道:
> > Hi Quanmin,
> >
> > As I suggested on another reply[1], please squash attaching patch to this one
> > when you post next version of this series.
> >
> > [1] https://lore.kernel.org/20250813170224.6128-1-sj@kernel.org
> >
> > [...]
> >
> >
> > Thanks,
> > SJ
> >
> > ==== Attachment 0 (0001-mm-damon-sysfs-return-EINVAL-for-zero-addr_unit.patch) ====
> >  From e0a5aa5e571ecd0f58b0914f8fc8562a60014ae8 Mon Sep 17 00:00:00 2001
> > From: SeongJae Park <sj@kernel.org>
> > Date: Wed, 13 Aug 2025 21:17:03 -0700
> > Subject: [PATCH] mm/damon/sysfs: return -EINVAL for zero addr_unit
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >   mm/damon/sysfs.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index bea782b0a711..eb4269383bae 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1422,6 +1422,8 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
> >   	err = damon_select_ops(ctx, sys_ctx->ops_id);
> >   	if (err)
> >   		return err;
> > +	if (!sys_ctx->addr_unit)
> > +		return -EINVAL;
> >   	ctx->addr_unit = sys_ctx->addr_unit;
> >   	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
> >   	if (err)
> 
> Aha, returning -EINVAL when sys_ctx->addr_unit is 0 makes sense, but I wonder if it
> might be better to prevent users from inputting 0 at the source instead? I've attempted
> to modify patch 7 by adding a check in addr_unit_store.

I agree that is better.  Please don't forget adding your Signed-off-by: to the
patch.

> I'll send out the v2 version
> of patch 7 later (PS: I am performing a comprehensive validation of the v2 patch series),
> and we can discuss it then.

Looking forwrd to the patch! :)


Thanks,
SJ

[...]
