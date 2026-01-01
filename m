Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3B17A300
	for <damon@lists.linux.dev>; Thu,  1 Jan 2026 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767234590; cv=none; b=k+NwVbAhLqKFwkN14Mda1St7tvHvlDYqq5azJ2CLF2wneuDb+6ueWHwl60O/up0QlXeV3eER+z2fMAjRTt/5md5VW80ed2eMsiGSA9mWto20BhB1Je0WT2Q1UVNhAG+f98U8Xat9KdjKOtCVi23z6mqbyr0/rIyRNBcZVqvFqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767234590; c=relaxed/simple;
	bh=q7zqsCyJspTu7YYp4uuoXVKL0svxM3Dt25eAAZWEWFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srDuQnUVV9xd50Uw2JUbxF4zUrg6H6ro01Ari5n+pUvDjH1wlG0G28XG8KJPDa2ujJOrRpdFJ9DuW8zhCAicn23q9f9/4YwR8PCtuAjdb9r9nq6vBYdSjhFItMitrYkJ3DCBunx+zzZYcutxHqoLMX7IpWMLCzPSF/8s/3vqcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHHVlZ9p; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHHVlZ9p"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-644795bf5feso9757926d50.2
        for <damon@lists.linux.dev>; Wed, 31 Dec 2025 18:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767234587; x=1767839387; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQu1f9JiOtEXcxDEjSyvzzCwSzsVZVs8NmEMoX3qCAc=;
        b=gHHVlZ9pXUhwoXuB9TUHBb69scg1BmUue/sXE9lnUTFH51dSnLyRjYh786nL+13GEh
         S4SMCoSurLp/E7gLBsqANwmVmwJqGS9KCEOJpdm9DZejM2tit/QMWqd0Wg3mqfDbQWSg
         wKtUZPN/vosG0a8v9hURn83iraY5u7wdP88jdEL4sA2kYBMVhbnulnXZNHenZUAohwoa
         WvKbI6qiJQiSD2CZhHLXuukapJidJWe5oj/7+VFo5kxEKWJyeDck7aTXCG9H6HRkS613
         +lUMPcNmKzot0Mh4qzrWFAznr6kLWEShUy/LDH2CE/SjiYcreXqiWIb1qNXlk6PyKAKI
         RZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767234587; x=1767839387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQu1f9JiOtEXcxDEjSyvzzCwSzsVZVs8NmEMoX3qCAc=;
        b=ePIj5yKmLwaik01z0WYKnz+7FKaMnT8wWxNzorEN2AX2WqCDSyhnsm/jbTM2SSIJZX
         hxAIfMK7cGgCIqgPUxQg57qb/7s60ErWnJcKEup0MTlmYH+8uuQTgPPVK8OAHcGflNyI
         YXvBSmXbg44YcMJVNykxDtYTqi2oH4QoOLhqyvAZXB1HBu8prYFf8aigUEwDREbpwiyT
         /7Lwh5HKR0D0LlJfD6iSSi1EBh5vWlD6p+AZiYfYwM+bGc2mT15GujLEVbfUdutx8YHb
         ScQKgxtPqgAUh2Lrf2xSn6EXfrbbpYXrHVEj7nMRnKPpx/dJ74d+P9S9QkgkH3WMNOv+
         4pbg==
X-Forwarded-Encrypted: i=1; AJvYcCVdmVYHxaf9QZhy5pHSE7ydfIHGNAQlV48L/S/kPKTe73jsErXQG6LK9K6l/yJ3c5bzNdbhXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOLfUuBmNuBHf63j0s7dy/wcAdQk17NS9cyZLzxldoBOIlRMXm
	1FYklseWjrlh11NepQAaasXkaZ0INn6cgsWp2kVQY8xND2/TX96NrM1y8iPSeChcT4NNm4W9W72
	Qvb5qmsAD+pqmvNzz4DGkqSaSzDGmxyE=
X-Gm-Gg: AY/fxX7gov3PGHI0Y7ZrUrIkVCF9FQx9P9PluUbLoiVcLsU1sQl8n9Nk9V3YJZ9ogT0
	jLVZShQ4FswKbTgGP9/GPfPU/Pu+JfNt6UB/JxHoiums+abSRJ+InL+7ihHQQa2c4LnNF53wJV3
	Nvrb8I+Zs23qEP0L+nqyaCwxKtuhpDHUzGQsul45u8B4c/o3JhSVgQKEcsXQSpwFlkG2FKLs+16
	tsXgYloPBQOQgZRQg6tKPhkxXuHWiyUDTjvlMSeTcR74BnkAKDEv8ti1EimQkUbQ1lUD8yzq5a/
	KSyINNc=
X-Google-Smtp-Source: AGHT+IG0j61eLfMBZtjBCRAtt6gD4cfUMx56tKt992tAV7oQ7u6A5BMnxDsu2RoR9WRSplTvopodGefdnhtnzMeu1cU=
X-Received: by 2002:a53:acda:0:10b0:63f:ba88:e931 with SMTP id
 956f58d0204a3-6466a8c28d8mr24774162d50.38.1767234587455; Wed, 31 Dec 2025
 18:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC65azs4BU2fyP-kxvFWB3ZPCfyZ7KCO8N1sc0jtTENmNw@mail.gmail.com>
 <20260101015123.87975-1-sj@kernel.org>
