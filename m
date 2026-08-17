Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC35136351
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786935444; cv=pass; b=Y/zaTdEwI1FdgIHU7nlQ+17joDQFx5Y7zYnzGvEjpdl0u05sDq0WyvX5i6g+Ek3me6X0Jvbt7TiFWkPNCQlTcACmAgOxX1pZZRrjB+uP0i2R+bWywIdtY0m/EqsQ9jJniAm5kgzprEQuMMzxVJyPt2lybLcKokKSA6+PL8jxvZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786935444; c=relaxed/simple;
	bh=vmgaJ2oHIS6H0NlQkGJmiNI7EQuyKaNPclzqHGoDO5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSu8pQq583p6IyGgHjadcTa7VWoHni7aGOmip/EtQrDiH9Pfg9m1RSRJ2i8kq/fmDH2DR/d6pyRn3duCRpxza7mKwGCZPo7Px61sfoi7vN8XBhm4YewWfbyHQWTZXF/2bKMOtMPx52T/08SvZJraC+eV30m1AHKcSNxtOhF4Gmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1UHP6EQ; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1UHP6EQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998590d392so30454415e9.0
        for <damon@lists.linux.dev>; Sun, 16 Aug 2026 19:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786935441; cv=none;
        d=google.com; s=arc-20260327;
        b=T+fq4FApIrLQLkyYqS/kRkKqVjCN6Tx3RadFV4YTbw5+VjW+T+11P6oDTyI4B18gDS
         t4hPLfltg7DYcqCJMikU38ROuK7Th0ioWIidqpxfGSFTyOyOgSr+L+y91appZM0/C2q8
         Oli1qFNQxGkyu93F4BhWYYTgM8Z02+W4kRXlMoUIGUv9yHMzgn7EmICJo69/J8A+qR5M
         Y8xKCrBoLcj9liFYb/Ar4AHwz8k3udWTlIXAX0R2IXEud4MVCybKANOxMqn7QrtVphYv
         McH6ofOQzqBlfwZOZaaAf9oTDPlB2Wj2MxRJwkM3Gp4j39b62JfyRGvM6LyZz9+XJm+d
         5q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3E9pfv5IoCCsu+3HPCYQctwF4eS0EkJccI7K/G2Hrfc=;
        fh=oMZv9GKjR4UUMynkKdneYI8CDp5UtYPwWbWEEUqzyME=;
        b=oryKu5FXpXiGOc/ZQF3d+/z0fEqdK1RrezNzuH6KL2i1gAY2IJtrshWAJck5UvUc9j
         /uUGZv1/qp2uDiJt/uSpqdCTzREaiFXXRes1qCQCG1EucUCRhac0JuJsgFP0/opilGh+
         yCCEjHs75kfngPXkvQBM3+5KG8sQtx9vNpGZonD2ngRY1YnvTT1FtllsLGz52qELo/D8
         jROHsqUxwCJOnW5LguriqyfZ8lyFl0Ja0iyXvjuAm7idfnhylDORxKqvQrg+HaMIxdlc
         8zsBlA/YBFrz04C3HukeIRD11QmKsJCvj7pmlANiXSNcVNwEdreVYrKzT7QpJo/dfTeH
         BZYQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786935441; x=1787540241; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3E9pfv5IoCCsu+3HPCYQctwF4eS0EkJccI7K/G2Hrfc=;
        b=W1UHP6EQpZ31pb+iTwsc3qjA2flEQLN57L4MPRuvHSFmzKapZ31k1lJCE6fy5JzAKb
         UY2zWq6BH54bJgk29zMEQ0cLHnoSdPRipAiAJBdvX3Jvz0UcDGY4iipmCrtUSkxPNSM4
         ClYNeJ0awQoE7DyA4eFbFgNuYTKLNWnicxOkDuKcZ8McgihhHukhHMd5e3Pidn1PpFjh
         q0md+7zn/i4d6dmCzCjNSg/7dkpsg3f7AfWiI7UqQM1DA4r1lN+ES4pvV37F9x6zaYq7
         Bezn0vZmi7+7GEwP0sShll2pBrXQ6Mr8v5i4l7vTaqRS4MyypMFN3omPYInIC1DG72QE
         f3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786935441; x=1787540241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3E9pfv5IoCCsu+3HPCYQctwF4eS0EkJccI7K/G2Hrfc=;
        b=L3LGubsqruCuaGZVGfAAIGQKdaFuy+5SCLIhy7rrc2cpKTHbd8Cl+wGKMld5vUTP1j
         0q4vsjDn9M2UBva2Gjldm3HYAFtjb3OBHh4fdU8teorSQYOB+H1rpKhQiIzwi58NvTJg
         ym6u8+rF2ZbCDz0kYM+S9+QhDhrxp9r1arAXKqKUWAIWBTNf71c+XBa0SKdHgfU6ffp9
         PBOAXV4g8sSosJDVJvNB5xzJ5Z9IwLEqkpu66OvOBIcMBPqm2n9WP9QaGKIuRQc+sqRC
         cO1vTaRTwrygrswsm5iiXvJkG2O+uS45aGWFLy69x3Km5VTraWV5FPLP+gDSTBeXud9x
         BcJg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6Ey/ua9wICKVzPvVAGBh+quBegfztbwSqu0zQnZi47h7lnRKuCWi0ammd8/uXy1a35F4Nyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTnkCudoiZyp7285oKB5I0E6TprKE19yIVQJ72wjB54uEwLfOV
	SKKj9vPRQgc7fsqsaKpr6M3THgcnMuJf/GYdd/Hb8mDN7mMXJK3Up/mtXUggKz0e7eo/EB7wnrq
	gTIbWFKQP2N/9APXYP1ei1mxnuXKbYHs=
