Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA24FB9B9
	for <damon@lists.linux.dev>; Fri,  4 Sep 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536189; cv=none; b=am52BpsWUfxESJxvqxdSgT3kKtQJIJcEJny7if6V6pcd+rzxmfWxqX3Dpclxkyw2uTjDLhmK1DMLO1o+xnvQua5DV8pXEqEY+iG+Z7DUoSXupj2X784stDJjFGMm/qCq1DihYo/3h6xhZXufre8IZYUQ7D1m3ryjn8v/qerEH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536189; c=relaxed/simple;
	bh=yEI4BV6iNvGNTp6yVxJz/nr+ZKBl7Obpkxk5Yr1QfAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTGeq9HjannmkT266oRhbGT8VOjBon2Ep/5Tsm5IyrxYfnjPDh+4fcNGeGN+Cz98qm0YehMP6ZrA0BuTc7Z6koUv6HqmtUtl+UWTQM6dtdVKNZQ9Aa1a7U6Ws5C91b4NXAGQXzh9bnKaK8OtRK7QuK+00bF1k+orLr91hacdke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sj5I3EBy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sj5I3EBy"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1097526b3a.1
        for <damon@lists.linux.dev>; Fri, 04 Sep 2026 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788536187; x=1789140987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owo9HPKkc5Wy9mPuxsDxORlEguNqRT/FIkEdbsJf07w=;
        b=sj5I3EByRFlp4QNQkWKEhRsonpowhYRd0udGcMldC5wdIPEcdUsnmlmA6CZUfyjla6
         yybQRVCqrky/Teq4jHpkf44f0TTyRjrdSyJTJvV5E+7V85Zhzhr1JqccSHzTTPzc83JR
         PbENT6mo3V0ctbQJBllIHaC7COl6pVGVqIF97yMrBVAdGWZqAYGblqc2ldBtm30+IRky
         MT+i8aBsNCdeE+SN35rgOvF35JvqhoyNuAsRrOPGZapYLmNSjcOEruQsJ+pxuXF6+Tbl
         DzAYPNM4KAW9uhCVE+n5XVnWStUn53pNNmFCH6spBHkrUkDSAqJLrfKs1YwsJUqKzCW7
         cEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536187; x=1789140987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=owo9HPKkc5Wy9mPuxsDxORlEguNqRT/FIkEdbsJf07w=;
        b=sWtXIs0c89ZnsYYBKJESZD7biQyemHDZ38xlTr5BA81gcj79lmAChqsL9xMyMVcuEM
         TN0/jtKNfd0ZFamVuGMnuQe3BmGVq+CmfEevcOLB+hc/wgOgupTtE1/wdJW4qMsFSfkK
         HAJgpKxvPaiSRr5epbM8FWXEr7Bh94sKGd8am765tcHOBlitv9wkEPnvTrilk8npI+XA
         RZyb65rUGdxpUNoAtUu0XRMudR6RN3v9Ct/eBt+WlBezc4A672h9ZUlpkm1C5s9UsT7t
         5jfTQSvDQsEfgGXazirgrjtmxsz/h1Ifyncf3svl83doFm9A9099OO7iEVGZ2o1sSck8
         y5QA==
X-Forwarded-Encrypted: i=1; AKwUvBwK6FAf7K90BFJWVhNJwaIt0KcvKIelTssqCQQTfyiagsx5gQVPFFW3/lYZXoJ+dMce73e1DQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nX+Bvho9FMbi2npugg5kKo4226GLZzoi5rVv3AgYyiRv78yCqm
	H81ElU9qihbQXxJw02RlOyyjfRp51NNz/B4cOx0hNYoICovDF1YmKe4S
X-Gm-Gg: AYBFou3Kgl9/Es/JsDRYzdqMbZf/ELVvdLAyO2XQAt36qBCAuJrdAg05trEhiMpfTq2
	XTFKkbDZ/Is76TcbHvBDeH9Fhqc9oUsIZFxluZXS4w2keMZYNDR6+0oLAs010G5N5vMiGg68QRZ
	ZvAfb6A9K3ThOQnQ6tI5Z5G4LgMAEk9R2Wylc4FcDTTS7k7HgEl0rMkYU2N7ByWDE6gYa8+CBi4
	iNZBAwCB9sY2SfoPF+MlRo3zTOzdGpETERNQDlP3gfWOrWg/A53CoFwq2DYjqQFI7aXDI6CwaUS
	vToIk+BrJ98DyulDgiah9QmqfUvS52BojUpJLGynezFK+EKGQzolvCAySzkVhqtVaSouJpTWkmF
	yk6OGMiObSFNOCZsv4PrMr8dJQexH8fWuM6khv7CF/Nq3P5mMgU0t0pw/6+viP03CFB8OvswquY
	5B3+QfAwatMFV4K/yOZ0/o5kj4bg5rCTPxe/XUuDxrFjW8F18TQyVG9GVY510rbfQr0M2uxlqgD
	titzSsHMVIvO2c=
