Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AF83A1E60
	for <damon@lists.linux.dev>; Sun, 21 Dec 2025 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315077; cv=none; b=RPtPP4sOgXVA4KNku3q49sVLl3HymePMZicJS5kjqbtxkzE07ov5mHSWfXR3kKV3lLdN1Wut449vFXQWKsmgs9km1b8gTGy68GI93nYxuo6/iewOelrTEDhWzX8D7BbzpuWYq5Y8LpRkxQPuiADsSI0G+DtJHbmUzrk2hxfLCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315077; c=relaxed/simple;
	bh=I595f1foj3eC0vq0+VMOsusORN5Il+9fswrHpJjXRto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rl9ABHjGKv8N/vKfTKLwYIXLuzbPKFpZZ9gn5keRUUExgKAM9lN2pouQRLqBowZKDQ8jx5dfPCpuUuw1vuihshC5j+zDVpbdU++XFb978K4rEC2bRHgbs2F3Nuuuqt8Bc4KqmfFOzXG2pdlZa7r+v2jgzCQKCqUHz/lVMBM9tIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAvxWGJB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAvxWGJB"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78f99901ed5so27877157b3.3
        for <damon@lists.linux.dev>; Sun, 21 Dec 2025 03:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766315075; x=1766919875; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSwYcxorWh4XDBwCG+RMDN991xiQ2HYSQWjQd/bUtbA=;
        b=KAvxWGJBjC7RjeZhv9jEhr0p58z/8DWG7fXXGFg53cv+f7G6eVuhiFTRX27BFgzpq9
         heyZ7ZyXLZP7/bodq3V4k8rApSijyQlg13VuoVKBNEgWzSe5dCRhfiYY4oqGwMHF9s7j
         s2v9H5lmnldqCLWRo3APqfbKokr1fAnOHR4ogn6MMxzgYJgnBydyuOlJer6t4hEOhbNo
         7PTNdwGi/O68SkRb8dap2/UZuLTWDrQS5ZAeuqPQ7kn9RA1JXfWUEOTdwiHpniW8nzAX
         5ji/rkqTv14t5WyNcv7LJyc6ay6xLG4mMMsLOZV2dxZzvOmE2OupyOWMLEZXnwHcuJIS
         v4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766315075; x=1766919875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSwYcxorWh4XDBwCG+RMDN991xiQ2HYSQWjQd/bUtbA=;
        b=fPNbXhFYOXaYoCJkQzGYOSLcpXa939iep823Jajaq7ifA/7vRwegboFGxWXwWj/QEh
         DBy9dErYhKK9tfd/h9x+hzWuzFE5AKxihZAyQCfFTk+6ATH6DY8SxsoZShQsFWKM9tuD
         sMDbb5RL9fTAP7Q0qDWXPlxHWXzQcKBu7pUHdjGdubKe9QMtpRp2h2SYBYsDJA57M6DD
         bxJFwThn+pOwFco0xD1qmQbc1VpmD3xM30yvmG7aCYJ1x+Md/2WNM7vH6awsrw41vWGr
         BKM10efEk4A3Q6JSzssZl6vgv1KbcBOQQc1XRqmh0gGKLU9tIMur3H+iGwNmTovJN0jo
         Vzjw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ61hSqdj81TmqUbqsZm41VN6a+L0Eu76yqi9JEPoeyNCs788sB8zYCCm7wlt2xrgvYrloMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPLOsMFZ/nBQliaAxDXWGB1l1xosZhk/NXiwAIjOoOk7Gzc2Sk
	U3797/kDeSm7PQ19grpfX34ehi8qc1I3J49p/RAWu6FE/FUUAaiBYaj4uMuhK666Q3UymH6Bxlb
	Gs38dxiQ9GKg/nlFyWNjot69VwTWMYOQ=
X-Gm-Gg: AY/fxX7uJYTYxYK/dtjgQog+wnYIs2Zm2GkwhV5s5w8q+bQK/dW/MnRMbYzNZZBwCyI
	nqUUhWMyNL9YD0nbUMGxT8qzxUGMHK9gBSB/dFdn4WpCfFEVw1djYDmZArUPwFS9pEOcBgbmuiP
	pbV8J3L7gnY/s1pKOIW3NdRkJCepnHWUBKDKMOJOO3qvUuI+6aQsXBqLiQ46ab8UEr8Ol/Jt8sn
	VHFTvGZCPZOA7sh1iqTYnEA+zjTe5O/nhLPZdVZzTtH+XUVlQPjQhloZ3R95qgd7jVkbiTUGov/
	o8yYa2g=
X-Google-Smtp-Source: AGHT+IG2Toq9qnzszzjdL+98B2Dr0jFCu0YHg3Tjd/aDjfzvUu0GkQ62iWiS7373LlpJYGVJK3BGOt9VJWAkIY+a6BQ=
X-Received: by 2002:a05:690c:c4f6:b0:786:5212:4a7b with SMTP id
 00721157ae682-78fb4084d8dmr69652507b3.58.1766315075027; Sun, 21 Dec 2025
 03:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC7=t0iHEC-BQPZcF+KiKcc2tVyxNOLMifZQ=JwH2GwFpw@mail.gmail.com>
 <20251221081227.42071-1-sj@kernel.org>
