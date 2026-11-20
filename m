Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133587;
	b=vWKVtoZMa0L0VgxJ7ChfU3cQWVTo64PlxD5umcXwSQ/vqgk2qGVN3lyhnxX0G123hY+Z
	 jzFL6sqqyv7+IMEp88VwIK58K+aB16fAvMMJnV+1EepXnAI8ZCIwux0k6kY3iOzTbg6m2
	 xcwC7dC1AzR4V4U0TDrMY1wDEFVwEqXySnyEMiOi22Rt0khm/m0K6I8xoQzgwAAcIU2zc
	 gj8Vx19g1xJXJzu1plVihktPolhdnW2ouyvGKC+aB+R6pEzup1WZloxcW+7Kuv4Ptr2+M
	 24dlvxnmduZY2EjPYYQvq6N6UCHT+/yTsg/hijmkEHpgLG5tWONenym5JLTCObcPaPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9SB4EObKSw+tB9P4IbZtGcg+6FkG4Gy4Q2cjVejRkPE=;
	b=So2PlllBGDhzfxUDk2SD0YPu58jLXN9CQolLCqaG3Iz0XgI3LVB3q2e1iRTh4W0dJAss
	 CncipiOllm2K1mYh5CdyCnWEl9eHaeRgwNJ3kI6YhQ3aSxcRaje9cUV/6KpXzNG5m+5PV
	 PgtiyYElS990q3FeXcTOSQ7CqKYuzb5ftdSnY9NqUr37zXxcy41O9gfMmLjNUd2bjNekg
	 m6rbmeu4kxMFq99mAgeJZN0uw+6qtDcxRP58Rt5aKK1Vynz6WHpAZIAtOcTBHhZycdvh+
	 hje47foUDMgeUp0rwi0R4vaNHbyuW8dLU8of2N+1pO5Zom3BuCjzHhXu+6iVKZpVHyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDBw5KRi;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B48606A325
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B48606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDBw5KRi
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-949680e6d82so45850685a.2
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 16:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795133586; x=1795738386; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SB4EObKSw+tB9P4IbZtGcg+6FkG4Gy4Q2cjVejRkPE=;
        b=YDBw5KRi7CGX5ovDz/uMA88JSj4N360oZY5pJLU6vJjfRW36qeJ5unLSIQJ+LBxhFC
         VgfZP0vBn5jcrg5EvXYSb+YgXrDXspBejIafZVohiyEuwApMo7K5Pp5qDJh0WStfwQUh
         r+Ec+5bLMeEYXEIlQiVE8LfOyMBO3JJFfrD0evB6ZNjglvp6PM4UJxf9fYB3riiuzXpx
         jsyden0mK6G1WxeEQDCm+QMnHijv1jz0x4w45jZuRQlfnAhlj0IKgMa8FuJ1DvoZAjb8
         0vwU+EejWUjRuJmPvHUUh83bmNAI/1QwQcbadU+ZQyX19ovuLbbvBwVi0qd9xWaJdZe8
         NMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133586; x=1795738386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SB4EObKSw+tB9P4IbZtGcg+6FkG4Gy4Q2cjVejRkPE=;
        b=SrSXXkWz/sax7GqvuVQzJcELgr9JWCjXDJlmiyfv7Qr+xxbqepte94xm6/Flk4i3Ej
         6TZsUPH8K9AFnVt2hYvammfJtAgJcSNXepIA1quMjKkz1YyXeYS8kg1JWfxXx+xGdki3
         mUStx4xMrzwXKVwQGZFWbKJr9yMHOtNz8XotSZ6Q1+W5rWT3dcmA8q5fBQgKVItzc3NU
         FN1d2LzmaZQY0tKGiFmXmFTsPLqEilLEkySzrxH0aDuQZgrlKmBzOE2IAjUCm9KRr6Ja
         gYyvOYFaIUrPdm6wXmyhHtgfzaftYMd/k0nUqAL3XN2h2fCC5wHc7Q05LeotsDDKuN0B
         wRIA==
X-Forwarded-Encrypted: i=1; AL+hErG7N05kSDTH0pWJQsbuRkiNGDXDAkrho4VcCTo/fxtAjiYiCw5T5kT2boshJDcRZAwtXl6usQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+UD44bmvSBPcInd9Ar5ozC8bv42UKzSsu0eXWiqjeiz+jrtqHx
	j8gT37ppBM2/U09xy8+0v8mPmBDVVc0jscJqt48TfCPi6J8aIGbt1qQU
