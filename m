Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D244BCB8
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788604771; cv=none; b=E62cH7CCYCZ2Mfkv4SjgR+oXa3SJZnWIVSOThOGI7BejjLhSufYmMXUWPy14Qn0YX4gvROEEFF0IZKp2iO3kGTUF6yK6sENi/kgRQiqKjMwfYxIQHPfjLM1Jxp2K0l76eNgRb/GBWS5dFuOQm1kfkmluCvyFAIX+dHfagx6O9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788604771; c=relaxed/simple;
	bh=qKwArP0WigeNsSMiWM9fRKfNl+ixVag40Kpf76pLGks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8p6AkjLbMhsnx/1UNZC7i+XNVoCWob3yJMvgqtv1K4/pujDL5vT/2C5Iuws4s+uTp5rNi0+EmlJ9fvmWZmsAZ9MOhzPh2zQ+NqpBL07xlqLkRRj4z9haBM1vrYEjbfy4JYDkDrd1JPSso/p6EzWFpfRYQV8jBfI/9K6S1TOFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLXPIRDR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLXPIRDR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d560775ca2so13964545ad.1
        for <damon@lists.linux.dev>; Sat, 05 Sep 2026 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788604766; x=1789209566; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WXSZYdhEXRp/byDgRnPhYVP+JoRijs47XywpK06FLE=;
        b=jLXPIRDRWIZhUiZaa3YL1CZqu9OjOE+Sk5MT21fdcP2I1R+J8V9v1UrMATwheOZDpn
         OS7xrHsLIQ7QZ/3bXTrQOef7QrFvGeVBtP+1wymGhLXVZWVenET4l6ChL3owxBTYUDXT
         XyHf0VO7KBZX5OtazGbZMIzzOt3uvZs+f6IoWinQEbpd0pYeh7KBsekr5bJVC0CyecN6
         9VNzIyHA3XyBQypK9AxV8pCZ81TLyWUYvGOhniDLpKsORPmUZsU5SCgj1u9CEYuL4/Wa
         IHy7NDW4oR6suW+m6PP8KoCbMVK/GmS1gyic1gUJfnV8Il/Dp99XOcNLtJXWaGeWcqag
         4Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788604766; x=1789209566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WXSZYdhEXRp/byDgRnPhYVP+JoRijs47XywpK06FLE=;
        b=sV9B3DerNEkg7IHlDDT3Cc+QDUS3FD7ejd93/nBSVSTVcgAdOhUPbxQLCY127upnlU
         j9KcBhpMhbVhMqceQMkgZropRbPiTd0y3oXUWqHdM5LszgrTtuwQemeLq235X2VXNrqH
         MyVefBVgBIpAJ3IYJNPn78sFHhGpTtxHzDpkMEq1h3VBodLKaZ5HWYyklBwzT62UW5UN
         u3BPy7FzbmBCDsJQD2OyHz2k0w42SonI+7aSzkDJD+FzNxWRTq2aYSslPHwVuNza3A7F
         YpOErZwRodUKfx3GE8s/e+laZ9MPgIGmL6VHLgjCNZTXza14sfFe1hs+ZGfNimisux5y
         rKkw==
X-Forwarded-Encrypted: i=1; AKwUvBzeW6rs1yHmVFMKCsZWSOBMSMNfubvRzFf5azCGq1bTit2KUQqWpbMySihiGCuvdX6M9m9CNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kSVV8jiF8RVlZiIR1aKfe6iZydEY95I4+aROOIGfT09t5/5LVA
	Fcjt4o7qRlRZIUhIGng0qOZMAGzTIIWVhdnTrymlcZ1ZyxUf1idIGxmm
