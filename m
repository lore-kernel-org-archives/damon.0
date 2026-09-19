Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D0363096
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789844984; cv=none; b=iorV1NVmZlPzXepupI5g1mP+YcNOlciWGUhVtsQR38do1LDyn2V3GV2fdiJYMBWNIMd2/G6VRgVKpHmLf8xAJ+FzQKzoZ9rUb8IbfGIoIIJC1hXAXn7v2RVwTa7blnjVpsRP6YSwckAPHU9MDUPFKk+NExPMQDu6z1kdDCWugtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789844984; c=relaxed/simple;
	bh=ufrLzN0G4iorWWuVwTHDbj1hN/QiQkoi3KV3uS/avk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8d2ySIkXBDCcUAKAkS5kW4HF21i1SgSV4iRuRsae2rGSNG7kUbvlSW8/JXHL7pL9ZyBmFfiAc3wkRaU9G6n8mz1nMX+6i5a4ekEZlMSGGF3yIs2ZYj/1wGRn/H28Mgh3YubqY1JhrPi/GybUq0YQniZU/Nub8/001g5oNOnI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH2UnxPJ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH2UnxPJ"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so16118985ad.2
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789844980; x=1790449780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+A8NmYL+ONSVcQNv/Xmt66mRPmqZH9O1MKGhSoPUDE=;
        b=fH2UnxPJPY4vTr/yhEiWpD63xsMUsow9ZidCpJ//mIFcJ7fHQ/xrjJ2wpP3lcN5HKr
         6AUYAg3afYakdajiWJTXe7LGUfP85xYaYzSzhrKCZADmpiexGpERkpRJs7cQtv9Fd4zH
         gF4ixwFCwGwuggsHIjrAJ6+zHW9xQHPvVICGetg9ys6F0yq6szCQI0eN1ee9SiHieW8U
         Tlq62sL7wgCDAHueJtDSvAzv16roUsJZwOAgfdKTWvIEDmTr0KHWzb5rhDwOx0148whW
         V/lHi614Oh7uqpwvSeI2uzbR2MIwyhn0k/g/obt+uYovG6aGTHnNHdZdMt9CiEDcth9v
         uwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789844980; x=1790449780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+A8NmYL+ONSVcQNv/Xmt66mRPmqZH9O1MKGhSoPUDE=;
        b=iGYDveZ8x6w4tFvCb3zWPCiDxCJ162GWjoeANiBnBocpJMwWhcHE1IOTA71ZkR35HV
         9VResM9p/SsdNHj4jiLutdncZKHOvKZIku8rOn5ihJVejWiFXQW/tBaD/OCmeXNKAH9g
         P6jCfvYR6/3ptDgmhoXS45bDwxqNwOt8WVdbp7j5v2mtiCaWHnrR/o4qVrlqLgS+L3M0
         wNpZMt31AT3fnhLqgVPSnw8PAyD7wdj62TiDyCw4to2pWkX1r2gdGL7wkKOpImXDSuM9
         rrN2WbH8jzpKIP3Kx0hbb1zaNRRnB3Z/pEcnJy1eBmMMaB1zNn2x5TP2Ls6pjtlcfLWF
         Bcgg==
X-Forwarded-Encrypted: i=1; AKwUvBzcPS0YNKuJi6qOjXJnWGkCdjYe8qZij237rMLloJ3Ik+F3HVLQQo+tfSRuFDtAw2x6SOVYUQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mL0HxtX6K8mqfM+8zA24oWuXqffNVFppPBisqPwPPGjvqeEoG5
	J200Bw1oetEbJRRAH+HZYCbAg6KKPRmjx2XnY1vvWL9WXTzHou1Dp9Jc
X-Gm-Gg: AYBFou3rP+2QZcxcsgyyVlZNGpSFrr6hNgyswd5UPcriAI10wNzutY/uRNyWXyidDKP
	PHtzL7wL963pzRUGbmXNPaSr4Za1YseyVStVeVCzJB25yaJ3HbNp9RyiBEcSEhkdtorjuO4spgg
	5uN58rGh7qLtWmYK3Hc0PM/S7DgTmt7zjJzUpr7LQQH6UI+86GgL3r1sNgA86yzNrAhzd+ktCOz
	iUrL3Dv2QZpaNReakW4/cKqyqinRjb7TaX2AmNZR11o/5/iH15P+QHveouyxlw5a8ulU7ZKhXpa
	ilJPVs+PfpQE+NiceKarhwlIfTHlFYuk42hnjy4vOTkU7MrmbT+S78Q/uySxRfb8x+EPn9LnbVX
	fq0W7djfLBt5zhajswLQpySk8OYImlG5WUNlJxOi4aV/j7MFXZubOaYRvcVl5QGB8LG/gFNf/th
	c52JKDB6LT7GCgdTPlpCP9wlr5pgrjr3swQfuopBgnDYRMR5eBYbqTwQu4mupsVwl/bkV/nqhjW
	A==
X-Received: by 2002:a17:902:e80f:b0:2db:39da:90f2 with SMTP id d9443c01a7336-2ddb1adbee7mr109128495ad.8.1789844980074;
        Sat, 19 Sep 2026 12:09:40 -0700 (PDT)
Received: from celestia ([2402:1980:c3f:8e4f:9945:ef6a:453a:80bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17888a8sm12378465ad.26.2026.09.19.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:09:39 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RESEND PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Sun, 20 Sep 2026 03:09:10 +0800
Message-ID: <20260919190953.86705-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919160725.86256-1-sj@kernel.org>
References: <20260919160725.86256-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 19 Sep 2026 09:07:25 -0700 SJ Park <sj@kernel.org> wrote:

> On Sat, 19 Sep 2026 16:01:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Commit 50585192bc2e ("mm/damon/schemes: skip already charged targets and
> > regions") introduced a minor issue that causes the last region to be
> > skipped before it is processed.
> > 
> > Example:
> > 
> >     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> >     2. Quota is configured to process only 100 bytes per window.
> >     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
> >        addr}_from is saved at (Target, 100).
> >     4. Window 2: The loop reaches R2.  Because R2 is
> >        damon_last_region(t), the old code unconditionally returns true,
> >        skipping R2 entirely and resetting the charge_{target,addr}_from.
> > 
> >     Result: R2 is permanently skipped even though it has never been
> >     processed.
> > 
> > Add a test to prevent this regression in the future.
> > 
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> 
> Other than a trivial style that I commented below,
> 
> Reviewed-by: SJ Park <sj@kernel.org>
> 
> [...]
> > +static void damon_test_last_region_quota_reset(struct kunit *test)
> > +{
> [...]
> > +	t = damon_new_target();
> > +	if (!t) {
> > +		kunit_skip(test, "target alloc fail");
> > +	}
> 
> Let's drop braces for single line, as suggested [1] in coding-style.

I will change this in next revision.

By the way, Sashiko reported an issue [1]: min_region_sz is not
power-of-2.  While this do not cause any real issue in this test,
non-power-of-2's min_region_sz is not legal.  Should min_region_sz
initial value set to power-of-2 value (e.g., PAGE_SIZE) in the next
revision?

> 
> [1] https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces
> 

[1] https://lore.kernel.org/damon/20260919081239.8A3D91F000FF@smtp.kernel.org

Best regards,
Rui Yan