In-Reply-To: <20260101015123.87975-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 1 Jan 2026 11:29:36 +0900
X-Gm-Features: AQt7F2rhNPQNC3SV0H9hrrUMFMj99IouwnqgjizjnbcHSdektK8WMCR8Js4GHWg
Message-ID: <CAHOvCC5GWg5XhB+OUZi6C373qYS08ot-1A9QM+24mhnuqdq3mg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
To: SeongJae Park <sj@kernel.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>, akpm@linux-foundation.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangkefeng.wang@huawei.com, artem.kuzin@huawei.com, 
	stepanov.anatoly@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Jan 2026 at 10:51, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 1 Jan 2026 10:07:13 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Wed, 31 Dec 2025 at 13:59, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > Hello Asier,
> > > > >
> > > > >
> > > > > Thank you for sending this patch!
> > > > >
> > > > > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> > > > >
> > > > > > This is a minor patch set for a call_controls_lock synchronization improvement.
> > > > >
> > > > > Please break description lines to not exceed 75 characters per line.
> > > > >
> > > > > >
> > > > > > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > > > > > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> > > > >
> > > > > But call_controls_lock is not being used on performance critical part.
> > > > > Actually, most of DAMON code is not performance critical.  I really appreciate
> > > > > your patch, but I have to say I don't think this change is really needed now.
> > > > > Please let me know if I'm missing something.
> > > >
> > > > Paradoxically, when it comes to locking, spin_lock is better than
> > > > mutex_lock
> > > > because "most of DAMON code is not performance critical."
> > > >
> > > > DAMON code only accesses the ctx belonging to kdamond itself. For
> > > > example:
> > > > kdamond.0 --> ctx.0
> > > > kdamond.1 --> ctx.1
> > > > kdamond.2 --> ctx.2
> > > > kdamond.# --> ctx.#
> > > >
> > > > There is no cross-approach as shown below:
> > > > kdamond.0 --> ctx.1
> > > > kdamond.1 --> ctx.2
> > > > kdamond.2 --> ctx.0
> > > >
> > > > Only the data belonging to kdamond needs to be resolved for concurrent access.
> > > > most DAMON code needs to lock/unlock briefly when add/del linked
> > > > lists,
> > > > so spin_lock is effective.
> > >
> > > I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
> > > locking usages.
> > >
> > > > If you handle it with a mutex, it becomes
> > > > more
> > > > complicated because the rescheduling occurs as a context switch occurs
> > > > inside the kernel.
> > >
> > > Can you please elaborate what kind of complexities you are saying about?
> > > Adding some examples would be nice.
> >
> > You probably know better than I do.  What I'm saying is too general.
> > spin_lock is good for short collision waits, while mutex is more efficient
> > for longer ones.  However, I'm saying that mutexes place a burden on the
> > kernel because they schedule internally.
>
> Thank you for added explanation.  But, in your previous reply, you mentioned
> "it becomes more complicated because the rescheduling occurs as a context
> switch occurs inside the kernel".  Your above explanation ("mutexex place a
> burden on the kernel because they schedule internally") is not adding more
> explanation but just a repeat, to my view.  I'm asking what complexity (or,
> burden) that you concern here, the internal scheduling is causing.
>
> So, may I ask your explanation again?

I'm still learning about locking. I hope I'll stop here for now.

>
> >
> > >
> > > > Moreover, since the call_controls_lock that is
> > > > currently
> > > > being raised as a problem only occurs in two places, the kdamon_call()
> > > > loop
> > > > and the damon_call() function, it is effective to handle it with a
> > > > spin_lock
> > > > as shown below.
> > > >
> > > > @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > damon_call_control *control)
> > > >         control->canceled = false;
> > > >         INIT_LIST_HEAD(&control->list);
> > > >
> > > > -       mutex_lock(&ctx->call_controls_lock);
> > > > +       spin_lock(&ctx->call_controls_lock);
> > > > +       /* damon_is_running */
> > > >         if (ctx->kdamond) {
> > > >                 list_add_tail(&control->list, &ctx->call_controls);
> > > >         } else {
> > > > -               mutex_unlock(&ctx->call_controls_lock);
> > > > +               spin_unlock(&ctx->call_controls_lock);
> > > >                 return -EINVAL;
> > > >         }
> > > > -       mutex_unlock(&ctx->call_controls_lock);
> > > > +       spin_unlock(&ctx->call_controls_lock);
> > > >
> > > >         if (control->repeat)
> > > >                 return 0;
> > >
> > > Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
> > > Can you please elaborate why you think so?
> > >
> > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
>
> You didn't answer the above question.

There is something I misjudged above.
It would be better to handle ctx->kdamond as a mutex using
damon_is_running() API,
and modify it to spin_lock only for call_controls_lock.

>
>
> Thanks,
> SJ
>
> [...]
