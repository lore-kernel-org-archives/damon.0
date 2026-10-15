Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A023B7B70
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078628; cv=pass; b=Ar/mCB7O98VKn0K/qnxKjbMR7rGNTvWB5x6vtiM4fpr/jmBY/oq+5whlMbztc+j5H5P12iZT4+sqOeWpDMRuYfQKtqstvxf29kid7Sjq9yK4iwSV6Zpi17PVEb0Gbj0RrLdXvcktx+5+XfN02cQV9tkpX+vhiFyE5CESJz8Hohw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078628; c=relaxed/simple;
	bh=Mc8x6I4IlZLfP7Amk33bJSUN5CAY/VzVUFgnji/NKdU=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN0RCO1hzSoWOCRwyqfc/HM6gbCeUgTpHM35fQBVhz2ikAyR60ZTH83VSGaiP0sUBlkpzIuvsavRjABx4A30v37wWIs2WhWyaOxPfk8+JAW+u8vnaurwPh9seFHe9xhd1qWmGAgOw+pTh3M+2MZnazJK7ZJvRPb092OOvv7bkcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMPx1qxH; arc=pass smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMPx1qxH"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so6207175ad.0
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 08:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792078617; cv=none;
        d=google.com; s=arc-20260327;
        b=YAfrgfoKclN1n2JlAg/Fl7SK2oaCOKJRpmtvy+xarCNlBvZmVcesQ0F+lxZ8Lb0Xza
         mNr3NlTm70yDoicNafKgHcorfYdUapLNN6w8iDm4H84JK46dPZjKGNszSMsPcZl38NGp
         M5vUCUV/mGlpz0wsSZmeiTOkTuAXYsMNsVBub8LXAFYAKn6Jt1FD/13XBK3kNVoDMPc6
         XxbnwSScPXNDpvNLPR7++NT0knkniSFnyZhu3vj3+hAqPiew20pp1wzFNhWFu++lzMQ6
         OcCdBC4wennISnj/o+TMrI4OHE/c91bhwZS9EoY6AdapkQeNDitYXKBsk8O+f2CI/1w8
         v7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=eNC0Fd3BGqN5rK2299oerWY4FCk3NDBRR5bAXp6FoIg=;
        fh=MxAKK0w5m2h45oO//TdIs69z0aNKbiyCONfEK6VXxLg=;
        b=qXEmIeux3mhCuYNCpydowZpQGDtESWn4GaUMkyZy7+h1H6c7Fgs5BJoEFxrekk+sft
         QGnA8FwNvR6QWP4XWWgkMlXjquHVYvtLzZah3GnJ5y7zA0XIZqkSzxRKsGOrkNEnxeRB
         vAXAq83+BvPzZHLOz8EvumHL2diWTLbBtMbL5AaTYzPwon5aWhDE5SQC7ioiwkxkZt6d
         u/vtoQd6/EMaEm8MrZahkGbOdceVRm0p9aWBtRK5dPVsPJso84LYltTqBfw5r8TXJH9e
         SBuRsr6WcXfiqQ9d7TVGkwuxDETmI6IRdNV2aP8D0zHrivH8LhCiiLndfLWR2WM7gtoT
         J5xw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792078617; x=1792683417; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eNC0Fd3BGqN5rK2299oerWY4FCk3NDBRR5bAXp6FoIg=;
        b=tMPx1qxHS9Bw/DKeCFxKUttUGzXbmvG4LSUZqmdpNBTJEDPTK7U6vfL3owBlYCSvOc
         T6XDUmjr16ValJI0J+w5zOPoUsJA2dVG+8yd8Wrqbkl2K5Bnv2sh6SbwKPINEuDxjUUc
         rxYGPndXvnngbEc7Hx8VkUh2f47dkGrrc49D/zQMa3C8Z/jE8QULqS+FyFAKvPGWpQ3F
         9tNcDkV9RlJzOFAauEjZmUuMox4MI3ySrlYZMk1+MFJSyjoqkAO3ILsB3noSHy1qSMTA
         EuLgOVzMt3DZG05WiPL29uIfOdTX4eFKZobEeF7Szxsln/ZxHOlbvSyhjrbzuYb9t3sU
         qfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792078617; x=1792683417;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eNC0Fd3BGqN5rK2299oerWY4FCk3NDBRR5bAXp6FoIg=;
        b=jXAy9sN/v8pywsssFlG2v9GTsgPtdds35GhKxHF5qQIVVXCPofpU520VIbA41yBQ5H
         7Gs358iWYdye4rot0g3j5GZufb8qnWitGsw3HVLw+wXzIoqglb3Pp6eqmeVhUvMHijpn
         /bx3w/i7PWMChitop/fK8rx9NJoqoyFnStpAEshVDmjrdItFejjmJh46pKXnHHSeeGjN
         JNzHSRxQ1dbMb6MHxR/P2MIwFgQEncz+6fCRTzIWHe5RYzLz1AwN29rv0O3ghimbvQ+a
         3zSxi89zGNtTBp1/qvxlH1C6wcjPCEgbRRMAvVKH0ECnfeI9F68NDLrt/IDv6K486PE5
         JT5A==
