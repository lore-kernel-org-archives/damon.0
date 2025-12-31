Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350CA59
	for <damon@lists.linux.dev>; Wed, 31 Dec 2025 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147314; cv=none; b=bcmEpbV23gAs+ydpJ06fwcUY8HtIVP0MwD/ahGs03M0vmLJSJv9+iZ6xTpmZ9vU5kw0LNY2vWhrYhvFMZzKb4iidxzdOUcQ4KFrp7UWxnWBqAgYAJGr+TNyZSo+cTJzZZGyWnZDFvnLUgnaLpM9vMnfXCPDINK8gZRujmrgZ9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147314; c=relaxed/simple;
	bh=ulFx0u7rtsuJy4ZJMnCQKFLnYR3lyA8eDz62IjETsFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzHJ9hqc5I55b2A48FloAJpEiZ3mYjpQUq+UQ2J7alAEiZX3mnsJX4sROwu7LfsyFYPr7g4LlUGO/B0v6iBRzf+GmqK8b16ncKtJLnzwBc0toCF8Kyigs/zIhqfiVEy4zX3vHZ2ssSG80MaoUA3ZEb4dDHKIVJ30gzIQ5BcGPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKAPzftz; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKAPzftz"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-646b8d2431dso2024730d50.2
        for <damon@lists.linux.dev>; Tue, 30 Dec 2025 18:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147312; x=1767752112; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TjfTZhxsuFnytCHStJNb8M8EerX5fb1TydQlSsVH+Kc=;
        b=FKAPzftzuk8a1YckjFeuvD5f8YYc3kv8XS+kHY3WaIHSNmrUHdrthQfLWMqeKftelA
         SjG6C7WisWScGQZujQ2NJSEXjBoX2hDl1ZmvdDU6Cha83Tr4/xmQKbuZSAhX7iMdv2pD
         j7EU0l5gpM/OEqHsMfNxoCLDdTmuKEl5VvgThFvIQ7n3Q/I2dz09y+ONkzh/Rf8j41IZ
         gSn6v586866xozhRMKeE+WEM242i6DmyKvLVZH0RfL+sHEQeIJ2FGDVVTIgH5F34Ngd3
         RR38Oc4AZMablQsNrDxona/CVpYe4zllQeW3ckpfSmNqpON09QwWwIID/xMTEyCRGxi0
         SywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147312; x=1767752112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjfTZhxsuFnytCHStJNb8M8EerX5fb1TydQlSsVH+Kc=;
        b=te8cAIZKW/m5J2GsyjgPl06NlM3FdfEvtJ5TaaYLUsAufd0KbMurcds0QqUMkz0lo/
         kZoqCNMmxyBePktesLhOPNtu1He9GydBSGQo+WdJfPGUGwmFaJ1aI+Fxpsgz6Gn4HhOm
         PP6Q2hSVjsy2VLbaBTRyGdAglp4oYIgBrOcNqapVUvo5Yd32V4rZYwWYbbG2YchdNl2N
         8MniBVmUwp+oJ7zb0gakONaZ//PunFlTvXikb6ZW7VbrP2zqs4u8P80irx05Q6csw/WS
         U8kC/CloN9XQ3kJQ+Mj6/n64qscxDJmLlrc6693DVkWj4zPtW0XxCSv0c6JsbhLKzVl/
         GtFg==
X-Forwarded-Encrypted: i=1; AJvYcCV33ouSZ+cHlYz24GBw8NHWkDh1n/jdCt6Mr3r32BqZgg+BTjNMBvPAj4n10MRUtmPrsimABw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP/6TwbPSYRUsPoEqlXtkrslN4PtUcl2QudEtQ7eqG3G9LSem2
	NLn2SD0j0Ht+dmm1s0rdJ6k6imnq/BAWuZNj/lGJNtJ2mdqeHVdzxPoXy562qRcrjlwMEMVhqLE
	uCgFniyth3jQ49CE0jH3paLUKlQMdRt8=
X-Gm-Gg: AY/fxX79rc1o2kH1eJLrmo/EnmvxLmFpNy6BY6n0qO2ikvhKeV0KzXo5zAqzfciKkIt
	3nEptFkfXKZFFZDa3cKJ7tQZHe9NcjCj6P3xtZIWmZJbDFzAs+LXBVE0T1oTUPgKPokRHtQVJoW
	0UTq3gtRTLPbKKVNF0voN95ZfDLmkKyIZgP63BD3XbScXcUtS9CZOBrAUCHPPcCkqsaDU1+TB8K
	MqUUbtzalwop6ce79dv0AUlZWzpBEqtIhi6BtXtm1tlBKM9zi0P8jcqKnsLEwyzCK20RM1d
