Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D0312829
	for <damon@lists.linux.dev>; Wed, 25 Feb 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045909; cv=pass; b=gUuyFuHDkXpE1R9XLOGJSkKMeDxO05QwBHfm6HvbtsMHX2KbgcobZq/oZZxuR1IWB6TFo5oCO0q+3kse3EaroQJlLeh69Qlf15OBkXrhy0LYTdbKsqCKCHQ3NHZYd41zGLIQ7ulCwZMtlHKbMvDsUv6zfQLrM/SKS5oGoj/YBBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045909; c=relaxed/simple;
	bh=NpKgxwm3BYjy0VCIdvPfujoYw+4fA8FzzoYFYYquMwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbRbKqslPklxf655gqarIguAIzREOonu0ZdSRtPi7RFuKLJabc0WpO+SxWBtIPmp5cPPfgMC4hKhDXjFhhn7tISMwASOljpceMvPyGY7TCQxALnWeReyfneT18bMkPh23xIP2DLnnul9HRaQVvV1qnhvjM3f6KUfUSCktDSv0Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+RSYJhc; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+RSYJhc"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-127423bea4bso725c88.0
        for <damon@lists.linux.dev>; Wed, 25 Feb 2026 10:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772045907; cv=none;
        d=google.com; s=arc-20240605;
        b=aIHvKaIhvwAXOs8fu3PGWZ9XUxM9yj0O+NMaSV6q0nwTJTOeFopOGAJdzTb29hSwdk
         fxnHANMU4QiWN8F9WhaCVhfGVeobdFvUDuA2KHt35AGaX2YBt/SeMBtc4VdyWfyza+YJ
         yk07OnBtHhlmzu4hEDVhRsoahI2O59OHvzlTTSqGbTSO3kO956Sm9UkvhHybxoUtdzpK
         eGF9PuNeztiXiYzrevYgmX8Jt3Ea8cxk5o18W72WP9QrWFM1WhXPE7NHsDoWWuCZL7Fz
         Lt9DIHJAnklBQ7KsbGdOwTdRtZl/UVk6JZDJHMbSyP6ovxMUaOOuyY87k7EVGJleSMvG
         yJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ArROPpjnJzj85QG9odZcXqmuIgynPaSR2+psVn75qQI=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=BGTH012bLbsglibJMYyZDaplwvH0CXsZLxLZbnGtN0tGigzQOo0+JlzMvu64BWmyye
         sBMFGNvhhgFqngxcVfE6XDhrewP2f+bv6+CcJA/J35PGvLG/CHRWP95SnxxjMB7wpitj
         k/yb0pCtaLcvj2SO+G8W30O/sUULVqp9SOxbD+m4nfFTGG0OpId8tW1IMyPqsoOB5x1I
         m1rNIFtmZKo/UjZjfPwxkHf6/RsKefev/zZhFaBDaKQplpsGyDLHzNCvUsQ0RvgvPJOs
         HWjj6mqlQs51woJurmMLSfgL+nrsKOoklbcQbdBaEYJgu+AOycPlk3i3Bk6XHexyHUtx
         fESQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045907; x=1772650707; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArROPpjnJzj85QG9odZcXqmuIgynPaSR2+psVn75qQI=;
        b=e+RSYJhcZsp6NS5edpTglIe2JRhzpFlFQBwgdmDT2VLUxSVad+iCpQY10MvARAc3Bg
         dRri47nNXdoaAnqpl4j28c7aZTJQu4APMT5B4Aqel2U0kDKIrH+iUAp0qICenYrCYwei
         AqMfEwAWmcApE7scpoAR9Br91sLTsvEeh843N0iAbOT+JEBt3ZRlygk7cdUOQ5BOL315
         SPBG9a6jYxzCWXucF/YA2esMT/czMpHi47q+gyqbca17iRCNkq2YKjUGPm3XfPmtfMTT
         sdvLvXxywzxmA/0xy+aYc6Yn1/TySd4Hng4RdtAsY6Ecgj5JZVbb2ADoof00UVBYnqXi
         /VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045907; x=1772650707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArROPpjnJzj85QG9odZcXqmuIgynPaSR2+psVn75qQI=;
        b=I6o0qjmmSxBhUcCBWsSh2LD+7BjToUda6hF3gJItSQl3HhYquSdESqlD6nx+DCpmeY
         SNpnRRfQjb4YsSmk6ZbX1yBvZ9XPJCu/W12PvCuhrGHs9N3M/XjtF70XcJQi7mHpEtL9
         iUkqjEA7fDcop7fbxSyIev+i943oEdaih/uUgyWuMgOX5XBc49Y2D1hkH/myT6FZs+fh
         18BbBzwwKrflJ+YBpyZaBqxwp/aXiVmIP2XDMMNktrGFA9dMaifBqerNzMDJ1EHmoJ5N
         wpNolFlMbKqBpjXr/JHwYa33MDxmDpEP1/82QlJGskqnxSMLVHLQHQqsFBijV05rGEVt
         qrZQ==
X-Gm-Message-State: AOJu0YwBaJZlm/9t45fzDJIbgxMiD98VWb2GelqeR0b/fEHtzR940P7n
	nYw6n/OxqhAsz3AK34enjABTZZlfycYTkZKipclIPnpnX1xB53XqXJIMzMbR5iB2fpRWRtMWSSf
	1HcANmBGD0zPMOmuxFHFIsFfDWR+G1UuqzfQDyUcp
