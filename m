Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1A433051
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191493; cv=pass; b=hy13pREJl82KnNFDFQ7CiDYrTv+FLmgO2JItkpEiA32FUiAkkeq5EHShX0PzIw54XqWfqc1WMXYMK5hyLncYTiimJTqRwtuEP2KJIzI96FBOnuxwxrPec6Fzc5pWlatBc1+w90j6IlP2yf1xD2x8vHu9pua2lcN1d3uf5O6hCRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191493; c=relaxed/simple;
	bh=ChY0fe8uxN17uPp0rtFzK6B1YmEKykgx1fi2JdUkWNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQH6cHvGkxWSHc7w1mlg9Q7eTvhPMxhLM9KLFcUhH3jKCJ8oVn6k/FZMN1SCO4cAbEOYSeip+Ue+fDN3+0SindqI44KO5jZhZcslBu67FVMHBBzMSqQR+BXDyT+/sLei/UbIIZTkUHcU/hLy9ep4QoyrbgUxppft+UkYKw2vXpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp/9F5rY; arc=pass smtp.client-ip=74.125.229.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp/9F5rY"
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-15188ffe131so116776c88.1
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 02:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791191491; cv=none;
        d=google.com; s=arc-20260327;
        b=Gcn01XejvGXth+Ic1HDuZviHl542AiZAnry2RysK+7EsKS2PmXiQBmx7vyMLS2iVbM
         u/PBTaeUNcZSO+/QDZjRFg/k5Zj4RkKzoFRcNWPor/X+s8EVk1tyBJUgPjBt4wWqeLoq
         SHW90im7V6rBe0/6wGNqyJzHq5E47ReNORricoYvPilkV4rDTUxDvqFLd94zPITREPVZ
         Z8kYo7oj7MJbqwHM+bi5dYDIyvHRi5hZR+a8OvMzCfeoiKj230286Jkhc13E6A0Ux9hi
         3ohq+fiAKbjepZ/ncSszSjRD+0QqDDaglNP13dvtzGlf0Xj20HGvKfpIwiYWNS7eV3EV
         X9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nltl/oeRao/6F+EabSYNj0oW56X0G3LfHyr3jad4pvA=;
        fh=yRB7gP2lp0csqC1qwW+suiqlT5jVIIn9u8JLoms+dUo=;
        b=AmY4zJL+PPacl9TEW2ufd5gQ3H8OtyX3R4V+LcokBFvzOKi7Z40drq0PaBBI3BViY+
         1HZ2SMwgKETLoUlbgI+i/a+gFLwqdIM2oCP89KNZDycMRyKaELJsbs2JHifn9kfprHrQ
         qqimzD7xowpZ4tkoJfmB/uUiq2qnewRly9VtCYw1PyhlE/om8Sb6ON+WTt0gLEfRmR/h
         syHFD/mxkoDCl+rarGpHREpb1LpJNZtPKVOCZjOtTFeZuUvE8cfXvwbLUc0Qjlrei9/R
         99obnzwqds3Fv5CqYoeGFqJo0n94RyW97QNTPTKl/Ecxw27fA1iVZzIZGRw1b1cOt2as
         QynA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791191491; x=1791796291; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nltl/oeRao/6F+EabSYNj0oW56X0G3LfHyr3jad4pvA=;
        b=Qp/9F5rYVEMbFqQDKGuAec/YOVBvOSxoMz1rK1Fa95YWvIBTrsjJAQmh6iZ8T6y8R8
         Hdkr4Jn5QdcaU4ZhiyDcSDnhwch4GvnvXJcTmDpzbCje9M3qJnS78i3649NnFgQbR9ch
         guhYvcot3SZi+4ZxFeKpxBIuHatxjzRHZkzwJ+pGxq7nxitx/afSZ4yT+8UhWJyiwrGD
         dhH7DZ+YgzbdCm+MIqSQS2AG09tIghGQwdRHef46KnJIuSB0SwINYzeEEqf0taZZYMBR
         1pDCCR0wpFVlLjjJWd4vA/vqwSUYMlOGAIOSxX7K6w9OYP7Ab1827qT5vWN5s6M7MibP
         m19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791191491; x=1791796291;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nltl/oeRao/6F+EabSYNj0oW56X0G3LfHyr3jad4pvA=;
        b=lnz1NAsXY4mU75xCQvOwJykAZJzbVumkvSIGpY83aOHBb5tDKg6eruYIifDiqXUDTI
         AeN+o5esa/rC9X+VrlEAlvgMC09nXmdhVDXF8pWSVffOqDLkYrTE6WuB7VNE3542/fbp
         q7bfmGI88cUmvg0X3OBBSXJwIMVA/soJN0l5ni59I1DuuPbzSK39zPNoMPx66dBmikxQ
         ssgInK3Bl9WkLOFLaVb2M9bHDsb2GdtwcCITAqMkUVKnyyAhzDo1JKovnkZfCUqhq9Jq
         B7bQCdn/OAIkPB/e5FRRYJ9u1cO1G7gtzNjhipXddTNKIkXpFI7rUOTH8l7097QcI2Y2
         kceA==
