Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230565427F8
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077879; cv=pass; b=r6yZru/cuhAtHZVftUcaCaSopPTWH+7tf2fb1lKZrp2q5wSLzJ8qylqYIBXpzaR10cFmFexNjGuBsB8fRmYIItLa/BLah9Y+9+bH48nqz1DO55mLVxOGt0PCmADJXT6yGoeRNLIUTpFyBuT32GofEbeBiPQMUlGCluhwMUsVIz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077879; c=relaxed/simple;
	bh=kxnCtFMlKaIT7SBEfLNeNNflUjSOXev1aVTpw3wxrSk=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy7kgVliLMG47kC+CTBYyAEBrrP51GOWFnQ4f/PuUuuoeaq3h5FoUhGzUNmUdCUdbkcBJ0/nhXffH5wIryRqvESlJ1c9bwULBBGvPIw/fa6a72g2gnwvIFA62ZdXx4DKoZ6W5Kq353rC8nxI1a89g/6bRYIpqpN8irLMb+i/alI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgTtlF8O; arc=pass smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgTtlF8O"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ac749e0719so454800a91.0
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 08:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077872; cv=none;
        d=google.com; s=arc-20260327;
        b=rw7RbdsvtdIgZo4QwKP12yznp61g8JG2RVqg6kPIfS3Rf4Lu91XY1158Vyiqg/JEUN
         WcbRFMk8Ra+NTvBZF/o04bgekq85VxrSb0Sq8BTAyccREQxEfmpMf7fraDDY/hrOlTNK
         kl5k8Tt0u03yChI/A7Kh4st8gfkTNcuUcXNIgxaaVArpxzhu6KsvQc+1e3P8a028Yru7
         m2dNVDqtcM1V9saqlJHO/ZCD8AentYdFksZltCw/Sd/FdM5lhnMNwxBef1JX+pgdsrly
         Nfwbg0L1INQCaI84O2ocT5T/2gzwiHNQrSgqFHdlqBFCtaOUJesOSjvkKoR/kL2VFaDI
         tsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=YD6S+6u+gzgwuU4ceon9d+8HFftoXU9zg34ox/v9I5o=;
        fh=D+stXT4eD7OOdb3JUV1tzHkRBHj75spXJKf/uRtaIsU=;
        b=GCxrFNdkoLSuf485hzTNRA4LBKo7AD1zkJUjE5Qeo0d3ba5xQHF3hU5PDuPkGdafni
         e8ePyOxMx9MoVqPpDfVx/DW0VXOdCXc1lDTZVvLqEvPwdL8dMM1ZkXHDC0x4uZSafTYG
         6/H8MbCzolqX1zhuZknJ7T68rscdpTAkKyj2N5sElR05fKru8+wBeJxVcqFpas+UMmFE
         +ZjLlMI5V6PSK8gV3gmtO/eUOl46ECmljNgFsCxLfAf+LXhJXMbMKtOhUyEIpqDGn1ku
         VY+qFoNSJV/U8s5lFFHkNNGndvRH4hZQ9y37xxs07cllbjCFNBA6SA81UZBzPHjs43UX
         Xd4w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077872; x=1792682672; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YD6S+6u+gzgwuU4ceon9d+8HFftoXU9zg34ox/v9I5o=;
        b=FgTtlF8O56lx2FlSrhYlAuMgo7MpHdboCGqrGV/2WiFQe6LlHsNLVnv33QJEQPxeEH
         f14dGmAHuwIljs7cqo7uUQs6qyjPHio/Pz8Rwv85DCNIA6EhMzp9vXrtfLAQ/tU4JW8m
         7D+a/BuMVFEEVUUIuS6IK4foc7ImFaS7MktXX/okQeEwg/UlRyOZdAYu8QLD/MkOoghZ
         WsIIsTSEbNDc8lIL7U0pXJ/s9ozJlPOldh6Gu4GBAvLJkNe64Y5ImGnLbSXEnuW//Oku
         TFZLzkjXkGbK0FZzVOCUWbYaLRny03sKWsWtOnR8uurh7kJYM86jCk09bF1n4JELfUA1
         3ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077872; x=1792682672;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YD6S+6u+gzgwuU4ceon9d+8HFftoXU9zg34ox/v9I5o=;
        b=Cxkbw863UjCiMdiRXYbCQzhRWSxfrRf32ydRgc8Y96igf2GSl//Kl0aDw7xYvCQY4J
         TZB37ICFXJRVBPN/D6RZJuqcwhEv5WI3r47RiILB7QgXcI59rWoGDcgcLBh91CRvZhVJ
         A1Ra5bkIuTaK1iTPR1QXgUZIDGxiL8wLH15zraz8oy+O1h1WQfnuxWxkBZ/GXclR1V2N
         I7Z+8PRMotvN7X9yCUh8EMoytySs+RDihGX4XxNTSx1p84z36IRQXBoq5jKUaAvOujzl
         OxL4JQNSutWhaJyIjn16MF5sSKnZAYZB8LcX4Y1WuiB8v21rpYnUy76a+crAZlt2KnIs
         CTdA==