In-Reply-To: <20251221081227.42071-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Sun, 21 Dec 2025 20:04:23 +0900
X-Gm-Features: AQt7F2oEjHHI5p4OWYHfOqEy5bd0bgpAsDaewTxzhRqzUDMezd9tbvBE7MH7ytE
Message-ID: <CAHOvCC4opA5kdX0c3RrUL0g9e95JJb5hr=ZaGS7FGoQ-nxgF3Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/damon: export symbols and introduce prdm module
To: SeongJae Park <sj@kernel.org>
Cc: Enze Li <lienze@kylinos.cn>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, enze.li@gmx.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Dec 2025 at 17:12, SeongJae Park <sj@kernel.org> wrote:
>
> On Sun, 21 Dec 2025 11:42:43 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Fri, 19 Dec 2025 at 21:52, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Thu, 18 Dec 2025 21:46:37 +0800 Enze Li <lienze@kylinos.cn> wrote:
> > >
> > > > On 2025/12/16 07:16, SeongJae Park wrote:
> > > > > Hello Enze,
> > > > >
> > > > > On Mon, 15 Dec 2025 22:20:55 +0800 Enze Li <lienze@kylinos.cn> wrote:
> [...]
> > > If runtime controls are essential, I think using DAMON sysfs
> > > interface or DAMON user-space tool is a better choice.
> >
> > I also think the current DAMON design structure is suitable for DAMON sysfs
> > and user-space tools.  DAMON sysfs can run multiple nr_ctxs, so I think it
> > would be a good idea to consolidate it into this.  As Enze mentioned, DAMON
> > was originally designed as a kernel loadable module,
>
> I don't recall where Enze mentioned so.  Could you please give me a pointer?

Although Enze did not directly state this, His patch is a loadable module,
which implies that it was "designed as a kernel loadable module."

>
> And I'm not sure based on what you are saying it was originally designed as a
> loadable module.  Maybe you are saying something before DAMON's mainline
> landing, but that's quite long ago and my memory management is not good.  Could
> you please add more contexts?
>
> > but I was curious as to
> > why it wasn't run that way.
>
> Maybe I could give you an answer if you could give me the context that I asked
> above.
>
> > When executing the damon_start(**ctxs,
> > nr_ctxs, exclusive)
> > function, nr_ctxs=1, exclusive=true is passed so that modules are currently
> > executed only one at a time.  Therefore, there is no point in running
> > DAMON
> > as a kernel module, since you are not running multiple modules simultaneously.
>
> I'm not following your point well.  Could you please elaborate your point?

So far in my view, I have analyzed DAMON as follows:

DAMON core  <---------> kernel module   <------> damo(user-space)
mm/damon/core.c         mm/damon/lru_sort.c
mm/damon/vaddr.c        mm/damon/reclaim.c
mm/damon/paddr.c        samples/damon/*.c
mm/damon/sysfs.c

Above, lru_sort and reclaim are DAMON core characteristics, but they have
a kernel module structure because they are executed with module_init().
I personally think this is inappropriate.  Additionally, currently, DAMON is
executed only once at a time according to the exclusive=true condition
when damon_start() is called.  In this structure, I believe that the meaning
of "kernel loadable module"  is non-existent.

>
> > I'm doing some more research into why we run modules with exclusive=true.
>
> Hoplefully commit 8b9b0d335a34 ("mm/damon/core: allow non-exclusive DAMON
> start/stop") will give you more contexts.
>
> To summarize again, the intention is to avoid kdamonds interrupting each
> other's access checks.  For example, suppose the DAMON context for
> DAMON_RECLAIM and another one (could be created by DAMON sysfs interface users
> or other DAMON modules, say, DAMON_STAT) are running concurrently.  And if
> those pick a same page as access check sampling target, their finding of the
> access on the page depend on a race condition.  To avoid such a case, DAMON
> modules call damon_start() with exclusive argument set.
>
> Maybe this is unclearly documented.  I will recheck the documentation and
> improve it to make this more clear.  If you find the rooms to improve and have
> ideas for the improvements, please feel free to send patches.
>
> > One more thing I would like to add is that I think it would be less
> > confusing
> > to move lru_sort and reclaim to the samples/damon/ path.
>
> No, I don't think so.  Those are for real world products, not for samples.
>
> > And it would
> > be
> > a good idea to organize the core sources toward
> > mm/damon/modules-common.c source.
>
> I don't find exactly what kind of reorganization you mean.  But I agree there
> could be rooms to improve in terms of the files and code organization.  Any
> suggestion is welcome.
>
> [...]
> > > > Finally, I would like to add that designing prdm with an extremely
> > > > simple workflow -- load the module, set the target PIDs, and enable the
> > > > switch -- will contribute to the promotion of DAMON, allowing a broader
> > > > user base to benefit from the DAMON system.
> > >
> > > That workflow is definitely much easier than directly using DAMON sysfs
> > > interface.  But, for the reason we have DAMON user-space tool.  Using it, the
> > > workflow can also be as simple as prdm, like below.
> > >
> > >    # damo start $TARGET_PID --damos_action pageout --damos_access_rate 0% 0% --damos_age 2m max
> >
> > Where can I find the damo source or documentation?
>
> You could use https://github.com/damonitor/damo and its README.md file.

Thank you so much for sharing.  I am trying to analyze the related contents
in more detail to improve your DAMON.  I'll try to organize it a bit better
and send you a patch.

Thanks,
JaeJoon

>
>
> Thanks,
> SJ
>
> [...]
