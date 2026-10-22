Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792642649;
	b=SWgJ03lWfg+f2rPgwhjeOEDUP3B1TR1wMXmgW/l3iL+qa7TPOtfxX8RG16Q7FpacEM1o
	 rK29pWX7zV54XM0xbaOgHY8f/j9zsZbIojOYfG82vGKL3j8878h9A1BPGpM5GrfGBvFe4
	 kyRaEk9Jyox/VVPawb7Mwgb9ppYuc9oxotx5losYnfLE4ZkOqWSgASyQaQN6VrSYAnUFl
	 vOxWMzs82Jy8ZRc7k01QpBv4d06zHft7r1v29p/IgOsUIRsO1NBUh5/0OUoms8snByabp
	 uTICVC6G7auCN6M6ZsFzB71KIr0mZKhVVzS6ZWeJUQSqYt7cSRwk2xja9Nmu95TiNWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792642649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D4fgTxnwo+3lhaoW5IJ3HlnUCymtn0k12F/Qm8PcmcU=;
	b=epg8AUZiu0urIxmgIAGXirm8rHq5SxV3DqEOhLMM6hj0VP093ziYItmhu+mYk27K2dSV
	 WcgGUnpaDXFkQ6WtLj1RyjBOWwHQu6QNdn65uuzV22DE+f4UfQ6XRZbl5usXtrTfvVH0w
	 MYxPFXUfP1ozsDiKGJexJqbC2iAflU0KrANkqBi2TNs6SbzCFju2YDm38oJtlrkKrGiOx
	 /B16lr7jUsmvw5u3O1ZmTZ4JLI+fVzP/mnL4/nF03eAv6q6uQ6Xix/On5RjpAWHb76edI
	 IbEdv02fQ4LIkUND3iw8Sv/hT61thLzgnMaz7AzeBKbaYRLkRhqBvG52Dq9czzO/f9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZOwOWumh;
	arc=none smtp.remote-ip=74.125.224.133
Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B136606A31A
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 04:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B136606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZOwOWumh
Received: by mail-yx2-f5.google.com with SMTP id 956f58d0204a3-672d92bbfd3so618481d50.1
        for <damon@lists.linux.dev>; Wed, 21 Oct 2026 21:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792642648; x=1793247448; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4fgTxnwo+3lhaoW5IJ3HlnUCymtn0k12F/Qm8PcmcU=;
        b=ZOwOWumhtkLfWVoczX1zi4sIcFSAfrp60zB+9VCaZQ5rfAo27dWsWtL2SNd+DT1Ddf
         0KfNdUPvX9UIxJhYUBTA8l9RRWxKPN7w0dd6bt+QlXVy11YFpvHl0q76qawlyuponYcn
         bPiCkPCAC96WFyCohGDuKpC1cn627LNQIRU7Pn+GUYy48LJqUCCARyZdXmZ76Lio9cOO
         +GptRPkBFzymR8Y3v0XpdIKNr5I4fNXIzJx13dJFb6MlA/Yjhc6C979lDC7Cxae9utGx
         Ae/VLS+fozZe/7fKEdikYf5OTL5wJIuMH/parBqLsQljny65oiaJRo71fWzGLk0+igku
         ULEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792642648; x=1793247448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4fgTxnwo+3lhaoW5IJ3HlnUCymtn0k12F/Qm8PcmcU=;
        b=pf/tNtx7IZXF4oAPpBuPfoAU0zt/pTopFlEI3GXE+tl3HQ/kpqMIQ0PrDCq+AfXAp9
         S7b0Z2dOWbdqWCxPZg+9m5N2fJyOKcZ/yYAxxRId6AScra666wuThE6XnPSZO9pbpGa6
         uRK6FxW6oA0pH/f+7+sMifYWxAUR9ypZvTpaeOl/Q7ssCMpUl8+EqXpxoUlprw8zXDiy
         WRW8SG30cKcJpa1OOAjRN3I7el3sSrwNuxd37MdYmdIkFaCZwUDuwuJKfBzFLd+a9YD4
         XKRp6zgw09QWUotgkAqPP1vIg8Rn78MtkBxQ2kW9aJDSoEJF8rwYKU8LNbQZBthu626V
         Yckg==
X-Forwarded-Encrypted: i=1; AKwUvBzyffsUZxugxc4UFmq/pcPwzw2BEmKViGAN9QvTb+j5XwLTBVeTxBZiGyUAhSmSk9EWwQl27w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIB1a04qd1Qpo0KGdj/e0hyo3DumjX2XzgQ8Evyt5JHDEX8wcGn
	tqA/B0eFDBnb9vZw8cUsQik93yrTa0TGlSN4BOW5jqosyrwjtZRV564=
X-Gm-Gg: AYBFou3pMAFvjH3yq0th4k0z2iVrjd0uwj9pPmYvnV0JlzZYqb8OC9e+JgbEVt3o//r
	MNu788dWz6UPq3iaa2NgFBWl36x5gkTLv18GZNmomVXR14gCdF3XMv+EZkRs1OzFihZp5E+evgz
	urrnpr+EJcM/VYjcNby4/Yq+ebZXWj0aPjbu5yrOZNIWLXxTiB7QRxd4gyJ3eyrTDUtS7Gtn9VN
	yEZfvz4Lf0g6j0Kg+wlx2rNc+VaZJyl5Yltyrh8euRbHrf0OMeX/a2/AnjfJpACfb+kzzzHTrbS
	Xdd4SY0yKOncXAiIZdQbiYzRDWYQ0Dfa7qXQJkY5zLhi3C1DQLe9gnPnibCY6Dl4RBUi7mOFDry
	SAkVL0qlJTaHADlsgb7BHZznV5BxeqYYNYGPY8fSK85c2twXGw4BhNmGYsTkq4sckJiSZZmW2zI
	HpOZ3GphTs7g0p490ctiWSbA/xPjCnOmC52YyPOm1Fs8kehW2yhT7zo1rB0S4bQ2Fi2CQfcvXEA
	WZWVR/iu83J6mIzs22W+4MJXvbGscaeZXEgxiOSJTwY3lJIdWztIidgwn3+BAPIRHTw3bXgzwS/
	xYWttEzzJAYmcOldnBl5eJU=
