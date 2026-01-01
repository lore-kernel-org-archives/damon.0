Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F866199FBA
	for <damon@lists.linux.dev>; Thu,  1 Jan 2026 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767234867; cv=none; b=ibh5JGOgdRPTAbYV1CWR7GddG2YKlW8RzmLCVTC+WTUsYCV3blsg7xBoDidfbWhYk88c+6ait2y+SiEcBmqBhZs4PnCEp56RYzLzu8P/OhXDllSYHysuFweEobjXyvbKu32dJlchjDdsAa5RXHKUcoD9Cud95khpkygJVU2WHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767234867; c=relaxed/simple;
	bh=1KxV9SLszBeL1ubqzeORBSztQxZvyM+oSu3qoCpd0Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoMxK8LWc6NjV6bwOKRoY0HVT9bdJYXJQD8Q2IK6jRescqqiOZyHmzk0/MKLChQwkfIhlKE4GI0ALJ9t+57yVck4npUb1HI47JDBao6VkR1v2a0uGjmuKu4DV48+tICcaUZRPv568e3TCI6nT9/ydi8Pr310yHTvyiaHEytGDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3iKPdgQ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3iKPdgQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fc7893c93so78386087b3.2
        for <damon@lists.linux.dev>; Wed, 31 Dec 2025 18:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767234865; x=1767839665; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X6sWZLRmGf8XzUeHmImAxpT7l30oyOZDx/Iyh5mXQB4=;
        b=R3iKPdgQ0sAiuulQSBvT7ESeqttYGmHGGcZ0vSuKK/cCkNKJFJOTBPMtrVxEX+Cu62
         qZA1ZieUhe5TloUGg1vblkhAmlaoWVLEflKM4Q+kor0QhIN2dv/bW38pnEs16BAnyK1+
         k/0Cy43l0mWqqxik7rvsH4jkO3KtXdxBrHnsHfplKOtb8b/ePVqi7/gy3REQ6AXjio2I
         yF6SP1r5sSW70zB/wbVm7wcCractW/QEbEHoFgdweNXPXI1ENJ+P96kFBwXt/Nt0bAGr
         076sESOJ37ZlSIHmVEZ9nE8WUNHfb6kG9eK4GPqoLAc2y4bCPCMJcGtHsnN2v794TRsE
         B1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767234865; x=1767839665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6sWZLRmGf8XzUeHmImAxpT7l30oyOZDx/Iyh5mXQB4=;
        b=Nm8scIHIFShq9fM7/oojeBgZ9N+a7dQfeGSbDjBbk0jHNDnxMDjjatZwe0AdTkdxMk
         WwdZatVo1ZVGgvxQaSzVT575jhbfSAWSXnqAttjCq5rDu5fF3lf44oeTQFJb7hCYZgts
         k/4Kfo6cPrA41U34Ii6AT8QajacigssiQv6sEivRxUTv3peb2gL8s76+iKOtrmoFkfUN
         OHnZeM5iRkEqV5DMCqbD8ujXCzeu4jauWOk6e3rZCvHoJ5Hm/eQzDOoGiIC+SayXc/82
         j8EQnAW2SKXFlNMyu1QBbUoVFfomgi9C07CfiV3Yn782g+swQ5znWqaAo8KzdPpPjNYb
         CXcg==
X-Forwarded-Encrypted: i=1; AJvYcCX0VpsF7Gpd9v1n5pBIdi2lbwKLP924z2wdeAS0Flephrp/+TM4wqlo1TpHDA0SKcpmu8GpWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVySPR2L6RPI8HLqghJDhyumJJmFiJ+M5+NjtLFnt8OkJjfdi1
	7xyRrjU2CbFPx/yp9khIgNaWPevlTfdHDbqtP2g6DxydHYPTsTxCEX5CuKzxGcKXYcLU1W/SxCH
	jVj6XndqOagH4z5r6GvSo4/N7hefL8OM=
X-Gm-Gg: AY/fxX6gaeG8cNLW3VejTYExdQuuRo1R8TajCZOeqYNsnT34tTkxx2vuE0ng//5BQ5z
	yhonhRp9kn1ECjfQnqYLWG57lOSEvrFgFzqOPHRVg6qMlUsaVM4sNxV9sO5ednh/jJqzXxlrd8a
	nwVM2SunWrqxVukm6adZkH9fPB74ll93eDyyte+5kZJryH1p8pWdEjazLyu1xM53zk+Enr79Jlx
	3iDl0hEh2vUrU/0ty6KDB4mi3475sCElThCFZHfzEJT8AqcihqKTkrSaVMKkVWMw/jnf78N
X-Google-Smtp-Source: AGHT+IGwbxQUmQAg+3ZYoLCwo/zfbvy0ci3uD0B/Y+5bdBsXdTN4KG769swe5D0Y5FcE+w9kIzARSt/4JaOMiHYMjZ0=
X-Received: by 2002:a05:690e:1586:20b0:641:f5bc:6972 with SMTP id
 956f58d0204a3-6466a912ce3mr26239292d50.78.1767234865232; Wed, 31 Dec 2025
 18:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHOvCC6or4a5YM-byNFkB4q8v8YO=ZrT0VymYQfSXEx84wgeZw@mail.gmail.com>
 <20260101020028.88096-1-sj@kernel.org>