X-Gm-Gg: AZFdTZcpuh3rhRgAf03LIn/hMbnZzz8xbaYTBmrglqcq3sDPeX660bqq1fk6g5zttBN
	18zFSVDoMouuCn6JmJjF6EGunDcZU+0ozp9OM6Y+BZw0TOENEh8EM6neWtsj7K7cWobztR9fjgY
	2/klwolbf7Ji+3eCA9AUu0hmTbQYpU0vaTEiT/iRqekmGa2oprImRlTZAIh6t1cMPLRr87koGCM
	FRtdW6a3dr+2asGhZ6+fpJrZZGvYYAzqvCENeMVwVtamZd91U7qXyxp+bLKwI3DOrQeUHYRen0p
	akaFlAKwCcZr6wdyMXNpRnfzAYrEDuGhyoM44vOkKZaMGP2vfGY6Qe+XFU7Sg1dQUsTqc2TFT04
	uIfSCTKbq7xzlhy7tdDgxqKCVHSrc8hT2bfU6FXkMaNCqI+f0+QR/WXoamTjUBvnBe4ifaTHWJA
	XUnoznjeayiMj51BCCnn8VSF8TiBOyaLuU7qSphhpWheh9OQ26hGkvalJctKq/1TeWqTzWzCTUQ
	Te+j8mni/1DThICyEGyYdvM4u7XTetDAT/tCv9ZPPEQZ/ASRo1rCaDJ4R0hl2mYWo34kOA5lfLI
	1J9L2Qan3N8AsgbcEdsTMrj0nWD++oHshUFOBc+eMxtA2M/efNBFV/9oVWpidpSzlKk3YXFgrwv
	snGo1Fr6okEtGBxOlWVVoDR/tdP9VBlEA4mIv5ELpc53GEH7DuHz1srYvjks=
X-Received: by 2002:a05:6214:3a84:b0:921:3171:b604 with SMTP id 6a1803df08f44-92134b48c88mr23359986d6.54.1795133585733;
        Thu, 19 Nov 2026 16:13:05 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm8311096d6.41.2026.11.19.16.13.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 16:13:05 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_walk() hang with zero watermarks interval
Date: Thu, 19 Nov 2026 16:13:00 -0800
Message-Id: <20261120001300.11809-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261119014247.119946-1-sj@kernel.org>
References: <20261119014247.119946-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Nov 2026 17:42:46 -0800 SJ Park <sj@kernel.org> wrote:

[...]
> But, this could make has_schemes_to_apply has false positive.  How about
> calling damos_Walk_cancel() when has_schemes_to_apply is false, like below?

Thanks for the review.  You are right about the false positive.

I tried your change.  It fixes the hang, but has_schemes_to_apply is also
false whenever no scheme has reached its next_apply_sis yet, so it cancels
the walks of activated schemes too.  In my test (one stat scheme, default
intervals) 18 of 20 update_schemes_tried_regions writes got -ECANCELED,
and two selftests fail: sysfs_update_schemes_tried_regions_wss_estimation.py
and sysfs_update_schemes_tried_regions_hang.py.

What do you think about cancelling only when no scheme is activated?

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3492,9 +3492,13 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
+	bool has_activated_schemes = false;
 	unsigned long max_region_sz;
 
 	damon_for_each_scheme(s, c) {
+		if (s->wmarks.activated)
+			has_activated_schemes = true;
+
 		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
 			continue;
 
@@ -3506,8 +3510,12 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 		damos_adjust_quota(c, s);
 	}
 
-	if (!has_schemes_to_apply)
+	if (!has_schemes_to_apply) {
+		/* The walk cannot be completed while no scheme is activated */
+		if (!has_activated_schemes)
+			damos_walk_cancel(c);
 		return;
+	}
 
 	max_region_sz = damon_region_sz_limit(c);
 	mutex_lock(&c->walk_control_lock);
'''

With this the hang is gone, 20 of 20 writes succeed while the scheme is
activated, and kunit and selftests results are the same as on the base
kernel.

I will send v2 with this if you are ok with it.

Thanks,
Yifan
