Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC976026
	for <damon@lists.linux.dev>; Sun, 29 Mar 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774770671; cv=none; b=h1rmTLFufkbpWZEdrcYvN7v/6tzQFSZ30pAvCaRDk/O/4iLoapDcD3AyakxuRd7kFzYaoMVzUkw2ptHzPN5ZxH82gPtkBAmejzVgnfl5vN/bmLQ4ypXt79ggxh/A7OmxEwgbifSm0sAJtaUFzKaM9iSV+UbnWpZGshrkwwKp8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774770671; c=relaxed/simple;
	bh=VagBCjOAmqGtcIP573GJKhHMQOl5GJ+rBcdsAqFkk1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2EskcI0L9Hnq7BWq0F6sgJ1p9R1ACYWuc/k8qsoz1YCKpivtbWLQHtExVuNNmx+oBToU1Aezr5LpzX+VgigtccSPLSnXuQIsDyL2O6jM+pgCQ35e8Gq8b4FClF1Zew4xyzhWiZsFTq5fuzEKtYg2vFg8N3VD9MQm/xpSRil1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h87kuT0E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h87kuT0E"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab46931cf1so33016695ad.0
        for <damon@lists.linux.dev>; Sun, 29 Mar 2026 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774770669; x=1775375469; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/zNXWiIl+tZEAjY7M4NR9oxOyQa+xvxVl9yEshVfzs=;
        b=h87kuT0EElo/wtO0J59iVGv12NJUxMrKaFSNdbe/StzJhFVksdVxLwWW+Q9b5Mla2c
         OYz5v1KxIGexwv6Nhsoa2VJK1jQqfejI6as0MaAd7wYUDoMUUbwOQJEuZouDbzGr9CUV
         VfS291aXGX/bGgSeA88bpIcEzsF48TdvLfNkWsyYW4oihy0cLvxl/2wjBUHUc/k3c1fu
         Q3yJirN4ZXjv+SGNkGMtj3mWxq2zaNdXGFXA29R1Ca/pHJZ+CxohZJWEA9T7cizJIHMe
         6QEynZlYf0Q3/OWDXfvCI3H33PySwJyolZTyuoku1hLgsHZMEw/tnJN+E9yz0CWww12a
         APWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774770669; x=1775375469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/zNXWiIl+tZEAjY7M4NR9oxOyQa+xvxVl9yEshVfzs=;
        b=tANaMP9ByzanpbXa3fyCM5i2eaSV1kTOM+Z+Yf9oOI+uIqBDwE9UFNg5xY74D23HjN
         LeHT7a2IuqfNag+HajvqqE3ulaw5wwKvGV4mls2TER/f6co56ahzZGQZmATU1bTbh1Hi
         Mic14+w6WW//JDEnPJcfhPkcW1xLfB2V1JG2Cw2BApBq2kEHS9uUJVMDuGFYQY48AOiU
         0m59TyrOJTwwa4I90ZdaapQa+ybxa6WKhRfmELpoJdb20rpCE31orDXdFcBxHVhoyPpM
         iy1i5q6Cg5B/L5qN3xcRRIrl7VtEHfS8ls+2uY9k9GP/3SO+kqpRdF9+N9hxDnrzeg8Y
         ZabA==
X-Forwarded-Encrypted: i=1; AJvYcCXKywUuCzmaKN92s9frq3D9ppn9UYVVlhaqmEUafMf/5ugwXlGwK2S+eZn07u4R6P/Rw8eRIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtJNBJskiAdB8/qHJvdZ46NxdqNvzTbZbk/fnD/TyVgI+9YPoV
	JJcKnJLgsSR+fydREXjmMe/s7cerE8llVLwwht9VH4msv56kcx+dUfTP