X-Gm-Gg: AR+sD11wad5RdY15d+U4sAYoui/xjLsYWhmgWpfqSC2ExZ4Bhmfoaowodx05Cez8oWs
	L42K+cjg8CjG/xZGkeLXq4mXx2OP4JsE59IGvqjxFwRKavZNdLu52kcu5bd/8OmLtvKF3flMW6a
	V+ASJsVmvcFgo6YlMgnSrTUhyhgXYOkA9Hv4oXHYIX2GcskzKu5GdxeSyWeYmrCvFhHl2EPi8qK
	sYJnEaPEYAKPHNadgW2EzWBYosCQIWj/0Gnt2rbiNoV74/2Wun6Xk9xbEFeBliVrQX/qP5opW+u
	2rRNfMRCUDYzXAZGj0bgHyq07OLBrmDTU4fconaVuzwyY5c5QbC9eW2YSqolVvbMJvpwaZw57Yb
	KWg==
X-Received: by 2002:a05:600c:4e13:b0:498:11b5:3ff7 with SMTP id
 5b1f17b1804b1-499879bd2e1mr332951265e9.18.1786935440695; Sun, 16 Aug 2026
 19:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260816142222.689624-1-kunwu.chan@linux.dev> <20260816165630.84808-1-sj@kernel.org>
In-Reply-To: <20260816165630.84808-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 17 Aug 2026 10:57:09 +0800
X-Gm-Features: AcwNN1Wv4FilngBM7zb7KtysHXMyaR6NdUjrcCRsxZOtSQWQVLsk7gEZuLi0ywA
Message-ID: <CAN_Opa-aEvmx7Y0xPXHvhaOurt2-nnDMxLjGaHCdMXDsQC=2Xw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm/damon/perf: add ARM SPE AUX backend
To: SJ Park <sj@kernel.org>
Cc: will@kernel.org, mark.rutland@arm.com, akpm@linux-foundation.org, 
	shuah@kernel.org, kunwu.chan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello SJ,

On Mon, Aug 17, 2026 at 12:56=E2=80=AFAM SJ Park <sj@kernel.org> wrote:
>
> Hello Kunwu,
>
> On Sun, 16 Aug 2026 22:22:17 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrot=
e:
>
> > From: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > This series adds an AUX trace-buffer backend to the DAMON perf
> > observability framework, enabling ARM SPE (Statistical Profiling
> > Extension) to deliver hardware-sampled access reports into DAMON's
> > existing SPSC report ring.
>
> Awesome.  Thank you for making this.  This will make DAMON be more useful=
 on
> ARM machines.

Thanks for the feedback.

>
> >
> > Patch 2 touches drivers/perf/arm_spe_pmu.c to expose the PMU matcher.
> > This change is tightly coupled with the DAMON AUX backend.  ARM SPE
> > PMU driver maintainers only need to review patch 2.
> >
> > This series is based on the Ravi's hardware-sampled access reports
> > branch [1], and depends on the perf AUX kernel-consumer RFC series [2].
> > The dependencies is not upstream yet, so this series remains RFC.
>
> Unfortunately I haven't had a time to thoroughly read the dependent patch=
es.  I
> believe the basic idea of this patch series is aligned with the ongoing D=
AMON
> extension roadmap [1], though.  That is, this series is supposed to be a =
part
> of the milestone 3.  We are currently at the near end of milestone 1, and=
 aim
> to complete milestone 2 by the time around next year's LSFMMBPF.

One clarification on the architecture: the AUX backend is intended as a
transport/front-end for damon_report_access(), rather than a separate
reporting path. spe_submit() ultimately calls
damon_report_access(&report), and the AUX path shares the same SPSC
report ring and kdamond_check_reported_accesses() consumer with the
existing overflow-callback path. The main difference is the producer
context: the overflow path enqueues from NMI context, while the AUX path
enqueues from kdamond process context.

The perf AUX kernel-consumer API is still an upstream dependency, so there
is no specific part that needs your review right now. The implementation is
already functional and tested on Kunpeng 920, and I can rebase and resend
once the dependency chain is ready and the relevant DAMON infrastructure
has landed.

Separately, the DAMON perf observability framework
(CONFIG_DAMON_PERF_OBSERVE) was developed in parallel with the AUX backend
and is already implemented. It provides the observability infrastructure
used by both the existing overflow path and the new AUX path, including
per-CPU pipeline counters, debugfs statistics, and tracepoints. This work i=
s
independent of the AUX transport, and I will post it shortly as a standalon=
e
series.

Thanks,
Kunwu

>
> I will hold review of this series for now, and take more time on making
> milestones 1 and 2 for thier planned delivery timeline.  Sorry for being =
a
> bottleneck of your work, and thanks in advance for your patience.
>
> Please feel free to let me know if you have specific parts that need my r=
eview
> right now, though.  Otherwise, please make sure this is aligned with the
> roadmap until we finish the milestone 2.  I do want ARM SPE support of DA=
MON.
>
> [1] https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/
>
>
> Thanks,
> SJ
>
> [...]
