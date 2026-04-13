Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140851684BE
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110247; cv=none; b=PUYrjdNb3W2FRNVU5X6mh7FdwrGv8JRs/s1hElDCu/xEb8oGKRw4iM3Ni3tIHwebV0dxDUI44HgHi2Q3kELnIJiiHGU9jLDaAZn08XpXIWTkoF8ZZQOS8ktpbyMQpGUiNWFZZOujvkUDN7PreweNvK/tbkbSpJOTRnnPZvm5iIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110247; c=relaxed/simple;
	bh=vucEQxE9oVDeaUyvXf6heJqWnyP/wCj4LiM6PR4aFrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXhksqlXzL1zwqlZCJ+7gPgEHOvcyHlL69YZAOJxAIYoPN43iQz+mZ5qwujCJC2Icxu+WTHkmPiP2yQ5rBzSv10wTN/e7BY+6RJDlmFh6MzDUkXFWaZ4IY64a3X+NdLbmgioV2ZuoVm7YwRJhNkVdPDuS39vcmNXCuQeau0Cfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDSAB5hE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDSAB5hE"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c742723c863so3111273a12.0
        for <damon@lists.linux.dev>; Mon, 13 Apr 2026 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110245; x=1776715045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQesWBA0SakvidWM6gQk3GOHIWTseku/UPhU1Pz5m2g=;
        b=TDSAB5hEuEfXpOjjurDt2/XkxqvCn3ZIid2sBactq5nfHSpfO0nwZ1i7Vhaj6uata8
         w1Q2RGygEBUz4TFQsEk82e0iwek3FJVq668OFS469YnHq6lINCrUJf/3P2iNnXZvvyDI
         InWhHIgrgM/uzp+NN/AVpj5IqbWOyvSs2gXEdZbkiUXDGaxGwnvoVJCAIwF5RTKOHBUo
         h0n7wrRm7YoRLRfX2E89DlX/ZKgk0CQ+Pd1mKpWlPLmrl1UbKG5CpMALfXcssvme3xjS
         tzDuGybuAQseC35udRkSUh6cepImFPhQ8Ru+/Y48CpUa7DftGTaeDi4Amcperg8dQVo+
         AI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110245; x=1776715045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZQesWBA0SakvidWM6gQk3GOHIWTseku/UPhU1Pz5m2g=;
        b=GOQm+bXbxUxn558iEari1xh/PT0FAkLx1C6qZlMEzRul+U2UDXmlcG2UqK+F3/rkpx
         /mXgfqtVyv+UkxtwO6s/fD6COSiZwWr+EQVBmaU4iNXvccUlPKgyPYLMZ7L08QEGt1w+
         X4TczzC1mUhLkpggCzht85HoXUmM7OKYg2y2PJm/7MoyVHXnqvTDGKV4tHn+PL9PraZN
         3FkcrJYnahas8qalMPQIo8/S36KIhTEyRZlVUyKfO02Wz/SVFmL5SQ+s8pAbiaEPvO9i
         YAxsIKJGCWThHtLLTfo0AxRTSzKUW1eOVeKsep4qQJHhiUiJTTSyFaZfen6iKBNkKvuR
         jy5g==
X-Gm-Message-State: AOJu0Yzo07dLrEMol+A1dponsBCYD17Lv/kAifcXjLp9yG5FZnt/g2jB
	loZyjzVTkG6+ZYy0wLpAwLv7q4C4eg898VUD6JWopOg3QMQdGAjfluvP
X-Gm-Gg: AeBDietY7j0KJpea/oyeZzo1mYs3NT4aWiX5uW3tOA39s6bww9gKXjvYZwcMWqKXKoA
	HLsqYxfq84WT+nye+xc3JSmGQLr3LSkL1dNjtjRSorQXgE8Kf6lMt+WnZFNWAJrcn6syHnIzju5
	wJartp0ddk7uC6lGysmS6pR+STtcRUDGW26HcOBDdKjbdynIIv5jcyaw4EJHKZOW5YO+31M3UXC
	HAPWUKzu/3dxa65FQBvuUvYiE+rIzZAAVd0OukGY/DxNmSGWHQ/MFFnimKTgh7bQi47Ti2xR/u5
	e9jzrO6UZKx4fKSgVKQCvq1zE6lps/SqHW+euowU99IQWmPOWWns9MJFMdh8IkRW4pbyWa/kYWl
	ozsVgBl+XwwliGuqHiIcML4DFYSo02VwS/5pvm4Er4s8Xi0KgBJZZl512E4CQRxUrSVgrZdwGCf
	TPFM5k+c1e4xXxhDPkPa29lruLdEdp3ziwIS9ZZ/XHC/4Dfod3+FU=
X-Received: by 2002:a05:6300:210f:b0:39f:706d:630c with SMTP id adf61e73a8af0-39fe3d8b842mr15287754637.22.1776110245459;
        Mon, 13 Apr 2026 12:57:25 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216fff97sm11417016a12.7.2026.04.13.12.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:57:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH v2 2/2] mm/damon/reclaim: reset thread status parameters upon kdamond termination
Date: Tue, 14 Apr 2026 03:57:29 +0800
Message-ID: <20260413195729.19302-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413185249.5921-3-aethernet65535@gmail.com>
References: <20260413185249.5921-3-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found some issues, so I will send my comment for it soon.

Forwarding sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260413185249.5921-3-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit cefd2ed657fa3baedb834d79191ef3af7c5363ac
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/reclaim: reset thread status parameters upon kdamond termination

This commit aims to fix an issue where an unexpected kdamond termination
leaves the enabled parameter as 'Y' and a stale kdamond_pid, preventing
the user from restarting DAMON without a reboot. It adds fallback logic
to reset these parameters when damon_commit_ctx() fails or when
damon_stop() fails but the thread is no longer running.

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da147786583..e3e148fd80f97 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
[ ... ]
> @@ -250,6 +250,10 @@ static int damon_reclaim_apply_parameters(void)
>  	if (err)
>  		goto out;
>  	err = damon_commit_ctx(ctx, param_ctx);
> +	if (err) {
> +		enabled = false;
> +		kdamond_pid = -1;
> +	}
>  out:
>  	damon_destroy_ctx(param_ctx);
>  	return err;

Can prematurely resetting enabled to false here introduce a race condition
leading to a use-after-free of the DAMON context structures?

If damon_reclaim_apply_parameters() is invoked from the kdamond worker thread
(for example, when applying commit_inputs) and damon_commit_ctx() fails,
ctx->maybe_corrupted is set to true. This signals the kdamond thread to
break its main loop and begin its teardown phase, such as executing
damon_destroy_targets() to free lists.

Because enabled is set to false asynchronously here, a concurrent sysfs write
of 'Y' to enabled will succeed and immediately trigger
damon_reclaim_turn(true). This unconditionally calls
damon_reclaim_apply_parameters() and executes damon_commit_ctx() from the
sysfs thread.

Since damon_commit_ctx() locklessly mutates and frees items in
ctx->adaptive_targets and ctx->schemes, would this race directly with the
still-exiting kdamond thread traversing and freeing those exact same lists,
resulting in list corruption and a use-after-free?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260413185249.5921-3-aethernet65535@gmail.com

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260413185249.5921-3-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
