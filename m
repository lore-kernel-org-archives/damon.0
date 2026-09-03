Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCB4A4416
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439456; cv=none; b=Dl5pVWfmcqykn7cKaSK3S4ZcOCUXZJvVTnKvOvH+2EE6knWpq75AIEA+4lkmj+FDnsWeDoIQ9NJMQHELd6wCAK36TjhrsBSBvzCQGdJ5rwcHvLLzlvUDDUVGB0m/3+zB9C9Ssk8a/hXSi5IWOdcxRmFnhLsH7k3dv3kgIEaay2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439456; c=relaxed/simple;
	bh=qWCj6/FKwNR+w9ys8WEEcPnqWL6QEM9dEnsZ80xAZrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAyZ2+3ak5XP31JTw0P+iiqDN5VQrjZTKAPxusHhOUHN6gVyEILD36ovlVayOi9CkP+3spFhCF+ZvOuukBGGQbqPjhwhwAaeU0zZVYT+Xuwbw0IlhdUvSaBc70CASg6VTfcgDlKlNJs/td4gHs9QLloLFk2xA8hZPEOlU//VNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okvjoecg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okvjoecg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8fd3b729dso20365285ad.1
        for <damon@lists.linux.dev>; Thu, 03 Sep 2026 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788439454; x=1789044254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1JpLmeHcDYci9TjzZaOlT2Qs79rEF11KvKmH8LlIEc=;
        b=okvjoecg1z1Rd7nHriChAfG17O11269SFH8mNTwaT288n5OhmXrouXckiGa4r96ZPN
         S+GI+pKwyoMjYMsxSkxNU86Q87S8Ey8hIU/BYFsax4lyfJ319/ZPr4z2/4MLC4UkCHzJ
         nzbn8HMPeET0vpsvFElMJcg3YVOvsQ1uStLRcqr7Gbk17PZZKpleRU9V/56nWT5M1AzP
         g0KZmGDAQIHISynF0dSJ10CR4AYJc/zrFiKwwP268ChRfkCLV7CCHRSEyQMS4VjebjG4
         s970eSbriEHL2oA4c7c80wnm/xtpAcN6I3Nuu9U7FFYhtKPZAfW8cGqcmwpnO3wATxBg
         uwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439454; x=1789044254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1JpLmeHcDYci9TjzZaOlT2Qs79rEF11KvKmH8LlIEc=;
        b=rai0YoqTfxY8gPOo0zF18qIWZhm6OA8xvqH5QcYrS+Tn/sTiFxuyisrtm110yCF0AI
         HCNzaqLzKVcRH4KCx/nHxrkRvhHODWu32NXHHqQQ+B0XIVuWvPHR2xtAE27TeecsFZct
         o7yk7VwoA5zMCqCN5I78Rls6tkJftHgfLR3jIrQlB1I3bMKKOH4uFRwkeWta2xd8Fdqd
         Npt+czhL0jIuGGHu6gBB6jZdv3HfiHtEQE9dOqVq7lma47Sg6JAOviD3k2GpiP/E8KD2
         jNA7qmlugBXk65gCEePgb+5c9FjTm3ecqDV5UQLeK9mbrVPqx+j2QYSKOCrC/w/F7h81
         lmOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/QsGXQVc8lcWiM9osxW25Qp/6l32BQghaSfXFmidpwfKnqj65BnO+gPFX+kOV3z0GkACI/g==@lists.linux.dev
X-Gm-Message-State: AFuF++lzS7Xbsl9hylK/iX2EvGiNIWHxM/Sa96iIM2HbraURCui7LHrJ
	Vfm0pcr3lvJmgMbFyh2O9+JV4arZSQWbZbz1xScc3bOZmG9SMgT+khXg
X-Gm-Gg: AYBFou1bUhG8aF2mTK2P+XKYpM32tSbNYm6mMf9ibh2kWyIVnVuzGeEhXA6YurqLMTr
	xpAqyCVkLd1azWjjRKQRD8nmowyH2NeazRrNYkS70jblXOYEUri+r2tJT9Oa9OCQLIrMhmrd8JD
	2T11ghgGXX2Icn4FCkyxFK+pRv/j+0283+9XA1GUdsb/JqRNHmnPJfuJqqGyiZwqkyL/1yshuOB
	OkWrizJEal8IkYbrvWcj8VmIXl131dCNGvrIK46OBSVp6UeGISaexAfHn0NOwFTyOVL1XB2iFXy
	RDeQngCDAMDcJtajUxJlCg5+tcfllqEHTIjtfDydRZJKT14Wr8EBV/H6neHuYbOflX7jnynr1ZH
	0vvOEb6evQfFkOSt2dLA08FmJU1G8DMj0XUtdJjb1RlQ5C6cPXPwx+Tp3q9nKW5u1hkwN7ji8Qk
	A9ASeVrI6GdxS3IupUtrUxMsUCmnhHxS5qa98oDs/ENj+ZGpuHksrepgcLjzGT1F7KzWrpufFE4
	Nsw2p2vZOqY/xOr
X-Received: by 2002:a17:90b:264e:b0:398:dcf6:d40e with SMTP id 98e67ed59e1d1-39aee0c16cdmr19784168a91.17.1788439454461;
        Thu, 03 Sep 2026 05:44:14 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc060sm6268339a91.3.2026.09.03.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:44:14 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Thu,  3 Sep 2026 20:41:48 +0800