X-Forwarded-Encrypted: i=1; AKwUvBzyA6p9iBSfdt2Zu2xfsdhgtovSkfL4pP2zMLfREPM0k4AMHVG5gzmUiNjhg8xUZHsC0TPNrA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKRTfbFPTAaYkYLUXHQGpKdjXJ741C1dA6WGQw6yd3Q/MW9hhoM
	+8O8gzNYEgywYREaDuhZpFK2bAPgIPVVc/RKa30mYeMWpX0QKk3RTU3r90K9+Xwj0yGGeoBl2sY
	2wlgGfrfe7IWzGDWj7ZEHqST2IkL3ILC3WkVr8Guf0w==
X-Gm-Gg: AYBFou1jA9vuOLOiKGGIIag3mq6NmU1pvOtpwnT+LWEFy8XUI9Q+JY/YX9bw8fTQmSk
	r9KJ1KYhD5Ke9SOtP3obqxPvXqAjyXvG7IHBEOTIzOE3BybOn9ncI9Nm0rXURcnwz6rV5mw+v6A
	Oke0oyRz86TxmspdL0bbfEtVCk0rVTlksAetQ6BqGuxxWycWqo9v384tSB/Pv8+ocw3QBTS37qx
	JopbtfDXTM8U5/U70NvkKArhYFFDu1agl6YoCISTv9W957t8SF6liriS8JCZdSWMdujmgAQy57D
	AOEJCpDSK9G+aTV5Amx/VAbFg7haYEEZ71om9DUGhOEAKzLGjZ1i1SHEFmrcU40erA0NpRRqhpJ
	YjyFfcj4=
X-Received: by 2002:a05:6a20:d4c:b0:3e1:d80e:c960 with SMTP id
 adf61e73a8af0-3e1d80ecaa1mr4599730637.1.1792077872127; Thu, 15 Oct 2026
 08:24:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 11:24:30 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 11:24:30 -0400
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
In-Reply-To: <20261015141442.88741-1-sj@kernel.org>
References: <20261015141442.88741-1-sj@kernel.org>
Date: Thu, 15 Oct 2026 11:24:30 -0400
X-Gm-Features: AclHuK9j35VyoW4Zsj0WfuB6VFfItZnWYUAYwwxvoEyaCDxY4Cay-VoxbSK8Zf4
Message-ID: <CANOyQmG9Cw5wtv_XHzOPa7o+rWcDn6R0WQLpeFUc1uK=e94ARQ@mail.gmail.com>
Subject: Re: [BUG] DAMON_STAT: 32-bit overflow reports wrong estimated bandwidth
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

I haven't seen this affect a real workload. I found it while testing
DAMON_STAT on 32-bit.

I used a 32 MiB page-touching workload to get nonzero samples and GDB
to check the calculation. For one sample, the kernel reported 31079 B/s,
while full-width arithmetic gives 333578240 B/s from the same inputs.

A tool using this estimate to compare memory access intensity could
get the wrong picture.

Thanks,
Aveline Noir


On Thu, 15 Oct 2026 07:14:41 -0700, SJ Park <sj@kernel.org> wrote:
> Hi Aveline,
>
> On Thu, 15 Oct 2026 04:24:19 -0700 Aveline Noir <jm5905938@gmail.com> wrote:
>
> > Hi,
> >
> > On an unmodified i386 QEMU kernel at mm-new commit ad9f2d463666,
> > DAMON_STAT reported an incorrect estimated_memory_bandwidth value.
> > CONFIG_DAMON_STAT=y and CONFIG_DAMON_STAT_ENABLED_DEFAULT=y were set.
> > The guest continuously wrote one byte per page across a 32 MiB mapping.
> > I used QEMU's GDB stub and the matching vmlinux to stop just after
> > damon_stat_set_estimated_memory_bandwidth() stored its result.  At each
> > stop, I traversed the same target's regions separately and recomputed
> > access_bytes with full-width integers.
> >
> > Three nonzero callbacks, all with aggr_interval=100000 us, showed:
> >
> >   access_bytes   independent sum   stored B/s   full-width B/s
> >       33357824          33357824        31079        333578240
> >       65200128          65200128        25244        652001280
> >       41152512          41152512        24303        411525120
> >
> > The final sysfs read was estimated_memory_bandwidth=24303, matching the
> > last stored value.  The independent region sum matched the kernel's
> > access_bytes in every callback, so the sum had not overflowed.  Each
> > full-width result fits a 32-bit unsigned long.
> >
> > In mm/damon/stat.c, the expression multiplies the unsigned long
> > access_bytes by 1000000 before dividing by the aggregation interval.
> > On i386 the product wraps.  In the first row it becomes 3107979264;
> > dividing by 100000 gives the stored value, 31079.  Full-width arithmetic
> > gives 333578240 B/s from the same inputs.  The other two rows show the
> > same problem at the callback site.
> >
> > The workload is synthetic; the test checks DAMON_STAT's arithmetic, not
> > the accuracy of its traffic estimate.  The i386 config, guest init,
> > disassembly, GDB probe, logs, and build/run steps are here:
>
> Could you share more details about your use case that require this setup, and
> how this becomes a problem?
>
>
> Thanks,
> SJ
>
> [...]
