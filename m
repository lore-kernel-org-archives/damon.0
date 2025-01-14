Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7922FE0E
	for <damon@lists.linux.dev>; Tue, 14 Jan 2025 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736823974; cv=none; b=K42c8Q4AY7GibRNR2D3jnthAc7iKPQXy7/MvpSktVwz7USFj5l10ahoHRANsyARziUooeQXYFZ3Z36ynS08PM2W2ZkHFtg8Di2ypb1bxPk+aEiW1797ZzJBnxd804TmDWjprKOsk1l5oYggeaPkyNA8368m4Dmq2PNdyVoiRae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736823974; c=relaxed/simple;
	bh=FqdpYPfOVI1DMcPPGT3MPKhuCp2z59PTrykNIWoN5BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXBaj1J8K+bFadxBa5pZXuklo87l+uhgyMBCCkw5mOT/SXGodLfcAzOqFepyFCMjwb6omv7HfOwYaj6u9a98yIcrPTfeA5O2f8wyNDl/a4uHqClWpOsFmN73NjX8jUh1GgSmgCbJwsiKlyvKZnwRJx0eXvhzaBzlnhP1yDzDDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JULNzvuL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JULNzvuL"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8edad9932so34877926d6.0
        for <damon@lists.linux.dev>; Mon, 13 Jan 2025 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736823972; x=1737428772; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtUZDx9l37Yn313XZC7GTvlIbUPEDAdSGSYveecq8vs=;
        b=JULNzvuLdMGJbYpZ0C1NpYM8Bm11QYSZ+xiugPNaxusAqRRDFzR/7anTOyOcDB15us
         ATZ0L4CtEyNnancbp9JzXr1BiN4wgIuVMWdEn7WiQC7CUe8L6WRdrbpE4wx5LnW16OgR
         3i3yKkmYhwc0mMxmLTUyyWTRytB18AWCVXNY3jSg1qXKCLnTi9W6sbz26Dh0+Qh57Sh+
         3OoNCjfxrPP5AaaJ/0ncf3zM0CsN8wxtub17T5/u/AcSlU4oTY09HpHW+PEI+k/Rn5D7
         1KrwOGGCxgvoOMop4rSC5dUgV4y+LrG7SOsstWR58smCclL1HaCPli0nNXQhMCsdLqwo
         L+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736823972; x=1737428772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtUZDx9l37Yn313XZC7GTvlIbUPEDAdSGSYveecq8vs=;
        b=fd2gg0kJbyzHLksM5cHA3/xZMA3eWNqnMHgNdzvn48RW6wKCJBwVL93n/fkSTJEIL+
         3TFqKsiBYH/+sQWsTn0s5RGV2LNIaYAE5Wfn1xBP/a8Vw/pwH41ereh6aZdbnl1vbex3
         XWCiAS+7r8YepW5ANkowxTKqDjayByJblWmQmoMEMqHVegpk6cfBnV3cTNe1wNJnQurK
         t/BLY+5B9Unv7en1VFMO9npPJ+IxHAqgYp//4nDC7Y2+WjNLMC4sRYk3NydMLNCYvniX
         1K3rKLCkDI9jsQKhmoWnTd/JQCdEl+vIUXq1uChNAtEk3dyqrt6Ef7tpXj09/6ghF59N
         lrOw==
X-Forwarded-Encrypted: i=1; AJvYcCVEgDWANfE905ae22ZQ1pF0qDIAVoTyIjyN6016VrCttGC/znvVddRp162k0que/PRNI5GhXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtzFxuL4c2WXkI/FJpFRmEkEZbrrLViEhjUokLxEXXDt+tLb+S
	j6XrcLSerab38ge+KnlIjDJbmy4cukw61YeweilnOeVVwphNDccjhTJRxUGChgY=
X-Gm-Gg: ASbGncuRwXSgmdIUKlnfP9TVaLgs5B1zjr/xNWrfNl7bT3pDcoHcbXGfxT3YJQr63Ft
	ynNNzgPHxeFb8oxVQHpLNjD1RPrb+dBBrKiW92t69q/Iges53CElu6CKXqbdStYQEETwM5MGxaJ
	lShVYSQtI/+KQ1rrYcS4lW3MewShDpM/l2rKnvXK+JRqf2/MylVaFp/Y3KwL4TBMPRKfTnnvniT
	oZFv3mGIejXayoiZBPL1H4EooJKxIPKWStvh56PVRApYsptF2wKoZPAxHiFn7GqLaB3de8p4Bvu
	OHQyoyCuWzX/jqfm1y41LXfQVCNF06TgQvwQW3s=
