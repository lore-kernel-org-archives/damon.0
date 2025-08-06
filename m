Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773D1114
	for <damon@lists.linux.dev>; Wed,  6 Aug 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443688; cv=none; b=SdPYLbptrKxLdUemIXoPrxtIvVvtD1xaZQRVCBNEf4/JyT5nmWqilmua4kzP0u4YJ5kKjZplJThcY8Tl7kmBiKrSu9f8xZzJGK4hO54FJQ3O6EqtM0mVXn6UOj2OzKMA8DynobmrgbNRNbfGJOwwd8kCw9tfh4UQ88ns7n3dFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443688; c=relaxed/simple;
	bh=75UGmKi63vWlWvs53JfRNJALeLut97pl4NpjDjkn6hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDkQWMCEKxTZ9hucW2CejEZMun75ymVfQPAgzcLJWsawPjZIArBdOXJGs4uBT6S2NTMD+1d92qXH3rMPfblcJNeUcQN0PBS4dzuGCAonPQ93ckVPTSxu7EB/+eqLycyekrHjlmuhgoH4abFTdFI1Ou1WsGHW3HM2BA7FwtHfYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7VV0EqF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7VV0EqF"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af93c3bac8fso703028466b.2
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754443685; x=1755048485; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F174FEcKIx5bp+8tkyGPW+DIhLOLfIgidyWuudlk20Y=;
        b=Q7VV0EqFdzAtlvyBHLMtIJPkVXKNpOAWY93fc7LKfsZk4OSmGnNqQF1VTjBuToRxLI
         buBpvLilGwIFfr925BaaoP5rv24PzMel7n9uAuxPqvNHSozbkDL+1AQqHtpERKvNRgpu
         wIpmFV5jPrEpYg3Tu5J+ZTUat4xWWuhtjW+wz1iGYaPyvZ3GxjU4w2Ti+vTt2965S7og
         fr/lf9NvyR5hawzjQfxpxhAcbh9dgVf8n8AxIB1JTGPGbMaXDov72ruhGQM3NvQO+WHC
         iBwTa1agBchMt6NjEj+P56cUbm6cZRJR827/nJYOfjVu7rbqMS/0jMYUBfB/mzpM4V9F
         uJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754443685; x=1755048485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F174FEcKIx5bp+8tkyGPW+DIhLOLfIgidyWuudlk20Y=;
        b=wWoGrXxRkYwj4eYSkZTU0bx2H08TedyD/H0hdtBKVKYdP5vLhBdzwXmMtZCA9ASgU4
         REo7ZDrZUL43OMZVm2YnelRBkHdK2Xs3MhBTU+bqbCZMgiACgQCgGB5llu8iYWwoMpct
         +v6RGehLurB6ErcLopMNW1PfZRjBQ4ws/SBMeVf31Sb4mOWXlXkyUvlc7ZF3sVGHSNeR
         tvz2QyiVn23XPAaZx65RzdFvYJiytpctPRftCD9loCGz2Hda0hLaXXLSW0NrRSz4HGI0
         mRXDkJqyQppUqqC9hox7jERDYTTBo6KFWzqxh3AfKRb9RriAj9z/da3Hc234JQU/4VXZ
         6AFg==
X-Gm-Message-State: AOJu0YxcG44dABbsNWz9DoVWMu/ZsAZGfUnbmjOmWuExy/0mGL5TD0XD
	ywK4fjf9oIm4V9e6f8VAIT9y6ndp2Bl5o3ppT19bQPDvOONT3sWwyXei21cRdyGjoAiMQr6deHq
	T+eaAm6UvJglVfeCDQoyQ8siApJTPxmWSh33q
X-Gm-Gg: ASbGncul11jwWvrz8MdWkun4Qp2D7nv3ORehhZKOkArATZuunTNW1nsxJ+eXzk1ZVdv
	lT6cSqvTWnNbxJ/6gC0+ru8mPslXzSt6G6tW9XdMOWaatPKfNrAOiOQSRTSuPS/TjJBDN6j5119
	xRbcIMHjM5i1vi2KZlqjG+GOLsyp4fnThtKMMJqjv4KoqNyT+05uhZ66uj8ibsiVhue7fhApowI
	esQxpOy6orQenk4HuWH6hWxBxs7ZIPQraHyGxHLiw==
X-Google-Smtp-Source: AGHT+IEtxmGoVXyQi9biUweIxyKxBVbBBTXXXrLHkql4H2KhjN85v5kEqkNbiWpW4Q+t3I4jyPYF5sb+cMzt7HA9eSA=
X-Received: by 2002:a17:906:6a14:b0:ae9:c2b9:7eba with SMTP id
 a640c23a62f3a-af992aab7a3mr52454566b.24.1754443684401; Tue, 05 Aug 2025
 18:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250805162022.4920-1-bijan311@gmail.com> <20250806004003.52864-1-sj@kernel.org>