Message-ID: <20260903124422.5340-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903003351.91088-1-sj@kernel.org>
References: <20260903003351.91088-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 17:33:50 -0700 SJ Park <sj@kernel.org> wrote:

> On Thu,  3 Sep 2026 06:31:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Wed, 02 Sep 2026 07:48:03 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Wed,  2 Sep 2026 22:22:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > 
> > > > On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:
> > > > 
> > > > > On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > > 
> > > > > > When setting goal_tuner to 'temporal', if the goal is achieved,
> > > > > > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > > > > > will always return true, even if no regions have been tried to apply at
> > > > > > all.  This causes qt_exceeds to increase unexpectedly.
> > > > > 
> > > > > To me, this looks logically correct.  Could this cause any user issue?
> > > > 
> > > > Yes, I think this might cause unnecessary confusion for users,
> > > 
> > > If it is _might_ kind thing, please ask questions first, or add RFC tag at
> > > least.
> > > 
> > > > at least
> > > > it did for me.
> > > 
> > > If it confused you, definitely we need to fix it.  But if it is just confusing,
> > > let's try to clarify by adding documentation, rather than changing existing
> > > behaviors.
> > 
> > I agree that we should avoid unnecessary code changes if the issue is
> > merely a matter of confusion.
> > 
> > However, I believe a code change is necessary in this specific case,
> > rather than just adding documentation, for the following reasons:
> > 
> > First, this distorts the semantics of qt_exceeds.  It is a statistic
> > meant to track actual quota full/overflows.  Incrementing qt_exceeds
> > when the quota is completely unused (because the temporal goal is
> > already met) misleads users and could break user-space monitoring tools
> > or scripts that rely on this metric's accuracy.
> 
> As I mentioned in the previous comment, this doesn't look wrong to me.  I
> understand some people could think differently.  That's why I think this is a
> matter of clarification, not a bug to fix.
> 
> > 
> > Second, considering its original behavior when it was first introduced,
> > the recent changes [2] have inadvertently altered this behavior.
> > 
> > When qt_exceeds was first introduced [1], the conditional check was:
> > 
> >     if (quota->esz && quota->charged_sz >= quota->esz)
> >             s->stat.qt_exceeds++;
> > 
> > Later, to handle cases where 'remaining quota < min_region_sz',
> > damos_quota_is_full() was added [2].  When this function was added,
> > quota->esz was replaced with !damos_quota_is_set(quota).
> 
> I don't find what's wrong with this.
> 
> > 
> >     static bool damos_quota_is_full(struct damos_quota *quota,
> >             unsigned long min_region_sz)
> >     {
> >         if (!damos_quota_is_set(quota))
> >             return false;
> >         if (quota->charged_sz >= quota->esz)
> >             return true;
> >         /*
> >          * DAMOS action is applied per region, so <min_region_sz remaining
> >          * quota means the quota is effectively full.
> >          */
> >         return quota->esz - quota->charged_sz < min_region_sz;
> >     }
> > 
> > With the introduction of DAMOS_QUOTA_GOAL_TUNER_TEMPORAL [3], quota->
> > esz == 0 carries two meanings: "unlimited quota" and "should not
> > be applied".
> 
> I don't find how you think this way.
> 
> > This overlap causes the damos_quota_is_full() check to
> > return true incorrectly in the temporal goal scenario, leading to the
> > false positive in the statistic.
> 
> That still sounds like just a matter of different interpretations.  Let me know
> if I'm missing something.

Thank you for keeping this discussion going!

First, I would like to clarify my intention to avoid any
misunderstanding.  My actual goal is to fix the semantic of the
qt_exceeds statistic, rather than necessarily changing the underlying
logic of damos_quota_is_full().

Currently, there is an issue with how qt_exceeds is incremented.  When
the quota is set very small, qt_exceeds increases frequently.  This
produces a statistical trend that looks almost identical to the
continuous increments caused by the Temporal Goal being achieved.

The original intent of introducing qt_exceeds is to let users easily
notice if the quota is too small.

Commit Messages [1]:

    mm/damon/schemes: account how many times quota limit has exceeded

    If the time/space quotas of a given DAMON-based operation scheme is too
    small, the scheme could show unexpectedly slow progress.  However, there
    is no good way to notice the case in runtime.  This commit extends the
    DAMOS stat to provide how many times the quota limits exceeded so that
    the users can easily notice the case and tune the scheme.

However, under the current behavior, users are forced to manually ignore
or filter out the qt_exceeds increments that occur after the Temporal
Goal is achieved.  This adds an unnecessary burden to the users and
contradicts the core goal of making it "easy" for them to tune the
scheme.

If we agree that this adds unnecessary burden, perhaps we could explore
a minimal fix at the point where qt_exceeds is incremented, to skip the
count when the Temporal Goal is already achieved, without touching
damos_quota_is_full().

Please let me know if I'm misunderstanding anything or missing some
context!

[...]

> > [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
> >     (Fri Jan 14 14:10:202022 -0800)
> > [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> >     (Mon Apr 27 18:33:50 2026 -0700)
> > [3] af738a6a00c1f ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
> >     (Mon Mar 9 18:05:19 2026 -0700)

Best regards,
Rui Yan