X-Google-Smtp-Source: AGHT+IEWuwaWcprp4Gpl+J4gz4gbL/TitiB33tFONeErcmRD00ZkT3QMNRoDGqF+c3sisNy1TFSHKQ==
X-Received: by 2002:a05:6214:2f91:b0:6d8:a027:9077 with SMTP id 6a1803df08f44-6df9b1b8fe6mr375286116d6.5.1736823972082;
        Mon, 13 Jan 2025 19:06:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade7327csm48211256d6.69.2025.01.13.19.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 19:06:11 -0800 (PST)
Date: Mon, 13 Jan 2025 22:06:09 -0500
From: Gregory Price <gourry@gourry.net>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Raghavendra K T <raghavendra.kt@amd.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Jiaming Yan <jiamingy@amazon.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Requirements for Access-aware MM of
 Future
Message-ID: <Z4XUoWlU-UgRik18@gourry-fedora-PF4VCD3F>
References: <20250101222039.74565-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101222039.74565-1-sj@kernel.org>

On Wed, Jan 01, 2025 at 02:20:39PM -0800, SeongJae Park wrote:
> Hi all,
> 
> 
> I find a few interesting and promising projects that aim to do efficient access
> pattern-aware memory management of near future, including below (alphabetically
> sorted).
> 
> - Promotion of unmapped page cache folios
>   (https://lore.kernel.org/20241210213744.2968-1-gourry@gourry.net)


I'll break down a few observations I made while hacking on unmapped
page cache promotion - and my concerns for a leveraging DAMON here.

Additionally some other concerns I've seen raised about duplicating
promotion logic across various kernel components.


Latest RFC:
https://lore.kernel.org/linux-mm/20250107000346.1338481-1-gourry@gourry.net/

Basic Premise:
   Use folio_mark_accessed() as a measure of hotness for promotion.
   Defer promotion to task_work due to locking complexities.

My major concerns / lessons learned from this exercise include:

1) The cost of checking promotion candidacy can be problematic

   In my microbenchmark in the last RFC version, I showed that while
   the performance upside (~22-25%) is substantial, there was a
   non-trivial cost associated with injecting even a single global
   boolean check in the file_read() path.  This was unexpected.

   I can probably optimize the disabled case with a likely() clause,
   but I did not expect such sensitivity.  This tells me injecting
   an unconditional call into DAMON may be too much overhead. 

   I would need to explore this further - including whether it is
   feasible to inject such a large dependency into swap.c

   This may not affect all cases, but it does affect at least this one.

2) The complexity of "when it is safe" to promote a folio is subtle
   at best, and "actively hostile" at worst.

   I learned in v1 of the RFC that promotion inline with fma() is not
   feasible due to a few contexts (task dying in particular) in which
   migration is not safe.  I deferred to task work because I noticed
   prior attempts (in development notes) had seen similar issues.

   Adding a folio reference and/or page flag to defer that migration to
   another context (i.g. async kthread) solves this at the expensive of
   implementation complexity. (leaked folios if done wrong)

   I'd have to look at whether it's worth the increased complexity to
   aggregate this (particular) identification mechanism - but I think
   there is clear value to aggregating promotion.

   I could see some value in pumping tracking bits into DAMON - but I
   also see value is making tasks handle promotion as a form of fairness.

3) There were expressed opinions on runtime fairness WRT to promotion.

   There's two competing thoughts:
   A) Making accessing tasks eat inline promotion cost captures that
      cost in their runtime slice, promoting fairness in scheduling.

   B) Aggregating promotion to an external thread can reduce inline
      faults and tail latencies, but may hides per-task cost. This
      is a concern if one task drives all the promotions, effectingly
      stealing an entire core by nature of the async design.

   I don't have a good answer to this, just an observation that charging
   promotion time to the identifying task was a concern that was raised.


4) TPP and Unmapped Page Promotion may affect each other.

   There is a rate-limiting mechanism in the migration path that was
   intended to prevent over-pressuring bandwidth with aggressive
   migrations - prevent major memory stalls.

   By adding more pressure on this limit from an additional source,
   we're obviously increasing the time it takes to converge.

   This is probably the greatest argument for creating a new, aggregated
   promotion mechanism to serve all of these identification mechanism.

   This would make it easier for us to determine whether/what
   identification mechanisms can be aggregated while enabling forward
   progress on each of them separately.

5) Scarce resources

   We need to be careful not to consume excessive amounts of resources
   in an attempt to track all these identifying mechanisms.  Even 1 byte
   per folio is 256MB on a 1TB machine.  This gets out of hand quick.

   With task-work, I was able to add no additional resource consumption,
   but deferring to a fully async scenario and needing to track things
   like last-accessing CPU, timestamps, and etc.

   We'll need to examine this closely if we decide to aggregate either
   of these mechanisms.

~Gregory