In-Reply-To: <20250806004003.52864-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Tue, 5 Aug 2025 20:27:52 -0500
X-Gm-Features: Ac12FXxqXWKYvb2iP2635uUmCnKs4Ru4zZPjGe2tc8MxztU1iI9ZJV3Enr-80ws
Message-ID: <CAMvvPS6hfCRh1fQh5zU5_quswPFVp0zWyS9N-Zikc0K-nSZd_g@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm/damon/sysfs: Add commands useful for using
 migration dests
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, 
	Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SJ,


On Tue, Aug 5, 2025 at 7:40=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Bijan,
>
> Subjects of patches usually be converted into lowercase when be merged in=
to mm
> tree.  I'd suggest using lowercase even in patches stage, if those aim to=
 be
> merged into mm tree.

Noted, thanks.

[...]
> > The commit_schemes_dests command, similar to the existing
> > commit_schemes_quota_goals, is used to commit only the dests fields of
> > schemes. This has a couple of benefits:
> > 1) It is more efficient than recommitting all the DAMON data.
> > 2) Doing a full commit resets the aggregation and ops_update intervals.=
 If
> > a user sends the full commit command frequently (relatively to those
> > intervals) the aggregation and ops_update events will be prevented from
> > triggering. Having a separate commit command side steps this problem.
>
> I agree the commit command of DAMON sysfs interface is inefficient, and c=
ould
> make the infinite intervals delay problem.  But, I didn't expect there co=
uld be
> use cases that use commit feature frequently enough to make the inefficie=
ncy
> and the intervals delay be real problems.  Could you please let me know m=
ore
> details about your use case and how severe problem DAMON is causing?

In my use case, I am trying to optimize the interleave ratio of
applications to maximize their performance without prior knowledge of
their behavior. To do this, we take the steps of updating the ratio,
observing how the system reacts to the change in ratio, and update the
ratio again accordingly. Because we want to approach the ideal
interleave ratio quickly, we update the weights frequently, motivating
the commit_schemes_dests. Similarly, we want to observe how the system
reacts to the change only after the change has been applied,
motivating wait_for_schemes_apply.

The consequences are not very severe. The problem can be worked around
by either updating less frequently, at the cost of converging slower,
or decreasing the maximum aggregation period, which from what I
understand may affect the access monitoring behavior.

> Depending on the real problem, I'm wondering if optimizing commit command=
 can
> be a solution.  For example, skipping the update of next_aggregation_sis =
and
> next_ops_update_sis when the intervals are not changed might be able to s=
olve
> the intervals delay problem.

This would work for my use case. Another option might be to have a
more general commit_schemes command, which may be useful to other use
cases. I'll defer to your judgement on which would be better.

> >
> > The wait_for_schemes_apply command causes the calling thread to wait un=
til
> > all schemes have been applied. It does this by calling damos_walk() wit=
h a
> > NULL walk_fn. This can be useful, for example, if a user wants to know =
when
> > new scheme parameters they've committed have been applied. Another use =
case
> > could be if a user wants to record the system state every time a scheme=
 is
> > applied for debuging purposes.
> >
> > The functionality of wait_for_schemes_apply can be achieved with the
> > existing update_schemes_tried_bytes and update_schemes_tried_regions
> > commands. However, having a separate command avoids extra work and make=
s
> > user intent clearer when used in scripts.
>
> I agree extra works are always better to be avoided.  But is the overhead=
 large
> enough to be a real problem for your use case?  I also agree it could mak=
e the
> user script cleaner, but adding a kernel feature only for user scripts
> readabilities sounds like too much, since the user script could have its =
own
> abstract layers for its readability.

Totally fair. I will drop wait_for_apply_schemes in any future versions.

> Also, even if the new command is implemented, since the DAMOS schemes con=
tinue
> running, the system status will keep changing.  If you cannot do the reco=
rding
> of the system state in a restricted time, the recorded information might =
not be
> that reliable.  So I'm not sure if you really need this strict waiting in=
 this
> way.

Fair. That was not something I was personally using the command for,
just another possible use case I thought of. Regardless of the
usefulness of that, the existing commands using damos_walk would work
well enough.

> Could you please share more details about what you want to do with the ne=
w
> command, and how much problem you are seeing?  I'm particularly curious w=
hat
> system state you want to record, and why you need to wait the exact time
> interval.

I mentioned this above, but I am using this to wait for new migration
weights to be applied before monitoring how the change affects
applications, but again, this can be done with existing commands.

Thanks for your response,
Bijan
