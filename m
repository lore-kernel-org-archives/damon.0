Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7D31354F
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110088; cv=none; b=rhYb+aTCvVlHM9TrKeRDtIMxJFVvKv3CRZXpzcWzm+NsCBYXvb4zaLUE7h2lhy03wuRwg4uRDPniRD7c5s8zhD++Suci5HJuD7izUWxZTvyzU9G9S96Mhtqe3rFhlzSnunmIon4kE3NSe0uPAeMqLCpE+dpE8A5xxBpnPriETzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110088; c=relaxed/simple;
	bh=gbImrM9FNhWfzIcc5SM9YHAkaE+9GxpeCFQlXGliPrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLlKAdUaNRyhTdYn1382yHTBa6JheR6cwGg7d4+3g+J2ESeo5EwsgispUZO8rbmQdWn7WnF77z9fpWL0naWN/nuqSt1D4USdhZ6zmqegckLkXLHals/GwOW+kiIX8XgXOrmoAbRWX2Nk3vWfmdOlS8RFtUvkvsUYSGhn7231MF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yko4Q1w/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yko4Q1w/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1785969a12.1
        for <damon@lists.linux.dev>; Mon, 13 Apr 2026 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110087; x=1776714887; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LBTdm0r6/3UpNGKJqwUrmmrep6dE2YfGJg+Y3TeQvI=;
        b=Yko4Q1w/iF/HK4SJfluEK8rMD+qxJFJLttj21MieUlTSgNC8A/BVpG5U6dyL+WqQ8x
         THF9WPgOY2wnBfUnWD32899mwBqo5Gex3hIAbty0C80Xc/BovbwPgjunB5CFTRB3OyLS
         rNy3NrrgOrbLuoRY6I5iFsIMBBi3kPh26LAcSX6P3OEjNKvJtjpVHoU+Guts2w5yAVwM
         U0EIEsC/cw6NZavXqizYYjYAlWVeNZOAPowNEMYugGfh5bHFbJc6sFl1M33ZzlR7u8H+
         GY8WRovcg5VA9L4B+Sl5ukFafqqBlimb1u4RgzonEY5YY7noZTCU3VYwaSNBWDLDJ9aU
         AHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110087; x=1776714887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LBTdm0r6/3UpNGKJqwUrmmrep6dE2YfGJg+Y3TeQvI=;
        b=mg/mThCNHNofOXPkVeQ0jCGQcE1Xd6/zkRpEaUp+qxImFChQpHoViLeA/VkeUEsYB5
         EDNDQYhWDI/VLt1wh75sYiDvFpwDaNlq9ScAptGHC2Ratss6W4Tes7qrJQnUAsJ9W1sV
         ntGnSB67r0NHgVy4YjICjZ8VwIwqp4NiIycJOUlLno//8igkJFbilL4EGC53QxFRSaAm
         +ureyT3wg/pVTqHolWjs9b7upYzKw8vfGXffCZxMWmHyAKKnUcMly8KPF/3hYQe04QJ9
         CCQmRerEV+zM1rCb2nSZqIc486Ijqmsdi/BuHbocsjEm5yXW713TOMQ1Rt9bS23plgib
         uFsw==
X-Gm-Message-State: AOJu0YwgLVj6WzZAPvPqzG7nnKOGBfj2UhgCP1y8L9xejabPsomGCd4A
	imq2vXuX4KXGojDh0gsshQsArMyjQ8yyb/dttfNFEkxAL19yjjjqigbK
X-Gm-Gg: AeBDiet722ZrCXSUNQCQH9ztlb72CRYtFH9s3pcyvDlQ+jOC7oE8NT0MT0hhmjgtURQ
	Ty5oPmzCwvAgcG6WRyaxIz1MWBAowyOZuyUZel7wA1GrkYf10lYFAWr5C1pWQvM8vd2bOOZ/t9m
	6y+dxIn68FKoVU1sT1EjSFZ1A/5+Za88npOlMz4xqUaKYmKp9mrkveXZftok/MycCymthf5Mna7
	NWKQUvAFqWddFQvQi7fPqBwykKhgY2PJA1VaxU8GMsQUyikzUAt1Adh5DUCbrNIFp9P8aYjIaQb
	aJ0+fwfV6PE6evoJSXsiSfglL2IOKtosW+n1w2iHIRxbvKnRU8Ks71JyBfeiX4Bpnw/jd6wABrY
	OVKekcHQFFTzqocvXNC+twUKsSzO/H1hhB16u+99LT/UQ4bmEjIIlBm+KAi+uvfBncR9+gnHC/C
	5bp0N2XhlhCcNS23NogVr3H6LMaKW2PjCim+OFEOtSjfxoD+02XiI=
X-Received: by 2002:a17:90b:4cca:b0:35b:9e53:e2df with SMTP id 98e67ed59e1d1-35e35335015mr16924314a91.2.1776110086652;
        Mon, 13 Apr 2026 12:54:46 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35155829sm16717956a91.13.2026.04.13.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:54:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH v2 1/2] mm/damon/lru_sort: reset thread status parameters upon kdamond termination
Date: Tue, 14 Apr 2026 03:54:51 +0800
Message-ID: <20260413195451.17184-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413185249.5921-2-aethernet65535@gmail.com>
References: <20260413185249.5921-2-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found some issues, so I will send my comment for it soon.

Forwarding sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260413185249.5921-2-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit a943fcfe60e73956b72cad5a625120222653bdda
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/lru_sort: reset thread status parameters upon kdamond termination

This commit adds logic to reset thread status parameters when kdamond
terminates unexpectedly or when context commit fails. This ensures the
module does not get stuck in a state where it cannot be restarted via sysfs.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d729760..96c8d0dfcafd2 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -344,6 +344,10 @@ static int damon_lru_sort_apply_parameters(void)
>  	if (err)
>  		goto out;
>  	err = damon_commit_ctx(ctx, param_ctx);
> +	if (err) {
> +		enabled = false;
> +		kdamond_pid = -1;
> +	}

Does updating the module parameters here require holding kernel_param_lock?

Since damon_lru_sort_apply_parameters() can be executed asynchronously by the
kdamond thread when a user writes to the commit_inputs parameter, changing
these variables locklessly might introduce a race condition.

If enabled is set to false here while kdamond is still preparing to terminate,
could a concurrent sysfs write (echo Y > enabled) read the false state and
proceed to call damon_lru_sort_turn(true) because it incorrectly assumes the
worker has completely stopped?

If so, damon_lru_sort_turn(true) would call damon_commit_ctx(ctx, ...) and
modify the shared ctx structures while the exiting kdamond worker thread is
concurrently executing its cleanup block, such as damon_destroy_targets(ctx).

Can this concurrent modification of the context lists lead to use-after-free
issues or list corruption?

[ ... ]


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260413185249.5921-2-aethernet65535@gmail.com

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260413185249.5921-2-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