X-Gm-Gg: ATEYQzxqQLeAR5kSjVR/ZadiMsc248Ytz/ydN8BTylZ1lsn5Y6g7rZYqBcQlTvmKHfZ
	4TY7aLDbfKR677oX05qEJUs4ueThtfIXIf5XZtYqSSOQkTHWpFND19lUBt5MLnOxTLOiXaHNYhD
	Vva9YCCER7qPZpFRnvj/yYm7Sc5bluuTBk06yWRHR2zRBzAIpGchCf1SYQSPeN6rR9waQ+yHIrc
	SJJ3EvfRHLu+5GXdVSPrDkqCTyxmZDNTIfUP7NBox2xT9wdIV+tMTuMvDkrQj6QOs+GgQfSpT0W
	8AsJahQ=
X-Received: by 2002:a05:7022:4589:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-1276ad3fecemr6585546c88.40.1772045907494; Wed, 25 Feb 2026
 10:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260223123232.12851-5-ravis.opensrc@gmail.com> <20260224055451.58713-1-sj@kernel.org>
In-Reply-To: <20260224055451.58713-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 25 Feb 2026 10:58:15 -0800
X-Gm-Features: AaiRm53tTS4j79q29YaqOt6DqbWcBTOrpnxU-5ZG60LfsiyErPqmfboGnXJ-bZE
Message-ID: <CALa+Y14yVxW+NSP6-G+93yHFLKhFhvKMQowGUR1MBcPgvO_q-A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] mm/damon: add PA-mode cache for eligible
 memory detection lag
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 9:54=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Mon, 23 Feb 2026 12:32:32 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > In PA-mode, DAMON needs time to re-detect hot memory at new physical
> > addresses after migration. This causes the goal metrics to temporarily
> > show incorrect values until detection catches up.
>
> I agree this can happen, and could be problematic on some setup.
>

Thank you for acknowledging the issue.

> >
> > Add an eligible cache mechanism to compensate for this detection lag:
> >
> > - Track migration deltas per node using a rolling window that
> >   automatically expires old data
> > - Use direction-aware adjustment: for target nodes (receiving memory),
> >   use max(detected, predicted) to ensure migrated memory is counted
> >   even before detection catches up; for source nodes (losing memory),
> >   use predicted values when detection shows unreliable low values
> > - Maintain the zero-sum property across nodes to preserve total
> >   eligible memory
> > - Include cooldown mechanism to keep cache active while detection
> >   stabilizes after migration stops
> > - Add time-based expiry to clear stale cache data when no migration
> >   occurs for a configured period
> >
> > The cache uses max_eligible tracking to handle detection oscillation,
> > prioritizing peak observed values over potentially stale snapshots.
> > A threshold check prevents quota oscillation when detection swings
> > between zero and small values.
>
> But, I feel this might be too overfit solution for a specific setup.
>
> >
> > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> > ---
> >  include/linux/damon.h    |  45 +++++
> >  mm/damon/core.c          | 421 +++++++++++++++++++++++++++++++++++----
> >  mm/damon/sysfs-schemes.c |  30 +++
> >  3 files changed, 460 insertions(+), 36 deletions(-)
>
> The size of the change is quite big.  I'm now curious if the problem is
> significant enough for this size of change, and if this solution is only =
the
> single and the best one.

I understand. The cache was consciously separated as patch 4 because it
represents ONE possible approach to handle detection lag - not
necessarily THE approach.
My goal was to share what was needed to achieve equilibrium with my
synthetic benchmark workload,
while making it clear this could be dropped or replaced with alternatives.

>
> First of all, I'm curious if the problem is that significant.  I assume y=
ou may
> seen the issue from your test setup that you shared with the cover letter=
.
> From my understanding of the cover letter of this patch series, however, =
you
> are testing this on a setup having two complementary schemes.  And you us=
e
> TEMPORAL tuner.  The motivation of TEMPORAL tuner was for setup that not =
having
> a factor to move the quota goal value without additional intervention.  I=
n
> complementary schemes setup, the schemes becomes such factors for each ot=
her.
> In the case, TEMPORAL tuner might be worse in terms of the size of tempor=
al
> oscillations.  I don't know details of your test setup, but I suspect the=
 use
> of TEMPORAL tuner might made the issue bigger than real.

That's a fair point. I chose TEMPORAL because I wanted to move the required
amount of pages as quickly as possible to reach equilibrium - essentially
"migrate at full speed until target is reached, then stop." For my multiloa=
d
benchmark with uniformly hot memory, this seemed like the most direct
approach.

You're right that with complementary schemes, the schemes act as factors fo=
r
each other, and CONSIST tuner with its feedback loop might make the detecti=
on
lag problem more manageable through gradual adjustment.

>
> I also assume the real world people may use DAMON with auto-tuning mostly
> because they don't know the access pattern of the system and assume it wi=
ll be
> dynamic.  In the case, even if we perfectly solve the issue, some of
> oscillation will happen.  So, I think the issue in the real world might b=
e
> smaller than that we can find on some specific test setups.

Agreed. Real-world workloads with mixed hot/cold memory and dynamic access
patterns might behave differently from my synthetic benchmark where all mem=
ory
is uniformly hot. The uniform-hot case is essentially a worst-case scenario
that forces continuous oscillation regardless of detection lag compensation=
.

>
> Meanwhile, the node_[in]eligible_mem_bp concept makes sense to me.  I'm w=
orried
> if this patch is unnecessarily delaying the progress of the main change.
>
> So, unless we have clear evidence of the significance of this issue, I'd =
prefer
> dropping this for now.  After that, if the issue turns out to be signific=
ant or
> this solution is proven to be significantly beneficial, from your next mo=
re
> realistic test setup, or from real world usage after upstreaming of the m=
ain
> change, we can revisit.  What do you think?

I agree with dropping this patch for now. Let's focus on getting the
core metrics merged first.
The cache mechanism can be revisited later if real-world usage shows
it's needed.

Thanks,
Ravi.

>
>
> Thanks,
> SJ
>
> [...]
