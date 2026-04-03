Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79139769C
	for <damon@lists.linux.dev>; Fri,  3 Apr 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209836; cv=none; b=X3mmM9pwJLcQtiC4pDw70LT/XngG04A8L3L28q2+jykkQWEEIHABVmN9y61WwiQdFOjw2h7bNlpWlzcgcfiPsH+NHtPfuss1a8dhPzlWp66ViYiLPW8OvQG/Z+EVhHmjFm8jbyJyf95IG6OoczzehdEBfRUsQdC/t7lYQ2BXZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209836; c=relaxed/simple;
	bh=4wAOxts4EStG6lpegLK0Ji5fza/gxnnRX+GBzYLxjCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW2anP8DxyajxGk0rHMtCHOp5OHx6WvcSrUKwzZpk+z0AqP+dSoV/d4RLOt/FDN1n87++lHwScB2/ppqUI6azQ4Ns/p4fDJ6UkeYhZWSJKbfMxUxCffHWNzGwMEbUCfirTH1eEbCT3UsYuxxjIHtFgx0CyINzm11QIiAGLyTOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtGB+jaV; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtGB+jaV"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c741db5d610so608485a12.3
        for <damon@lists.linux.dev>; Fri, 03 Apr 2026 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775209821; x=1775814621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KReXkppPG3uNOMveoUqnh+3H0YwKOe6D48GuF2fODs=;
        b=VtGB+jaVdsDC/GE6yHMr2qiaJoXbHnhkLd7MEfD5//wniYL9XqmsZdY2Ur4Jg0zzM5
         Mcz05gMcrWmn58ndMIZvktWAX7Ca8/RH6FjLkthCdQsbatNSA4pSHKBXZ7ON8NUoBWoE
         aHmGZCHpLYrfQejo4ku6WR9ywniP7pq9UF4ShrcNRRYAKhiWU5yunB3QFRBiZicsANRk
         A5V+k9Ai4lmzgjUWv6TpXL/BTahO9W+LvgSIBDBDZEqou30JxxJRANnR+IU7fgAsiaHD
         vb6vyURq5sD4zd+ovVb7Ku+us+DkNz9NzXWnX+/Jn7114lKaWU8vW/MKTjxvxL7+uo8j
         uXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209821; x=1775814621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KReXkppPG3uNOMveoUqnh+3H0YwKOe6D48GuF2fODs=;
        b=rOZbh6NgFA8KnNkeKyeHceEfxtz1k5u0V9g85fWzC7naZPrqgBeElAmDFWOq/iZ6dW
         KRf30kN7Cqe7f/iLW0JelvMdEi060XReCvEWO6LNhMlSPG9CvpPhPuQscCE2Umjh/l6i
         DtOtVs5apiPvznZrFpF5vHhiO88nB+bgSx1iBPVlvR1fhElm7vllCaLWK7ExzkY5k91z
         JjV0DVyWLG4CvY8x4UP5wiGHDJTQs52P61Ask3xpa7e5DsKPBc/h3kXiQWl99iyPGx0l
         b3plOGdMtZ00S1KjqQQhbqnyuK262alSnvw1ooBYjo0QbTCiw9tJ4zqFm0iqWbHfY/bX
         q7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVfMztT34jsDhnIa/+7Jkckjmnym79Mx6JZr/QqRFwbEn17l0mjateLon7R4KM+djRdZOHJmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+BQ73RFRNxq+z+YBiBzTV1nJF8spXGKfGgOSiOsZWlKFg3eNF
	s23QHG6haf76Di+cQDs7dQdYeYUd3mXVz5OoT1mAGgwtiYfrNOFE3A5P
X-Gm-Gg: ATEYQzyYWRbwlaonx9G45FRRiTQOnkPOlhuRGq3r9nPw8LRQUcNLfJ4iMM3ocJUEnRb
	jFuIMtyM993D/+TfKlnCOatR9rtnntcLzMh/zFK1K9XGgjY7UABFafcpy4UeYQaYCd3Kep+OuTN
	fefkXvCwGlIFM6MAGMDBGQ+Oek6eJoFbTXIoM3hIdvZK9MVoPxXhG16nK/+sd+ytFqiZoI+MjfO
	8Ri++1HhuZk7mAab68jsO/FOXix1zKTnqvEI5RNiszMIy0O/lqTGbnreTt9W+j3pYLbrKmSma1a
	LPb32ESBAttgqzWM1x2NkkmEXX8g6bZVM5yddc8QvsfUlvl+/9MCpaKGepMzrOivKR4wrZRiVWF
	s2DGsHr128Zs4JDzSqlRVh9Rdxr/zEs3f2sz7Xz1To+LbOk3gsCLBbiscUwpjSv/RiELYcM+MdG
	7fKQ+6OzQfZ09xVxehCl+ZbKZKJaaHD2YBjaIQirHIzky2BKqaU+0=
X-Received: by 2002:a05:6a20:7d8a:b0:39b:81bf:15ed with SMTP id adf61e73a8af0-39f2f3358c6mr2215246637.52.1775209821060;
        Fri, 03 Apr 2026 02:50:21 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6561fe9sm4612331a12.15.2026.04.03.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:50:20 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: yanquanmin1@huawei.com
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 17:50:19 +0800
Message-ID: <20260403095019.29222-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8a902208-675d-4564-bb31-fdefcaebb752@huawei.com>
References: <8a902208-675d-4564-bb31-fdefcaebb752@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Quanmin,

On Fri, 3 Apr 2026 16:59:38 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> [...]
> 
> I'm a little confused, what does "causing kdamond to terminate
> unexpectedly" mean? The damon_lru_sort_apply_parameters function will
> eventually call damon_commit_ctx, and the power-of-2 check is always
> performed. Is the early check here to prevent some more broken case
> or am I missing something?

terminate unexpectedly means - termination not initiated by the user.
(e.g., not by echo N > enabled)

The issue is not about whether the check exists, but about when it
happens.

In damon_commit_ctx():

    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

Even though -EINVAL is returned, the 'maybe_corrupted' flag has already
been set. When kdamond sees this flag, it terminates.

My patch prevents this by rejecting invalid 'min_region_sz' before
damon_commit_ctx() is called, so 'maybe_corrupted' never gets set for
invalid inputs.

Best regards,
Rui Yan
