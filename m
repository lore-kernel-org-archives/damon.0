Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F523F20FA
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388323; cv=none; b=huihCAekMNykbr/1/r+/9K8VyHMdCCmLB54qjHBRL3dD6vStfikRYJCF73Pv9FOaRAruwx8rblI0tNEW01dAgxG4wMKzocLC38JX2RNmB+dlVawO0ZUrDehMo7SCP3JK/dVWpkwgRinJ3y0tt92dXuHjZfjNoBm3ML9vrJ4DmEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388323; c=relaxed/simple;
	bh=x8QTwaBEHlbhTlyYUzQ6IcB4eonbQnCoTFLiMiKbeBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD9roJbtXIBrV0unabEH+E10xfu4jTioORKTKAgrUU6Q9k4mMw3kxM/2ZJtqK7L8iKYq0Chpr6JOGRAeG9jZfyfKX+Oc7ne0/1gGcLdBCogSJbzcKFIswifDNoDcowpTWnDnaWe5N+7k/JD+hJZR7hVBxa/Epp6UL5Q3Z5z5GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8vxZ0IX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8vxZ0IX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d5cad1a6baso15676845ad.3
        for <damon@lists.linux.dev>; Wed, 02 Sep 2026 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788388316; x=1788993116; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rfj489snHAgcjqYCzxpw7R2gTXTEyikU7ldTqChZJq0=;
        b=V8vxZ0IXUi6AomBTkwtJKE8lOfbtvR4wHGuAsRdQsDdVaq9KqqHcW60ROEk/jQE7Yd
         YbOTP4oH0AEvsg2f3BKHOQwOsmwcTDOn2trKeNSwH9VNNguWcjlMm3vd4AhmUTS/hQtf
         43LX2NQf3ntbg1pSu2uPWIUd/hhUateMwPW5kbWm9yiFoz+BqKo7tT7esuiKQvFmDp03
         Q9ingloCeVw1rDgV22tfBvsZ8ZpRYlfUQiMniQ+KNNk5Nzc7ruN/g2Dc48uVdAqCEiEd
         ShAshJeS6mEc/jLcEx8EhH5ReKtgfUgVh8eHvCdkVRwd4NtSeNWmwBy+ksQoaIgv7t+e
         tlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388316; x=1788993116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rfj489snHAgcjqYCzxpw7R2gTXTEyikU7ldTqChZJq0=;
        b=j+tdHqiiseq//yorCA0vk0Ij5kMoqJMMoHIuoWiUCvTphU51QlkAnqMTle651x2c8B
         k0CXA4rTV4GzGniXwM+bHEyG6v2ve5iInyRTiM+nFuIhrUJ/snRmVgmfJAknmkGhbMWO
         pLm+CRtUSohPtsGGEosm6HrAP3bQDw9gT7MVti9XApH7zJtKx1LLhmQh5VyHmuu/pmbl
         oSdENlAzJEbtnW9Tc5/fuvg8PxO9CTGrN/QIKGBdoe28qmWNvAHoC1Tvo36k3/1O1iRs
         AxVjGWv4yVcDd5n9yQYfCWa9uOf9bLUzUjye91T7IgeX1vCJxmgSZZSbqbzd6IF7QQfJ
         eBDg==
X-Forwarded-Encrypted: i=1; AKwUvBy1HEyJDEdpxWI87G5dHiaNA4yGWCM0ebzcfB/fHbdlYPX4VLaMxGOWSgREEPnjYHBMqhY3Vg==@lists.linux.dev
X-Gm-Message-State: AFuF++nt7UBXq0CK5uznXJJGtsdqKJ/4aKYOvc0/J0y5heJl5m8Fj2hd
	e6wXlIYOVgqM83NDxU1c8iOmsqNnwK1T6STn8Rt+s2y1M4ryr7idAgrD
