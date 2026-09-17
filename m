Received: from mail-pj2-f26.google.com (mail-pj2-f26.google.com [74.125.227.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FD1448E0
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610830; cv=none; b=Ht/4LLSjebZQXeyJEv+stgDV01LJnJx9p9/QzzTmjOL/+bG1WCaxn/ShdCH4EEbbCslOxUJO7wPmRlLr7y8fj736oY2dpVBcygi+KGB4QhkDkNSx0ArCkldRTLaQ2wdkgsA9lhteNxwnJFnoJFN90+YrW+bMcIqETl8J+Y/HIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610830; c=relaxed/simple;
	bh=2Au3LTyyde1NXe3pV1Jp5fFNXw8iKXKum8s4v/uClQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNBNN+PZZOWNKLnsGhfaedpeMbpCmPExbd085MavtD2bTi5y5QrCNy6yCGMxVVpTfl/4aemxp9KCCiZGdpDgtdC9zeaTsvqkN/LWDTR915txVWv/VjvwHOGFt1uysgVMJGAYwn0IHD9mx/kz7RweRsKzEnItd927pAcmj5lC73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULzhmkxE; arc=none smtp.client-ip=74.125.227.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULzhmkxE"
Received: by mail-pj2-f26.google.com with SMTP id d9443c01a7336-2d8fb334e72so3142115ad.1
        for <damon@lists.linux.dev>; Wed, 16 Sep 2026 19:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789610828; x=1790215628; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Veq/d5GG4sWMYx11wlD0mjBLYK1jExJiTNsjFaM3d/s=;
        b=ULzhmkxEqBkJBdi5vfOpo5Teu7zvavinX5JNX/LgaFV+z5/nP04gR+8iMRdomAv4Ap
         LOWPstUvhhTm60mgjB2yaXnCqnZmGeMEgjluiIv7YPGJVtPH0cqOpjH5OHPbRrb5Tvf3
         ll1LoFeGkcdzHX5ZbouLlAspvUabDAAXb+aTxN4B2q8rSxk4TRzPQMn+XiccUARlzEDY
         mJoWUr2Mz1ihUd/jafwjMj6zyLoUiKz7sOx+/a0hG2ofd5Yjl010dNRefLavAazz+sAy
         jMQ984fKGT95UF03Z+D2aGsBWp28/sBTikuEtWKJtKuLVsFOVjTNlbfRpv4EEDrYfZbw
         RU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610828; x=1790215628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Veq/d5GG4sWMYx11wlD0mjBLYK1jExJiTNsjFaM3d/s=;
        b=MK9nRQY5TDFfPiAQLyTtq2ouewajd53TmvngAIO5gwCrgTdOAZjgwAsakDBMXqls3y
         OLLmkHnuEJ1d8aZlJSOrYmQKy1B6HWf2wTN6Y7QlDfDEIsAItuqwV7Tt7A2vVl2gp4Mn
         UDOQ6NQyq7IdtTU/cer34oUjLaShv7PFNKFwSrYjpVkOvB3MA3tDVjsqwjmhaM2TTlvK
         IuyeWBFc2JQ2OwpkckPXt3iE+sZ69rjQavyxFWqeTx7F0CgyrpJCJUDo0/DTxVmU0atR
         p6575+3CKTZOPWIx2OgvYI+7XX5agZgA5VoyTtAEOMpNMwx0g+Dr1BLebrQixFq5qGdJ
         zt7w==
X-Forwarded-Encrypted: i=1; AKwUvBz1sQn9D469kXf+wuqYVeuydmfQxdwHvLp5VvbSTSNIYWvd77f5fv4ORIuqeHpCtmj+dq3KHA==@lists.linux.dev
X-Gm-Message-State: AFuF++mDwMCLe7mNd7HaPzo+rSG8gvCKfPpv7nR4KV7zslpKhbQZGF4N
	JQ/RXl2XiQ0qr83KUkFB/HAvu/mjriuHNTPRNLyI1DgwEXENBrYNsFdV
X-Gm-Gg: AYBFou24U88DDoSy4xWagKG+CjmzE71bd5RHvcIrk6s+addBSHX86JeKhbcK1QRycqo
	pX8+pfZOtX6CQCdu9r4okXHLZ26Fp4k/4usUTqX74apk7/Ox1AwvWSlgCw8UvQF7CV7vE8O97Vp
	RqE6oiYeZ+LRboQmSYkRTvG+Gi9Nf+8foH2HP2zzP26EwX98ceDsRgryHdO25s2XLjYg0H8gBZ+
	qk6diHZjHBvJsjtzEAUHYPxaTsWxqN1iQpBT4MrD0mslxVP/NQCs6jj3fBqOyVe/QMU5QWpxrY5
	cD2137xYAB0iR6UZLZ1eZUMbp8UqCONph1ZTMDs7WVcOyLiI+g7HAuIYIIzpy6exRo+dU+36r3m
	9J/s+iih+jclrJ62fR83M1eo2xnKbrL/NDIGkT/qMKjve9K7j/WfzFz6ub+jTlCHHGrOFqF8YMN
	WqZt/3r4pooQjlExevThtzJZ90pn8P8MloaLm3FkuY9uoo5SrCgjZ9dYptibnebadOdCqKuDWa/
	+L2QFEOnyTI/bTUcDbkb00H8M6dmZdq1rXnGEci
X-Received: by 2002:a17:90a:28f:b0:39e:2530:2102 with SMTP id 98e67ed59e1d1-39e253026d9mr9151823a91.11.1789610828473;
        Wed, 16 Sep 2026 19:07:08 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e39b0399bsm383108a91.2.2026.09.16.19.07.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 19:07:08 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: DAMON reporting more hot memory on huge pages (was: "Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports")
Date: Thu, 17 Sep 2026 10:06:37 +0800
Message-ID: <20260917020653.46010-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917004533.89744-1-sj@kernel.org>
References: <20260916051150.107931-1-sj@kernel.org> <20260917004533.89744-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Thank you for thinking further about this and for suggesting the damon_prep
direction.  Let me first clarify the real-world use case and correct one
expectation that I created in my previous mail.

SXF develops a hyperconverged infrastructure platform.  The workloads running
in the guests are customer workloads, and their types, memory sizes and access
distributions are not controlled by us.  Oracle is the workload in the case
that exposed the problem, but we cannot define one Oracle access distribution
as representative of the platform or provide one generally applicable
workload-specific THP performance number.

The platform has two requirements:

  1. Host THP is enabled by default.  Large mappings generally provide useful
     translation and virtualization benefits, so disabling THP merely to make
     monitoring easier is not an acceptable general solution.

  2. We also need an estimate of each VM's active memory as an input to later
     memory-tiering configuration.  If a small number of distributed 4 KiB
     accesses makes many 2 MiB mappings appear fully active, the hot-tier
     requirement can be substantially overestimated.  VM sizes vary, so the
     absolute error can become large on a large VM when accesses are spread
     over many huge mappings.

The reported setup is a KVM/QEMU VM whose large guest-RAM allocation is backed
by a shared tmpfs file.  Oracle runs in the guest, host THP is enabled, and
host DAMON vaddr monitoring targets the QEMU process.  The field observation
is that, for the same business memory-use case, the measured hot proportion is
much higher with THP.  The guest-side tmpfs 4 KiB/2 MiB writer is a controlled
diagnostic for isolating this mechanism, not a model of the complete Oracle
access distribution.

The DAMON setup is:

  operations=vaddr
  monitoring_attrs/nr_regions/min=500
  monitoring_attrs/nr_regions/max=2000
  monitoring_attrs/intervals/sample_us=500000
  monitoring_attrs/intervals/aggr_us=20000000
  monitoring_attrs/intervals/update_us=60000000
  schemes/nr_schemes=1
  schemes/0/action=stat
  schemes/0/access_pattern/age/min=0
  schemes/0/access_pattern/age/max=18446744073709551615
  schemes/0/access_pattern/nr_accesses/min=1
  schemes/0/access_pattern/nr_accesses/max=18446744073709551615
  schemes/0/access_pattern/sz/min=0
  schemes/0/access_pattern/sz/max=18446744073709551615

The hot proportion is derived from the bytes selected by this stat-only scheme
(at least one observed access in a 20-second aggregation window) relative to
the monitored QEMU scope.  It is used for later configuration, not as a
request for DAMOS to split or migrate memory.

As shared in my previous mail, our controlled PC and server runs reproduced a
large THP-off/on observation gap.  The exact-address capture also showed a
512-times difference in unique 4 KiB spatial coverage while the two aggregate
DAMON hot proportions remained nearly identical.  The conclusion is that the
current coarse observation can substantially inflate active-memory estimates,
and configuration-only tuning cannot reconstruct the missing within-PMD
spatial information.

> I still want to better understand the real world use case before digging into
> the specific solution.  But, I was thinking perf event based monitoring might
> not feasible for the case.

We agree that perf-event feasibility should be established rather than
assumed.  We will test the address space reported while a KVM vCPU is running,
per-VM attribution, coverage and loss before relying on that path.  If you had
a specific feasibility concern in mind, please let us know so that we can
include it in the test.

> That is, we can request DAMON to do some preparation action for the data
> attribute sampling, using damon_prep.  At the moment, set_pgidle prep action is
> supported.  Maybe we could add a new prep action, say, split_pmd?  Then, the
> following sampling memory access check probe (would be a kind of "allow
> pidle_unset" probe filter) will be able to show the access on exactly the pte
> accessed bit, not the pmd accessed bit.
>
> Breaking pmd would cause the overhead, but it would be capped by the
> max_nr_regions.  So the user could at least consider about the tradeoff.  I
> think this is simpler and more intuitive than DAMOS-based pmd breaking, at
> least.

This placement makes sense to us.  A split_pmd preparation for access sampling
is clearer than exposing PMD breaking as a DAMOS action.  We understand it as
refining the mapping used for observation, without splitting the underlying
huge folio, and then letting the following probe observe PTE accessed bits.

We will follow this idea and validate it.  In particular, we will measure the
active-memory result and mapping cost, check whether max_nr_regions also bounds
the cumulative number of mappings that remain PTE-mapped over time, and verify
whether splitting the host process PMD is sufficient in the QEMU case or KVM's
large secondary mapping remains the limiting layer.  We will compare it with
the perf-event path, stat-only first, without proposing a user-visible DAMOS
split action or physical folio split.

Please rest assured that we see this as a long-term technical discussion and
collaboration, not an attempt to rush one mechanism into the tree.  We will
continue sharing both positive and negative results.  I also plan to present
the scenario, evidence and tradeoffs in more detail at LPC.  Please feel free
to share any concerns or ideas at any time; we are happy to keep iterating on
them together.

This topic has now become broader than Ravi's hardware-sampled report series.
If you think it would keep the discussions clearer, I can start a separate
thread focused on huge-page observation and the damon_prep approach, while
keeping perf-event implementation and testing comments on Ravi's thread.

Please let me know whether this clarifies the intended use and whether our
reading of the split_pmd damon_prep proposal matches what you had in mind.

Thanks,
Lian