X-Received: by 2002:a05:690e:c4f:b0:679:5d6b:a3d0 with SMTP id 956f58d0204a3-67a0e5cd260mr1515313d50.162.1792642648484;
        Wed, 21 Oct 2026 21:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:4577:1050:cde2:63f1:eb1b:b344])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b142cf9708sm10230967b3.4.2026.10.21.21.17.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 21:17:27 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Wed, 21 Oct 2026 21:17:24 -0700
Message-ID: <20261022041724.2712-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261017195747.89961-1-sj@kernel.org>
References: <20261017195747.89961-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Thank you for sharing the design early.  Short version: the design makes
sense to me, with one main suggestion.  The first report type should use
the data address the PMU captures at sample time, rather than decode the
instruction later in kdamond.  The measurements behind it are in my
reply to your answer to sashiko.

On Sat, 17 Oct 2026 12:57:45 -0700 SJ Park <sj@kernel.org> wrote:

> Does the idea for perf CPU cycle sampling based access monitoring makes
> sense?

On AMD, yes, with precise_ip (cpu-cycles:p routes to IBS Op): its
memory-op samples carry a data address and load/store type.  On Intel,
even precise cycles samples (cycles:pp) carry no data address; PEBS
memory events do.  Decode from saved registers worked for one of two
test loops on Intel and for neither on AMD (details in the other reply),
hence the suggestion above.

> Does the design provides clear idea about how it can be extended for the
> future extensions that already scoped for milestone 3 (AMD IBS, Intel
> PEBS, Arm SPE)?

Yes, if the report has an address field with a validity bit and carries
the producing report-type (attr) id.  Then IBS, PEBS, Arm SPE (through
an adapter, since SPE uses the perf AUX buffer) and device-side
monitors all produce the same report, into the same queues and probes.

> For the foreseeable extensions (AMD IBS, Intel PEBS, Arm SPE), would the
> required change minimum and maintainable?

Yes, if staged.  The sample-filter matcher and its sysfs already exist
per context; attaching them per probe is the main change.  For example:

  M2.1  in-kernel only: damon_report_attrs(), the queue, region
        lookup, the perf producer; kunit, no new sysfs
  M2.2  your per-CPU write-only example, set up from user space:
        attr_reports files, per-filter report_queue,
        write/cpumask/threads probe filters
  M2.3  counters, a silence check (tracepoint/debugfs first), tuning
  M3    more producers: Arm SPE, device monitors

Implementation notes:

1. One sampler per CPU per attr, owned by attr_reports (as in your
   damon/next usage doc) and shared by all contexts.  IBS has one unit
   per CPU, so perf time-slices multiple events: on EPYC 9555P one
   ibs_op event got 67,140 samples; two on the same CPU got
   33,547 + 33,535.  On Intel the event also needs wakeup_events = 1,
   or an in-kernel handler sees only the last record of each
   large-PEBS batch.

2. A lockless queue, as your NOTE in damon_report_access() anticipates.
   Today's buffer is documented "May sleep" and uses mutex_trylock(),
   which interrupt context cannot use; its inclusive jiffy staleness
   check can also count one report in up to three intervals (HZ=250,
   5 ms interval).  A simple design: a per-CPU circular array with a
   write counter and a per-slot seqcount_t (using
   raw_write_seqcount_begin/end() for NMI safety), overwriting the
   oldest slot.  Readers never consume; each context keeps its
   last-seen write counter per CPU.  A nested writer (e.g. an NMI over
   a task-context write) drops its report and counts it.

3. Report fields: paddr, vaddr, size, time, cpu, tid, tgid, the
   producer's attr id, and flags (is_write, plus a validity bit per
   address, since 0 is a valid paddr).  Store global ids; translate
   namespaces at the filter.

4. Binary search over a sorted region snapshot (your todo in
   kdamond_apply_access_report()) beats a linear walk from about 2
   reports per interval for 1,000 regions (a model, to be measured).

5. Samplers can stop silently: in a report on the v4 thread [1], IBS
   Op samples stopped after about 10 minutes on a Ryzen 5 5600H, but
   not with the NMI watchdog enabled.  So count dropped reports and
   check for silence against an independent reference.  For tuning,
   step sample_period rather than use frequency mode, and do not raise
   perf_event_max_sample_rate: on an early DAMON PEBS prototype (Xeon
   6960P), perf cut it from 100000 to 10000 in about 20 seconds.

Three decisions would unblock M2.1:

  - The first report type: the PMU-captured address (suggested), or
    decode from saved registers in kdamond (your current plan).
  - Whether the report carries the producer's attr id (suggested: yes).
  - The queue: the per-CPU seqcount design in note 2 (suggested), or
    ftrace's ring buffer with one iterator per reader.

One question on the ABI: the usage document in your damon/next tree adds
a report_queue file under each probe filter.  Is it meant as "this
filter tests reports in queue N"?

Happy to write, review or test any piece: the queue with kunit, the
AMD/Intel perf producer, a decode-accuracy study on real workloads, or
runs on Xeon 6960P and EPYC 9555P.  Several exist in RFC v4 [2].

Thanks,
Ravi

[1] https://lore.kernel.org/r/20261017211613.16456-2-aethernet65535@gmail.com
[2] https://lore.kernel.org/r/20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com