X-Gm-Gg: AYBFou14DcDZdtX9NWq/ne3u6+PMrKV7udEaAU98nsuNV8HXf8bocLsOgeZKrGdjNje
	oSyxfXuHJPD/maG7plpWEVE/bRtsjv+0/l2/y1I3jyi6WdodIRK9GdbwHBd9vvQLv1FBKw2uMIb
	bH1/XZ9EPOqZVNHx778EJhJXXAss89Ppjqpuol+bXg22G4pTvB2Be3lIUDEvGi/mVbN1npAb45h
	35myE7qFBkCN1EZuAY4R9h3zd1N/d73IgCwWvftUSUu/l6g3flpFWHEmxw/d7rbT4j5HppVDpuF
	eCrCHhRI1eCrRXzl81l3nuszqlUtTb/jtuy3QlW6yOAUy/qUo/VckXYf9O+kLSgjm7dYKiwkLrL
	S1d7NC9KDmKbeqmMQ+PKMWMZqZN7DzhUulLKhGb76u17/ugWsnnG+5KrByPiUyOg1vWhA3EZyDL
	p3IMJqUAKD5/n8G+eX2K5TDWgtMSdK3cH7Im0/qSGhdd1jhgpq03jNH/Cnc6In+qyW5kjVD2whX
	o1D
X-Received: by 2002:a17:903:198e:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2db125ca4b4mr188947935ad.13.1788604766401;
        Sat, 05 Sep 2026 03:39:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([115.164.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149ccf2esm21288335ad.73.2026.09.05.03.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 03:39:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Sat,  5 Sep 2026 18:36:58 +0800
Message-ID: <20260905103935.4871-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905002534.67885-1-sj@kernel.org>
References: <20260905002534.67885-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 04 Sep 2026 17:25:34 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri,  4 Sep 2026 23:35:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > That said, it's not important for me to add explanations to the
> > document, but may I know why commit [2] changed the behavior which
> > introduced by commit [1]?
> > 
> > Commit [1] Behavior:
> > 
> >     if (quota->esz && quota->changed_sz >= quota->esz)
> >         s->stat.qt_exceeds++;
> > 
> > Commit [2] Behavior:
> > 
> >     if (damos_quota_is_full(quota, c->min_region_sz))
> >         s->stat.qt_exceeds++;
> > 
> > Before commit [2], qt_exceeds will only increase when quota->esz is not
> > zero, but after commit [2], qt_exceeds also increase even when
> > quota->esz is zero.  I'd love to understand the rationale behind this
> > change to better grasp the design evolution.
> > 
> > [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
> >     (Fri Jan 14 14:10:20 2022 -0800)
> > [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> >     (Mon Apr 27 18:33:50 2026 -0700)
> 
> Seems commit c7ec7d5f6b3d1 didn't make a behavior change that you are
> describing.

I actually wanted to point out the behavior difference between commit [1]
and [2], but I've understood and agreed with your point.

> 
> '''
> $ git show c7ec7d5f6b3d1
> [...]
> @@ -2601,8 +2613,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>         if (!time_in_range_open(jiffies, quota->charged_from,
>                                 quota->charged_from +
>                                 msecs_to_jiffies(quota->reset_interval))) {
> -               if (damos_quota_is_set(quota) &&
> -                               quota->charged_sz >= quota->esz)
> +               if (damos_quota_is_full(quota, c->min_region_sz))
>                         s->stat.qt_exceeds++;
>                 quota->total_charged_sz += quota->charged_sz;
>                 quota->charged_from = jiffies;
> '''
> 
> And I don't think there was a behavior change.  Hopefully commit 54419bbd0ee3
> ("mm/damon/core: allow quota goals set zero effective size quota") will give
> you some clues.

Thank you very much for your clarifying :>

Now I completely understand why there is different behavior between
commit [1] and [2].  Because in commit [1], esz==0 only means quota is
unlimited.  After commit 54419bbd0ee3, esz==0 also can means do not have
quota at all.  But the qt_exceeds should just not increase when quota is
unlimited, that's why the current implementation is completely correct.

Best regards,
Rui Yan