In-Reply-To: <20260101020028.88096-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Thu, 1 Jan 2026 11:34:13 +0900
X-Gm-Features: AQt7F2rRhYsi4UukPhK-fCydGkFg7mvJP2beIaLDNsKcp4I3Wqayojuht6he99M
Message-ID: <CAHOvCC5Frn16MiaP7AjzvJNPfnGXyjcWmhtwNnKQzXwz3VUL9w@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
To: SeongJae Park <sj@kernel.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>, akpm@linux-foundation.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangkefeng.wang@huawei.com, artem.kuzin@huawei.com, 
	stepanov.anatoly@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Jan 2026 at 11:00, SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 1 Jan 2026 10:11:58 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>
> > On Thu, 1 Jan 2026 at 00:32, SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Wed, 31 Dec 2025 15:10:12 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > >
> > > > On Wed, 31 Dec 2025 at 13:59, SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > On Wed, 31 Dec 2025 11:15:00 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
> > > > >
> > > > > > On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
> > > > > > >
> > > > > > > Hello Asier,
> > > > > > >
> > > > > > >
> > > > > > > Thank you for sending this patch!
> > > > > > >
> > > > > > > On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
> > > > > > >
> > > > > > > > This is a minor patch set for a call_controls_lock synchronization improvement.
> > > > > > >
> > > > > > > Please break description lines to not exceed 75 characters per line.
> > > > > > >
> > > > > > > >
> > > > > > > > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > > > > > > > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
> > > > > > >
> > > > > > > But call_controls_lock is not being used on performance critical part.
> > > > > > > Actually, most of DAMON code is not performance critical.  I really appreciate
> > > > > > > your patch, but I have to say I don't think this change is really needed now.
> > > > > > > Please let me know if I'm missing something.
> > > > > >
> > > > > > Paradoxically, when it comes to locking, spin_lock is better than
> > > > > > mutex_lock
> > > > > > because "most of DAMON code is not performance critical."
> > > > > >
> > > > > > DAMON code only accesses the ctx belonging to kdamond itself. For
> > > > > > example:
> > > > > > kdamond.0 --> ctx.0
> > > > > > kdamond.1 --> ctx.1
> > > > > > kdamond.2 --> ctx.2
> > > > > > kdamond.# --> ctx.#
> > > > > >
> > > > > > There is no cross-approach as shown below:
> > > > > > kdamond.0 --> ctx.1
> > > > > > kdamond.1 --> ctx.2
> > > > > > kdamond.2 --> ctx.0
> > > > > >
> > > > > > Only the data belonging to kdamond needs to be resolved for concurrent access.
> > > > > > most DAMON code needs to lock/unlock briefly when add/del linked
> > > > > > lists,
> > > > > > so spin_lock is effective.
> > > > >
> > > > > I don't disagree this.  Both spinlock and mutex effectively work for DAMON's
> > > > > locking usages.
> > > > >
> > > > > > If you handle it with a mutex, it becomes
> > > > > > more
> > > > > > complicated because the rescheduling occurs as a context switch occurs
> > > > > > inside the kernel.
> > > > >
> > > > > Can you please elaborate what kind of complexities you are saying about?
> > > > > Adding some examples would be nice.
> > > > >
> > > > > > Moreover, since the call_controls_lock that is
> > > > > > currently
> > > > > > being raised as a problem only occurs in two places, the kdamon_call()
> > > > > > loop
> > > > > > and the damon_call() function, it is effective to handle it with a
> > > > > > spin_lock
> > > > > > as shown below.
> > > > > >
> > > > > > @@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
> > > > > > damon_call_control *control)
> > > > > >         control->canceled = false;
> > > > > >         INIT_LIST_HEAD(&control->list);
> > > > > >
> > > > > > -       mutex_lock(&ctx->call_controls_lock);
> > > > > > +       spin_lock(&ctx->call_controls_lock);
> > > > > > +       /* damon_is_running */
> > > > > >         if (ctx->kdamond) {
> > > > > >                 list_add_tail(&control->list, &ctx->call_controls);
> > > > > >         } else {
> > > > > > -               mutex_unlock(&ctx->call_controls_lock);
> > > > > > +               spin_unlock(&ctx->call_controls_lock);
> > > > > >                 return -EINVAL;
> > > > > >         }
> > > > > > -       mutex_unlock(&ctx->call_controls_lock);
> > > > > > +       spin_unlock(&ctx->call_controls_lock);
> > > > > >
> > > > > >         if (control->repeat)
> > > > > >                 return 0;
> > > > >
> > > > > Are you saying the above diff can fix the damon_call() use-after-free bug [1]?
> > > > > Can you please elaborate why you think so?
> > > > >
> > > > > [1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org
> > > > >
> > > >
> > > > The above code works fine with spin_lock.  However, when booting the kernel,
> > > > the spin_lock call trace from damon_call() is output as follows:
> > > > If you have any experience with the following, please share it.
> > >
> > > Can you please reply to my questions above, first?
> >
> > I have answered your above question.
>
> Are you saying your reply [1] that posted today?  Unfortunately I was unable to
> get all answers to my questions from it, so I asked your more explanation as a
> reply to that.

I'm sorry, but this conversation has gotten so long that I'm getting lost.
I've given my opinion, so I hope you understand.

>
> > And, since call_controls_lock has a
> > short waiting time, I think it would be a good idea to consider spin_lock.
>
> This sounds like you are only repeating what you told so far, without
> additional explanation.  Hopefully the additional explanation can be made on
> the thread [1].  Please keep replying there.
>
> [1] https://lore.kernel.org/CAHOvCC65azs4BU2fyP-kxvFWB3ZPCfyZ7KCO8N1sc0jtTENmNw@mail.gmail.com
>
>
> Thanks,
> SJ
>
> [...]