X-Gm-Gg: AYBFou29DyrUF9TTjGe0Tw0PyK9YPgOQCCB599KJq4hb+j9jOasetZymHeGMrAwglG1
	JQr5VTdDWYY6qlfLiEUEtNLGu021OT8kvlgnNj7eh3MyzJPeFASXmOlCWJD4BSTZAt9/Q42NqJj
	yN5RdQXup1BngiM99Y074Dv8gZQuSk4FCX+HCoc6gl6mEV7Ddj85kAIyCtI8/XV3N5x/nqm/9ye
	pKxozCgYXOByDp5tel28LKj7mA1THB9FjYMxM+X5BNaUJxQ7S0Z1NZ012nMt3bbHs2pJe1KA4pj
	sHItYCP5ofzpt5ucUYMozYWR75kfgbphcgWPIFLjP+8mhmO8cZIaFx4nn6aN5RBebPBO7pEpMq/
	Wz2w/UhPWjkzduNAqtntZMeJuc8SqbIrwTcecxNgbOFDUj0Wzhvvp17IIFBMUQxDpIeyftsjgOM
	6miIIABnqeLVwiEELOKvoWCE5hhmSw1v1yAGRzKSQ2t6owupPPBb+y65dMT3FPmTFF
X-Received: by 2002:a17:903:1a0d:b0:2d8:d4d3:da50 with SMTP id d9443c01a7336-2daec7a70a2mr111190875ad.20.1788388315442;
        Wed, 02 Sep 2026 15:31:55 -0700 (PDT)
Received: from celestia ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe0e24basm1215945ad.2.2026.09.02.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:31:55 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Thu,  3 Sep 2026 06:31:38 +0800
Message-ID: <20260902223203.14871-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902144804.88298-1-sj@kernel.org>
References: <20260902144804.88298-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 07:48:03 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed,  2 Sep 2026 22:22:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > When setting goal_tuner to 'temporal', if the goal is achieved,
> > > > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > > > will always return true, even if no regions have been tried to apply at
> > > > all.  This causes qt_exceeds to increase unexpectedly.
> > > 
> > > To me, this looks logically correct.  Could this cause any user issue?
> > 
> > Yes, I think this might cause unnecessary confusion for users,
> 
> If it is _might_ kind thing, please ask questions first, or add RFC tag at
> least.
> 
> > at least
> > it did for me.
> 
> If it confused you, definitely we need to fix it.  But if it is just confusing,
> let's try to clarify by adding documentation, rather than changing existing
> behaviors.

I agree that we should avoid unnecessary code changes if the issue is
merely a matter of confusion.

However, I believe a code change is necessary in this specific case,
rather than just adding documentation, for the following reasons:

First, this distorts the semantics of qt_exceeds.  It is a statistic
meant to track actual quota full/overflows.  Incrementing qt_exceeds
when the quota is completely unused (because the temporal goal is
already met) misleads users and could break user-space monitoring tools
or scripts that rely on this metric's accuracy.

Second, considering its original behavior when it was first introduced,
the recent changes [2] have inadvertently altered this behavior.

When qt_exceeds was first introduced [1], the conditional check was:

    if (quota->esz && quota->charged_sz >= quota->esz)
            s->stat.qt_exceeds++;

Later, to handle cases where 'remaining quota < min_region_sz',
damos_quota_is_full() was added [2].  When this function was added,
quota->esz was replaced with !damos_quota_is_set(quota).

    static bool damos_quota_is_full(struct damos_quota *quota,
            unsigned long min_region_sz)
    {
        if (!damos_quota_is_set(quota))
            return false;
        if (quota->charged_sz >= quota->esz)
            return true;
        /*
         * DAMOS action is applied per region, so <min_region_sz remaining
         * quota means the quota is effectively full.
         */
        return quota->esz - quota->charged_sz < min_region_sz;
    }

With the introduction of DAMOS_QUOTA_GOAL_TUNER_TEMPORAL [3], quota->
esz == 0 carries two meanings: "unlimited quota" and "should not
be applied".  This overlap causes the damos_quota_is_full() check to
return true incorrectly in the temporal goal scenario, leading to the
false positive in the statistic.

> 
> I feel like we also found similar case that people send patches to change some
> behaviors that confusing them, but not really problematic.  That sometimes
> waste unnecessary time for understanding the intention of the patch.  Please
> feel free to ask question first, if you found some confusing behaviors and
> don't know why it behaves in the way or if it is a real problem.

I will ask questions on the first in the future when I encounter
ambiguous behaviors, to ensure we are aligned on whether it's a real
problem before drafting a patch.

[1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
    (Fri Jan 14 14:10:202022 -0800)
[2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
    (Mon Apr 27 18:33:50 2026 -0700)
[3] af738a6a00c1f ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
    (Mon Mar 9 18:05:19 2026 -0700)

Best regards,
Rui Yan