X-Received: by 2002:a05:6a00:b91:b0:829:b08f:7353 with SMTP id d2e1a72fcca58-8619ae94866mr5005293b3a.7.1788536186798;
        Fri, 04 Sep 2026 08:36:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2001:f40:906:1c06:7a81:226b:e033:d971])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152f32447sm1277202b3a.38.2026.09.04.08.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:36:26 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Fri,  4 Sep 2026 23:35:38 +0800
Message-ID: <20260904153637.9670-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904140535.64833-1-sj@kernel.org>
References: <20260904140535.64833-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 04 Sep 2026 07:05:35 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri,  4 Sep 2026 16:07:41 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > First, I'd like to clarify that this isn't a problem encountered by a
> > real user, it's just a scenario I came up with.
> 
> Thank you for clarifying this.
> 
> > 
> > 1. Users sample qt_exceeds periodically (e.g., every 10 minutes).
> 
> What's the purpose of this sampling?
> 
> > 
> > 2. Within this 10 minute sampling interval, the counter aggregates both
> >    the real quota exhaustions and the increments caused by esz==0.
> > 
> > 3. When users notice a high qt_exceeds value, they eventually realize
> >    (perhaps by reading the code or documentation) that it includes the
> >    counts from the esz==0 state.
> > 
> > 4. To get the actual quota exhaustion statistics, the user is now forced
> >    to perform additional testing and implement external filtering to
> >    separate the esz==0 increments from the real exceeds.
> > 
> > Even if we explicitly state in the documentation that qt_exceeds
> > includes the esz==0 counts, it still burdens the user.  The user still
> > has to figure out how to filter out the esz==0 increments externally to
> > get the signal they actually care about.
> 
> Users set the temporal goal.  They can know when the goal is achieved since
> most of the goal metrics are already exposed to user space.  Users can also
> show the current effective quotas.  I agree that can be cumbersome, but how
> problematic it is?  Also, as I asked above, why they want to do this after all?
> 
> > 
> > Honestly, I struggle to imagine any valid use case where a user would
> > actually rely on the qt_exceeds increments caused by esz==0 to make
> > decisions.
> > 
> > If the only purpose of qt_exceeds is to let users "easily notice" if the
> > quota is too small,
> 
> I agree it could be a signal to show if the quota is too small.  But the real
> purpose of qt_exceeds is, in my opinion, letting users understand how DAMOS is
> internally working now.  After all, how much quota means if it is too small or
> not?  That all depends on the real use case and complicated things including
> their SLO etc.

Thank you for your clarify.

> 
> If documentation is saying the purpose of qt_exceeds is to show if the quota is
> too small, that is what need to be updated.

I completely agree your perspective.

This is the current documentation of qt_exceeds:

    - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.

Although it state the purpose of this statistic, I think adding a
note to clarify that this stat also increase when the quota is zero (but
not unlimited) would be helpful for users.  For example:

    Usually, a quota of zero means the DAMOS scheme has an unlimited
    quota, so qt_exceeds will not increase.  However, if user sets a
    temporal quota goal, the quota is set to zero once the goal is
    [over]-achieved.  In this situation, qt_exceeds will still increase.

I can prepare a formal documentation patch based on this if you agree.

[...]

That said, it's not important for me to add explanations to the
document, but may I know why commit [2] changed the behavior which
introduced by commit [1]?

Commit [1] Behavior:

    if (quota->esz && quota->changed_sz >= quota->esz)
        s->stat.qt_exceeds++;

Commit [2] Behavior:

    if (damos_quota_is_full(quota, c->min_region_sz))
        s->stat.qt_exceeds++;

Before commit [2], qt_exceeds will only increase when quota->esz is not
zero, but after commit [2], qt_exceeds also increase even when
quota->esz is zero.  I'd love to understand the rationale behind this
change to better grasp the design evolution.

[1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
    (Fri Jan 14 14:10:20 2022 -0800)
[2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
    (Mon Apr 27 18:33:50 2026 -0700)

Best regards,
Rui Yan
