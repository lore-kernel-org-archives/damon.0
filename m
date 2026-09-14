Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D2488D95
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401463; cv=none; b=nOGTG/rxcVkTCOJnnLcn8qNcVO9V1lmzyfsvthoFjjHkjp/ff9WTVyk4cfI5zmv8UhXtNI6mtjLpxT/lZ5R9+3Ow+CXyGutFUvefv/qFqxTOZ2qKAk86UITr5s+HhkLe8aioAYZpzgDMLIySPOXwbMZS9fho/aitU1Z4mmDhObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401463; c=relaxed/simple;
	bh=5ZiwVFQlAD3lG8hrfLGRLnNhI7uqv5EcZ+cUO/c5qno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ss1A5DemdTbw0cpy6ztfomlJ4Gcoi+aikGLndeH5InEY4K/08UiyiwC1awUFKKgO3CvTC0sZf3FqOfJ11pSqx1ZOWGJS6XB3DfRJhxHG+qztiyEX+/H9Vbot0H3f14pk1jwdP+zkSv4mrf8rKARueG9VX1aW2rnMIVyfv/SacXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZihH8tkZ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZihH8tkZ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso2326564a91.2
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789401459; x=1790006259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLQyzx/jS9wKpt8k6euuDCFOGH2TJfuVVKt6HxhJ5XY=;
        b=ZihH8tkZVELXpWZjzYxQSmbvVi7T96sshR9vQ2Gn34VKxZNSwxfMvCB43SZFHhv60X
         bvuRkZGqwjuAHKjHfEyBELR8tw0wMWvT3nj3xYhJxu5AB312xZDCeswCdJyZwRuHlmPY
         oA0Wjv7hsyF3mb75Q4PiJZdk/yzhv+qQwx9i5IZHnW02i7BGmncPskMifaylz000kYcG
         /ob7WRN54ehozM0Zl4WV318LJwowjGBWUiYrDHswzGhKuXE95ZKzTwyh69IxXTBlIQPm
         5k2OhBq4hEGRhRTkH4fPD9wqJCJM6y9l2fJgRKnVMMC0onWA36gmtf2O/GKn8ud9E8OE
         Caqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401459; x=1790006259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLQyzx/jS9wKpt8k6euuDCFOGH2TJfuVVKt6HxhJ5XY=;
        b=lp8i+rt77XL5iNhpcd/USVdYA5tG2xirEyGAaIUhTsvv9iWYZZWD2zTRVHzAVFCiaA
         EahEQUogf4ScgZIj4G1b7MiyTtUPOROQfIwqpN7TnRQoq8vW3tGIVak9qzASDyI2C8bw
         SVMhh+2I+jt8de+jfp/tFbaDYFNfaAV1qN8GR0eXJEVl+8y6OoIJCt/YTOMQPppPOyaS
         xZzQRlQYmpkJyHHeBBIpT8mreLeBe387JmAtj12kGYb/iYvPLcXbaWIVne5m/dMOnlQe
         mO9sO5ZvfMXftdmspsb32gDZHn8jHYodv15dQUT7JK6Jmr9xh4/HiXXaaz2eN6rPM6SG
         ckhg==
X-Forwarded-Encrypted: i=1; AKwUvBw1og9DvSPvhLyWucosz7iUYJRUIJYutonC0WV6eTZ0JM93IXW2VC60ZpJ1+y1ZaZFR+wGbpQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m+18L3PJMwh1gNStnoGugqyK3/fHn5joSlzuEjobuVNoe6hQ8O
	PKABIE2GWqxESBWTd8blMYvmabRi7TWWEJqXwdssVK/2gzTgsq7z8MfR1PBQRo/n6IU=
X-Gm-Gg: AYBFou2+wzkKsuaZETCI0KDRSc3p7XH1ai9e3vAqAYLnfk+QompFTjzZGU9ETpgkjwD
	7Xg73rJ5n2Fy4KP4xKMfj4ntx6ho/bIQUCVijKywmhyUfeOV0H8UKiCzVHvwF2nQ7UCW00IOCvo
	Ba3QknMHXL5D8hXxsZOpJsNMxaK7fkJ3pVN3vP1TVW1yDlYN6RCwv922Hdvl7XHNjRVeSS0H5eF
	+M7FOejpbH/RkTTZ4ThawL4biG3x+w8LqXOnCLkvMrGdk21mydJ6CPwvemE2XEUCC+gaLvky1aE
	FxgWGnvSlR5hb1f46AAZdw22Ks/v9QHY41wL469lwXSfNESPQpv499rsZCdQXdQrEaekkz8b2jF
	0BGEGwJmR1VHm3OIH+4gVp4EEH41orKNpOjS0NLo4RVNnE27AsgNHAxJci6zwgtz7WtDkE1MyNG
	t6xVyb32DDs6fWE/ofox5B61Hd5az/vNNzGr1GlotK1/dfsFVZhE+7qMMbEc8EyJzVUgoZFw==
X-Received: by 2002:a17:90b:3c47:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39debf8d92cmr6628202a91.6.1789401458739;
        Mon, 14 Sep 2026 08:57:38 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda8bdf4sm141419a91.12.2026.09.14.08.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:57:38 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Mon, 14 Sep 2026 23:57:27 +0800
Message-ID: <20260914155729.1518105-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912191807.138502-9-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 12 Sep 2026 12:18:06 -0700 SJ Park <sj@kernel.org> wrote:

> Add test cases for testing the validation of damos filter arguments in
> commit time.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/tests/core-kunit.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index c9941f3bfb42b..5da84caf4124d 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1195,6 +1195,13 @@ static void damos_test_commit_filter(struct kunit *test)
>  			.allow = false,
>  			.sz_range = {.min = 234, .max = 345},
>  			}, false);
> +	damos_test_commit_filter_for(test, &dst,
> +			&(struct damos_filter){
> +			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
> +			.matching = false,
> +			.allow = false,
> +			.sz_range = {.min = 456, .max = 123},
> +			}, true);
>  	damos_test_commit_filter_for(test, &dst,
>  			&(struct damos_filter){
>  			.type = DAMOS_FILTER_TYPE_UNMAPPED,
> @@ -1208,6 +1215,13 @@ static void damos_test_commit_filter(struct kunit *test)
>  			.allow = false,
>  			.addr_range = {.start = 456, .end = 567},
>  			}, false);
> +	damos_test_commit_filter_for(test, &dst,
> +			&(struct damos_filter){
> +			.type = DAMOS_FILTER_TYPE_ADDR,
> +			.matching = false,
> +			.allow = false,
> +			.addr_range = {.start = 567, .end = 456},
> +			}, true);

Could we also test an invalid PROBE_HITS_WSUM range here?

Patch 4 adds the same max < min validation for
DAMOS_FILTER_TYPE_PROBE_HITS_WSUM, but this test only covers
ADDR and HUGEPAGE_SIZE.

Thanks,
Kunwu

>  	damos_test_commit_filter_for(test, &dst,
>  			&(struct damos_filter){
>  			.type = DAMOS_FILTER_TYPE_TARGET,
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
