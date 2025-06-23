Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077C227EB9
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720895; cv=none; b=euIAFkO2LIc3fL4ljWYdwL++pwW5BhJqbvuNbI2dF5qpkj0VnQCokbDWcWQX8OZ0+BInbn52uzT7QmpP43QRt8JEVDQRxLWASidCLVVa72ycuFUIms3Gq8LCXiY6uzV8bR5oGHSMwQxu5N8khDK3Wkfa4uF8gSwEyW/XBMPVEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720895; c=relaxed/simple;
	bh=WH4MWsMMlzGlz4gM9gjAzqFE+1ORw8N7aa2D7XBLdRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/uYxGsXuTXUXA2t0j9f41tM6bLEUbKZzJHCSFxc6KE1jme3mkd7Dvkc/fJEOvcxFxeivMJfhQsVQk4wWcx0M8hOnW/limA99PTNW0W6jzQXDz2KM2XRylihK36nW6xWF0NjUIaBUb02nfuFczqAcWJGnbViAMCRAR5PVo4i8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWS7eOGR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWS7eOGR"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acbb85ce788so910057266b.3
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750720892; x=1751325692; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZVkY48T502JcAD7NzXzzdEZjZODovk6qGSGgvVTsNo=;
        b=YWS7eOGR2PcjAlBpWIZpWFIE1c5EpLy+LRU82EnvyR0/YPSU0e6A87lSLcc8j+YkMo
         0WvQrTyFOX0sQz8Ab/ws96TfP0BMSNs2z/41zY39qvuYKE1iph05nwh+Mhb5oJjw5lO2
         /NZoqc6S/deIFY5tiF+9dvhKDnrcZUz/zD2XDi0JyB3MD6U3AWTQO3qvw6tWIRTgvwx+
         lXg16oAOqacLixzT51JkWWgCYgG8ALgZsKVqhm+E5/Qi22Z3TGIWEs7kWbv+JJi4EPG6
         Oso9DM5nOZCts7+Xwvxc71adH+rrwD7j2cmJ/0lhIzwoUbWhiHlaqP0Kd1V7QE4aSkyA
         9bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720892; x=1751325692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZVkY48T502JcAD7NzXzzdEZjZODovk6qGSGgvVTsNo=;
        b=Q3kqlqd4L7gOXVRavAZpGKKnsInnYFXvxzH++/PUvBmLWgR6rjS+aM79HNC5GTfizk
         f84Pftal022qCEma5aoFcUUGjtwd9Uh3Em0nXLUfj+H0bdzsm3TAAuRG4LpZZoAh+kGa
         Snz2qyfABSkQ1seaQpR1n1Tp3vEqwy4j6XZnwffL6H+h6LceCCqbhzHYaTtpbNpxoHjC
         PtNjxtoK63s4mOiG4gqxKEZCVTrHJFwNHndEQJM3TrkeFICk2OhYDRWQv57svhMG264y
         09DPG6mhvVo/74VAQwRGf/eYL2kg2oXchhNTU2Bi3kzA3Du+i6GsmkBOGvhIU8y7rkEw
         NjJA==
X-Forwarded-Encrypted: i=1; AJvYcCW8N5FNY5GxpaQnA0L6EBgj/1tlivwqoEML1ppS00aZUm6Oa/ZZy3q+njmerMF4g+9pUMjVRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHfnn+xMW657Z6k0+TDrCjZ5hZwE6W2h8vJEDUBoGr0b5oe/ix
	o06USjO9o5yytP0Knxr3Q+8T4FyGfTgnOM0aN79RbT0X2Qz9IwdsbH8TAcQPNk4XfpbJWmMU9GC
	ebNwJpGp4YDJ4LODFDB0XXkiAoklfIv4=
X-Gm-Gg: ASbGncs14x423uOrVrm0OFnNYelnJRXlwNvRZLmq8uDu07LYxvmZccsZqQFRM0TJDD2
	5UTEii+ookIB61T0w/H02HWILdXEBke8G9UEG7MvE1JO2Xg1NFo74QIqYl1AYU4O7VjHq+6hHvP
	Ci/SdM4W3p7hl+mf9uKRgxm3GFnh4qRrmGkXzdKFg+yJ64mpqmj7ahdwWpxnS96/Lf0MF25Xf0X
	k042A==
X-Google-Smtp-Source: AGHT+IF53yd5TzJjggB8GCsgXjHW3XfBe88y6aXb2DUIoaNxkcU59GbTifghsdJkMCaNQP84ylFD8Fm+lkPnJG8ON1s=
X-Received: by 2002:a17:907:1ca6:b0:ae0:9fce:c578 with SMTP id
 a640c23a62f3a-ae09fcedefcmr284922166b.18.1750720891641; Mon, 23 Jun 2025
 16:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250620180458.5041-1-bijan311@gmail.com> <20250620202155.98021-1-sj@kernel.org>
 <aFmq5Y1zKov9__zh@gourry-fedora-PF4VCD3F>
In-Reply-To: <aFmq5Y1zKov9__zh@gourry-fedora-PF4VCD3F>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 23 Jun 2025 18:21:20 -0500
X-Gm-Features: AX0GCFvhM9bDmIKNz3hzb_T7Ftkp2AGOE2ZRMfDXHquDjGFrrsP8UEg9t-r2yYQ
Message-ID: <CAMvvPS5ievG9Q2w1GEA5BH2mAX-XUR_=oo3AWMnDeUvyRF8jyg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in
 migrate_{hot,cold} actions
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gregory,

On Mon, Jun 23, 2025 at 2:28=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Fri, Jun 20, 2025 at 01:21:55PM -0700, SeongJae Park wrote:
> > Hi Bijan,
> >
> > On Fri, 20 Jun 2025 13:04:56 -0500 Bijan Tabatabai <bijan311@gmail.com>=
 wrote:
> >
> > [...]
> > > This patch set adds the mechanism for dynamically changing how applic=
ation
> > > data is interleaved across nodes while leaving the policy of what the
> > > interleave weights should be to userspace. It does this by modifying =
the
> > > migrate_{hot,cold} DAMOS actions to allow passing in a list of migrat=
ion
> > > targets to their target_nid parameter. When this is done, the
> > > migrate_{hot,cold} actions will migrate pages between the specified n=
odes
> > > using the global interleave weights found at
> > > /sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functional=
ity
> > > can be used to dynamically adjust how pages are interleaved by changi=
ng the
> > > global weights. When only a single migration target is passed to
> > > target_nid, the migrate_{hot,cold} actions will act the same as befor=
e.
> >
> > This means users are required to manipulate two interfaces.  DAMON sysf=
s for
> > target nodes, and weighted_interleave sysfs for weights.  I don't think=
 this
> > coupling is very ideal.
> >
>
> Just tossing this out there - weighted interleave sysfs entries *should*
> be automatic, and the preferred weights shouldn't really ever change
> over time.  Even if they did, if it's the result of devices coming and
> going - the updates should also be automatic.

I'm not convinced this is true. If you have a workload that can
saturate the local bandwidth but not the remote bandwidth, wouldn't
you want the interleave weights to be more biased towards local memory
than you would for a workload that can saturate both the local and
remote bandwidth?

> So, in practice, a usually probably only has to twiddle DAMON.

That being said, I don't mind the idea of the mempolicy weights being
left untouched as a reasonable starting point for bandwidth intensive
applications and leaving the fine tuning to DAMON.

Thanks,
Bijan
