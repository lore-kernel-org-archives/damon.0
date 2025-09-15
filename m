Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2F33A033
	for <damon@lists.linux.dev>; Mon, 15 Sep 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947922; cv=none; b=jNGqPyYhDnUSFtK3mjIX1meWoEuosxu9FltAXWHpe7spDDCLdgKsN051S3TRj05G+ms/MN4kD4eY5BAC9AgfhgTGefJkNAzimHkteicvNTNdARHLql+uAFlPPmVRyG/HA9xJ1Gv4Ijtxfb3vHqNbZJIMitRqtg6e3lIE+JnoJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947922; c=relaxed/simple;
	bh=uFptEW9cg8S61E+y2uh5ogEGKkvDUbD1fy4yddAhBVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgqh2ZEPjP8Q0HctcyFH8P1GTNtaGToTV//q+jZKwKAP3uoQrVgI6vN6gTDACkMO5LhZmYyAf1rdKFvhx1vD7RjcSU4wh/bzKr36fY/zYcdHbOvVci5DDtM+OhQc7duOm4FSAjY6VWsAaSo7O8oJ03TKmXsS1WRPsOQpdQd/Sko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR5dAq1+; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR5dAq1+"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-60170e15cf6so2827417d50.0
        for <damon@lists.linux.dev>; Mon, 15 Sep 2025 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757947920; x=1758552720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qAlpp2q6p0FpxveyekskbKJV1WmCNzmzFjExvczEyQ=;
        b=NR5dAq1+/e9AcHfVndLnON4P9A51b3+MVQ4dEZiR0YbbWGeyTd6tIy0eUXAc0t5LMj
         heqO2yRXbuLiyus6LmneS4U8tmZg9ukxlPbbUl4ZO9cae0HzGC44vlkiE3IlXuhWnjDn
         QHdZvejPNIVvnVx7skOZftrRdX+N4bSojnRFTZarOPMuLew6U4yrXO71O8Td6B8iFXoL
         cSsXGwZ+kJGSPeQqOM+F2aN1z6QVg9yryEoAep/y8tfkC2qd3E3JB7+7CL0GeywLWpAT
         YwbQdqVf8O4r5z3puaO7b8C8/OAk/sHZluuUKm5filg7EjqAI7MMzruWhi+S3Dc2n3hJ
         Ph7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947920; x=1758552720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qAlpp2q6p0FpxveyekskbKJV1WmCNzmzFjExvczEyQ=;
        b=XEBg+m5CcS6jU/2pYXRQ4EqxyTD2mKCLeKfhGSpB7Z6SUWNRcftpqhCV5Fua4c1+0G
         nHjAsVxxukKU2Mr5Mk8VwERHLTefjQ51H1vOuc1R7ZKztY3nZ2HCHc1YfMP7gyOvpgMD
         jLwG2Sq72yirX+cNxRZp0M3ZJVzsjsLCJjtdyJgwLn7fjGOBqD9Lrd2QY+1a7YABGT6b
         yoZeOKrQBlbobb+uT18IQ2O3pyysjRQnTJTEhp7oZfBGDK7Kc2y2RilLotCZAE1hf5UE
         srhkI2dre92WugSfT44jiYV8wSV4de+0TourTHmWOF/F2iyvhY16HDQ3cMwmBXd/F+1U
         AixA==
X-Forwarded-Encrypted: i=1; AJvYcCWXPfYoYjLrKpM6LR7D6phE3HP+D9E+B+kfeOqNywdoZDE1Yyh4FJ/DOyuMGihJ5flRUnLSow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPoKZvt4RDOpdypY3xI1MRrC8yW2Bz3xOcCqlZBRbCo0qqUZxB
	8BEIJeITDkDLfXibEfOBTxylTrBQmcUc+gTbqCHma3YXH8y+Hdxa9pHE
X-Gm-Gg: ASbGncvhvYvMZ0mF3vPv0Atk28sNkp2xb5dyHXDNi0uoo0xmxs4PtqHgGZko+76k14p
	HREcTO9XvOnZA7OHyFG5yWEIFKULgYbuuPavI+T5EwRhhzJrbQY564f+9XBEVKDcGpoFCMl1uMm
	5UAA1AXNm5Nmfeai1tjzc3H767D3nQa7QODOU1JTkCI8IQKsI22N1D3WnYResliyr6ukC0ltIdj
	HQC7rpzW76yoF18hMJEMDp6wpnCQy3UBt06Tyae+/iWAfW/0IjykuDkwFn19hGAE3Im1gpM1AXp
	HyLWmHoqKlgJmJsRreQXo7lJPhO5C+XR+jlALmiQoZCG0aFn3UXx9NBAkBiBvmzuJ0yd1YRhVNB
	cWrRKj9tivOI00IgeSH9IIwU1VlnVd/Dtop1/nm1wQjxPPfHbYA32lr5qE1SSZs8=
X-Google-Smtp-Source: AGHT+IG0/Tp3b8E0G2GYoA6L3RRR00/SCKeeLmJaTBzviTCWD28HNMqArXMoHbpYGOzCSnzzapPt8w==
X-Received: by 2002:a05:690e:1651:b0:628:10ee:ab85 with SMTP id 956f58d0204a3-62810eeb27amr7094360d50.3.1757947919804;
        Mon, 15 Sep 2025 07:51:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79794201sm32181467b3.62.2025.09.15.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:51:59 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/6] mm/damon/core: reset age if nr_accesses changes between non-zero and zero
Date: Mon, 15 Sep 2025 07:51:57 -0700
Message-ID: <20250915145158.1425390-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:02 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON resets the age of a region if its nr_accesses value has
> significantly changed. Specifically, the threshold is calculated as 20%
> of largest nr_accesses of the current snapshot.  This means that regions
> changing the nr_accesses from zero to small non-zero value or from a
> small non-zero value to zero will keep the age.  Since many users treat
> zero nr_accesses regions special, this can be confusing.  Kernel code
> including DAMOS' regions priority calculation and DAMON_STAT's idle time
> calculation also treat zero nr_accesses regions special.  Make it
> unconfusing by resetting the age when the nr_accesses changes between
> zero and a non-zero value.

Hi SJ,

Thank you for the patch, I think the goal of the patch makes sesne to me.
I have a small nit / idea which I think makes the code a bit clearer, at least
for me. It seems that we basically want to XOR the two values's zero-ness, so
maybe something like 

(!!r->nr_accesses) ^ (!!r->last_nr_access) or
(r->nr_accesses == 0) ^ (r->last_nr_access == 0)

Can achieve the goal? I know bitwise operations are sometimes harder to
understand, so I am just throwing the idea out there : -) 


Anyways, the rest of it looks good to me, please feel free to add my review!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index be5942435d78..996647caca02 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2261,6 +2261,9 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
>  	damon_for_each_region_safe(r, next, t) {
>  		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
>  			r->age = 0;
> +		else if ((!r->nr_accesses && r->last_nr_accesses) ||
> +				(r->nr_accesses && !r->last_nr_accesses))
> +			r->age = 0;
>  		else
>  			r->age++;
>  
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)