X-Google-Smtp-Source: AGHT+IGL4DyIhhfeKJjVZUle8A3hNbfdiDShjwM2p95/bqd+VS+m5HW78WKGClsmtpLuHw6mEKZ5Sa5sxwI4ASCK3b8=
X-Received: by 2002:a05:690e:1914:b0:645:5cf1:7685 with SMTP id
 956f58d0204a3-6466a8c9570mr26677749d50.77.1767147311921; Tue, 30 Dec 2025
 18:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251229145533.2437293-1-gutierrez.asier@huawei-partners.com> <20251229152250.78975-1-sj@kernel.org>
In-Reply-To: <20251229152250.78975-1-sj@kernel.org>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 31 Dec 2025 11:15:00 +0900
X-Gm-Features: AQt7F2p3gYsDqr85ZYvuCiGLXjJute9alqoQns-Mc9ZwsH3742lbbwiyDQb2AQ0
Message-ID: <CAHOvCC4FhpLrknhvWbDd=cxaLUyxHFkFxBDYSC3waeg4FC+TBg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm: improve call_controls_lock
To: SeongJae Park <sj@kernel.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>, akpm@linux-foundation.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangkefeng.wang@huawei.com, artem.kuzin@huawei.com, 
	stepanov.anatoly@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 at 00:23, SeongJae Park <sj@kernel.org> wrote:
>
> Hello Asier,
>
>
> Thank you for sending this patch!
>
> On Mon, 29 Dec 2025 14:55:32 +0000 Asier Gutierrez <gutierrez.asier@huawei-partners.com> wrote:
>
> > This is a minor patch set for a call_controls_lock synchronization improvement.
>
> Please break description lines to not exceed 75 characters per line.
>
> >
> > Spinlocks are faster than mutexes, even when the mutex takes the fast
> > path. Hence, this patch replaces the mutex call_controls_lock with a spinlock.
>
> But call_controls_lock is not being used on performance critical part.
> Actually, most of DAMON code is not performance critical.  I really appreciate
> your patch, but I have to say I don't think this change is really needed now.
> Please let me know if I'm missing something.

Paradoxically, when it comes to locking, spin_lock is better than
mutex_lock
because "most of DAMON code is not performance critical."

DAMON code only accesses the ctx belonging to kdamond itself. For
example:
kdamond.0 --> ctx.0
kdamond.1 --> ctx.1
kdamond.2 --> ctx.2
kdamond.# --> ctx.#

There is no cross-approach as shown below:
kdamond.0 --> ctx.1
kdamond.1 --> ctx.2
kdamond.2 --> ctx.0

Only the data belonging to kdamond needs to be resolved for concurrent access.
most DAMON code needs to lock/unlock briefly when add/del linked
lists,
so spin_lock is effective.  If you handle it with a mutex, it becomes
more
complicated because the rescheduling occurs as a context switch occurs
inside the kernel.  Moreover, since the call_controls_lock that is
currently
being raised as a problem only occurs in two places, the kdamon_call()
loop
and the damon_call() function, it is effective to handle it with a
spin_lock
as shown below.

@@ -1502,14 +1501,15 @@ int damon_call(struct damon_ctx *ctx, struct
damon_call_control *control)
        control->canceled = false;
        INIT_LIST_HEAD(&control->list);

-       mutex_lock(&ctx->call_controls_lock);
+       spin_lock(&ctx->call_controls_lock);
+       /* damon_is_running */
        if (ctx->kdamond) {
                list_add_tail(&control->list, &ctx->call_controls);
        } else {
-               mutex_unlock(&ctx->call_controls_lock);
+               spin_unlock(&ctx->call_controls_lock);
                return -EINVAL;
        }
-       mutex_unlock(&ctx->call_controls_lock);
+       spin_unlock(&ctx->call_controls_lock);

        if (control->repeat)
                return 0;

>
> >
> > Initial benchmarking shows the following results
> >
> >
> > # bpftrace -e 'kprobe:kdamond_call { @start[tid] = nsecs; }
>
> Commit log shouldn't start with '#'.  Please consider indenting the above
> command and below outputs of it.
>
>
> Thanks,
> SJ
>
> [...]
>