X-Gm-Gg: ATEYQzyipD7LjsH26BxKtzKo97p1RhHyBHD92kkW00sXwGNQSNDS6twrWvCKHD8QJWU
	MTvFFEqjPCgPp5gyliXCotKhQhzjUQ62nJgbnoVyIbr/nhwtLjNVKe7xAPYAYUkAC4W/xQqvBUP
	IRAWVr9EL4RDjMnTHd8btN5eMU4oWIUTUulkkVJxhoeMwMaYag1EDF0b+ER9EwgkqAQxHn6XEL+
	sr7vf3MfQIizbzD8iD8H+yqL7Piq39J9wmebDfTCyGEFo8iLll0Ushqndcp3ntlbiAlfddsKiB1
	oXiUbsVQAsqamRsIrje2aalgx/MuTTa6MzZjucT9fkUBW1SueCw754bawY13eXOU19w8at6fvMZ
	Y6T24luZO9mcpckZMB02jIfpmKU7PIv0XYwecLmlSyuzJ+6X2cKltklAxoeHWIbdDs/Z0snb3Po
	AeeF94lI76uqkdtgT6LYxB6wWHWMIAx05qAReeR8yxwRSz8J+8ZTA=
X-Received: by 2002:a17:902:f64e:b0:2b0:c2d9:2714 with SMTP id d9443c01a7336-2b0c481429emr111709335ad.4.1774770669117;
        Sun, 29 Mar 2026 00:51:09 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765bf4sm50821305ad.42.2026.03.29.00.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:51:08 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sun, 29 Mar 2026 15:51:07 +0800
Message-ID: <20260329075107.36402-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329032054.2443-1-sj@kernel.org>
References: <20260329032054.2443-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

On Sat, 28 Mar 2026 20:20:54 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 29 Mar 2026 02:43:19 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Apologize if my previous email was unclear. Let me directly address your
> > two suggestion.
> > 
> > 1. DAMON_SYSFS Type [1]:
> >    I fully agree with this. Centralizing the validation in
> >    damon_commit_ctx() is the right approach to avoid "whack-a-mole"
> >    problem. This is exactly what I am proposing.
> 
> Thank you for clarifying this.  Thanks to that I can show where you are coming
> from.  You are misunderstanding what I'm suggesting.  I should have explained
> it in more detail.  With this option, I'm not suggesting to update
> damon_copmmit_ctx() but the callers, in a way similar to that for DAMON_SYSFS.
> 
> > 
> > 2. Adding a simple check on existing validation logic (in callers?) [2]:
> >    While this is simpler to implement, I prefer avoiding it for the
> >    "whack-a-mole".
> 
> I suggested option 1 as a way to avoid "whack-a-mole".  I didn't suggest
> updting damon_commit_ctx() as the way.
> 
> But, the given problem is clear and local.  Validation of addr_unit in
> DAMON_RECLAIM and DAMON_LRU_SORT.  There is no problem in DAMON_SYSFS.  So I'd
> prefer simpler appraoch on local callers that having problem.
> 
> In future, we can make centuralized appraoch, in a way somewhat similar to what
> DAMON_SYSFS is doing.  But that's somewhat we can think in future.  For a given
> problem, let's fix it first.
> 
> > 
> > So, to clarify, I choose your first option (centralized check), and I
> > believe my "Option 2" is the simple way to implement it.
> > 
> > Does ths align with your expectation? If so, I will proceed with this
> > approach.
> 
> So, no, I think we were misunderstanding each other, and I think I understand
> you more now, thanks to your clarification.  Also, please don't hesitate at
> asking more questions to me if any of my suggestion is unclear.
> 
> In short, for this given specific issue, I'd prefer the option 2.  Is this
> clear?

Thank you for the clarification! I may understand your point now.

So, you prefer to keep the fix local to the modules that have the issue
(addr_unit_store()), rather than changing the CORE damon_commit_ctx()?

To confirm, are you suggesting something like the first approach [1]?

    if (input_addr_unit < PAGE_SIZE && !is_power_of_2(input_addr_unit))
        return -EINVAL;

[1] https://lore.kernel.org/20260325071709.9699-1-aethernet65535@gmail.com

Best regards,
Rui Yan