X-Forwarded-Encrypted: i=1; AKwUvBxVL1YM8ZDEjiT3Xw1sGUt/6L3auZxFtodcoBXs2NDg6B3Hmqlnr5e418L5XEuG5NdEjToJ0g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIryMWulT2YGZ4YwcB6Vp4SPdCQx2TuFU2Zyv5tmbXbrn/cynqo
	90mdkyCq3wldsawsv3l2dxxZLzpXRjEyqR57cM+uXfG11d37mUIsSDC24J3s8lrJzKfxv4sfTiB
	0N+7xcQKs+n4vAbYn1bnqKsmoZ9mtcjQ=
X-Gm-Gg: AYBFou1XSzJzlIXQRCMzOB69YfGPGgI+tyfEaslnqXmCbt9NTxg7OvtX8o6wbVX3BLz
	hoen+AY6tjC36X/A3lBzwonWz08jKshB/Ja6PJWBg7NxDUHJBq9isCBBOwx86Zo1G2BRCTiZJbC
	h+rx6/Lc8uz1Rv1yunlw2dX+W98I7sb7txQ8c2lszFtWHLtUGr/8K29NsgqTMu4WZUvWNlmDBI9
	ER5nfp0JhDvwPrElvjqwkxMmczPjN0Ndse3gEJ76NAbhFPphGcJ01wH4jJiFnHMs9raitiZkzrT
	cySlsAk/MVNnRAADd/J6z9oR/H/AKHHP0TdvPM9pgVXfpnh8NV/7j8vjJP3QzI8xATP7VCkHf3f
	rght4Khc=
X-Received: by 2002:a05:6a20:244e:b0:3e1:549c:deac with SMTP id
 adf61e73a8af0-3e16b787a51mr17302180637.0.1792078617372; Thu, 15 Oct 2026
 08:36:57 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 08:36:56 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 08:36:56 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
In-Reply-To: <20261015141027.88149-1-sj@kernel.org>
References: <20261015141027.88149-1-sj@kernel.org>
Date: Thu, 15 Oct 2026 08:36:56 -0700
X-Gm-Features: AclHuK85ky1hJxxDTCm3lZUrv5F8rUf3dKyeQBVHR1L5-9dl9c9590Lj6JmwJJI
Message-ID: <CANOyQmF+nwNyGHptBJhT2iVDV6cmBMYY8rqgXnqg7GCDfFy_ow@mail.gmail.com>
Subject: Re: [BUG] DAMON: 32-bit overflow selects wrong sampling interval
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

I haven't seen this affect a real workload. I found it while testing
interval tuning on 32-bit.

I set min_sample_us=2500 to make the difference visible. The default
5000 us minimum hides it in this case. With the captured inputs, the
kernel picks 2500 us, while full-width arithmetic gives 2812 us.

The shorter interval could increase sampling overhead. I haven't
measured that overhead; the observed issue is the wrong tuning result.

Thanks,
Aveline Noir


On Thu, 15 Oct 2026 07:10:26 -0700, SJ Park <sj@kernel.org> wrote:
> Hi Avelin,
>
> On Thu, 15 Oct 2026 07:24:08 -0400 Aveline Noir <jm5905938@gmail.com> wrote:
>
> > Hi,
> >
> > In an unmodified i386 QEMU kernel built from mm-new commit
> > ad9f2d463666, an intervals goal selected a 2500 us sampling interval
> > after the first aggregation.  The same trace inputs give 2812 us with
> > full-width arithmetic.
> >
> > The kernel has CONFIG_DAMON_VADDR, CONFIG_DAMON_SYSFS, and tracing
> > enabled.  The guest monitored a 1 MiB VADDR range as four contiguous
> > 256 KiB regions, with sample_us=5000, aggr_us=100000, access_bp=400,
> > aggrs=1, and min_sample_us=2500.  The default minimum of 5000 us would
> > hide the difference.
> >
> > At the first aggregation boundary, the four damos_before_apply records
> > for kdamond.0 showed nr_accesses=1,1,1,3.  The next
> > damon_monitor_intervals_tune record showed sample_us=2500; sysfs then
> > reported sample_us=2500 and aggr_us=50000.  The records cover the same
> > four 262144-byte regions before the first tune.
> >
> > For that aggregation, the inputs to damon_get_intervals_score() are:
> >
> >   max_access_events = 4 * 262144 * 20 = 20971520
> >   access_events     = (1 + 1 + 1 + 3) * 262144 = 1572864
> >
> > On 32-bit unsigned long, max_access_events * access_bp wraps before
> > division by 10000.  This gives a target of 409364, a score of 38422 bp,
> > and the observed interval of 2500 us.  With full-width arithmetic, the
> > target is 838860, the score is 18750 bp, and the interval is 2812 us.
> > The later mult_frac() remainder multiplication does not overflow in the
> > observed 32-bit path, so the difference here comes from the target
> > multiplication.
> >
> > The affected expression is in mm/damon/core.c.  Widening only the
> > target product would make the later 32-bit mult_frac() remainder
> > multiplication overflow for these same inputs.  The 2812 us result
> > requires sufficient width throughout the score calculation.
> >
> > The 2500 us interval was measured on the unmodified kernel.  I
> > calculated 2812 us from the trace; I have not tested a patched kernel.
> > The i386 config, guest init, serial/trace log, and build/run steps:
>
> Could you share more details of your use case that this setup is needed and the
> overflow becomes a problem?
>
>
> Thanks,
> SJ
>
> [...]