X-Forwarded-Encrypted: i=1; AKwUvBwUYL1CbHu66XXndHP1UPZB+WNtvkkWUURH9VVDWBqLhT/KolQgPZTf74TW9ZofwRwr0KkP1g==@lists.linux.dev
X-Gm-Message-State: AFuF++k5DL3g6RbHbQFzssYzX1mNN3SwS52hEUR4Jk+Hi0zCDBumHjTP
	CFXHoihXmDS3Qu1diePX46jfbeqIjHccrxr2dgLaIQ9qt8jmKXWHUwvGT9YEMFjv1J9AuhHKQgD
	QJ7RDRL5euLyJSnJi8G8gX9Y/g09YLQ==
X-Gm-Gg: AYBFou1ZxHScPF6UM3tq+9KyDPgj29/8QYNmizp/QsURuNjNQbMpNvwyj99cIZZXEdw
	7datNnXwHAdusF1L1/A1uKKX7E+S07+OGr/ZTFNVmDFnPDvv/nRup1Wx13+GrjrmB5N0SaB4X1J
	gBUdng2SQTslcmDVnrFme4zwyssq12y0iQDO3smFejz8qT1OzBf8UTsk1O1KOMjBLLGQJE+iO3M
	8bSJQP5PnbTVp1pyFz7cowNmJV3ZFIh1yCQFYpza0snSsGCfSSh7mq7MfgZcpAXVij9ibEZcmI9
	yYiMs9Y16h4FWseAUIdRKBsBzRx4b89LRj+t8wrsCXzlL8AzjID9CM78+Q==
X-Received: by 2002:a05:7022:fa9:b0:14b:ff40:af3e with SMTP id
 a92af1059eb24-151c0b1c634mr16870099c88.5.1791191490914; Mon, 05 Oct 2026
 02:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-2-0f00417b41bc@gmail.com>
 <20261004091023.630362-1-kunwu.chan@gmail.com>
In-Reply-To: <20261004091023.630362-1-kunwu.chan@gmail.com>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 5 Oct 2026 02:11:18 -0700
X-Gm-Features: AclHuK9SLpvLjJzhBJihMA5kXTwHPEKQErl28l-hclZyIPjWGE7kxoL_9Ju2DmY
Message-ID: <CALa+Y14isN3HmsY9Mgtdi3O3zxOH33uTtajSbJcxm9FO4Uon=g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/9] mm/damon/core: replace the access report
 buffer with per-context rings
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, Wei Xu <weixugc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> Hi Ravi,
>
> I noticed that ring overflow drops reports and updates an
> internal counter.
>
> Since hardware sampling is used as an access observation source,
> could userspace get any indication that reports were lost during
> an aggregation window?

Hi Kunwu,

Not in this RFC.  While developing the series, I used a developer-only
commit that exposed these counters through debugfs, purely for my own
testing; it was never meant for upstream, so the RFC keeps only the
in-kernel accessors that the kunit tests use.  v4 [1] is the same in
this respect.

> Without such visibility, users cannot distinguish an aggregation
> result affected by report loss from one collected without loss.
> This may make it difficult to evaluate the reliability of the
> observed access information.

I agree that userspace should be able to see dropped reports.  Two
things to note before exposing them: the counters are global per-CPU
counters today, not per context, so a per-context interface needs
per-context accounting first; and when perf throttles a source,
samples are lost without any drop being counted.

I see two options:

a) a read-only file under the context or probe sysfs directory, once
   the counters are per context, or
b) the drop counts through a tracepoint, per aggregation window.

Your PMU-agnostic observability series may be a natural home for (b).
What do you think?

[1] https://lore.kernel.org/all/20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com/

Thanks,
Ravi
