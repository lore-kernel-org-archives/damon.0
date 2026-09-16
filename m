Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542A4BEE43
	for <damon@lists.linux.dev>; Wed, 16 Sep 2026 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789530297; cv=none; b=Kc82JH8E/ZYVV7/qiDTBLbcEeZ3vfpO4GUjxONssvGuIMhMffMhzVYwZDwJTXAMlg940a7U+fuMuGh6XFE5tjuuZUhsN4JvmiOG9EiSxHf13a0kQlX7rgq2oSWoQCeCXqz4c80H5IaO/eigxAHy+pHeXGU4BIHoNpB/DOa/+ZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789530297; c=relaxed/simple;
	bh=PQQSm3WvKwZR0U5KrYWkeIfK2l4EGt5o9TAzNYhKkUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMY6GrVlVJ7DzhdkQnEjKg4hwrOYy5FWaBh761/dNZB8+KEJBBPzOysPRiisX4dJ3kKlkxnfGLocWE+PJnA3XZNg+uOfTxa8v+SP132LS/fvzKE+gPUuEXiG22w5D1dLgDHXAbwQBln3HneFmlHEgiD54Pj2WBMW+QEMbkv9Bpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKrY4yTw; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKrY4yTw"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so371150a91.2
        for <damon@lists.linux.dev>; Tue, 15 Sep 2026 20:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789530296; x=1790135096; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnDdBBFYGdDerxU4AbUc/Vqzv/CMmRt4z5XHr/nlcM0=;
        b=TKrY4yTwlqWE3lyvFnPyAZUwzqlP8RdXE6Fcj5asfg4Wkbi9eV7P/rw2Yn9I1Vm6DI
         0qcALTieuiRhqcGL7LCEpj0s2Im0P+yu5EjYoaNQkopPB4704E+Cr3T9lUfXxygex+2U
         OUjS35OGldcDmMzS5GrwLb+aRUpLp/XVmst31w9wVWgoxmjqPtOADh6p7PUjA2AKD7Zd
         6GL4KYTodUa3LmMX5pH3Q+f2u6krbpxSTb4Epq4gWpzCl1ikaoXx1lH/BIXz91HjwYH7
         8rEHjIe7Qm0VL6ji64IkyVs8awGNU6xnnt3z1h+TXN8QOzDJizWrNA88FWDwYkCmogU9
         iB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789530296; x=1790135096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnDdBBFYGdDerxU4AbUc/Vqzv/CMmRt4z5XHr/nlcM0=;
        b=cT3Tbca3l5Mz0H+lSEihqenmYMhz5mtNofptwVyH5/wjvC4NoJS4SB2nHFtP9jln2A
         9s/ajRWfCI5mWXAnDYT43tUSkUJUjCgeVPSv15wYNUs3gYxGPlUTHQjac7xYMu92d2EQ
         sAUOyZnQWBcHexudqPPeR4jmPnHKSSQmuEPRdK6gfXCFhjZYo0cOE6s5i9oIdVTEjtwr
         ay6nJrfYXUtfAcP8Crokhcv75xm3DjWbhJwn6CJh+7y4bVkvI2GH2MdFChisxosSvBFu
         Wdu7L2M73XvL78aKZCI+4Y0xKVnwXOdHRKI8t12vJU+l1frmrE2hpUJDqf4lK3UltYSW
         qZug==
X-Forwarded-Encrypted: i=1; AKwUvBwP9dUVz2HNxVJS5I8M8tGBjQGRVyn+/z07znD25VoFbNtZxDm6+XXLWziAie0skgbUsyOFJQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mJHwudeuL1bF6d936427b1NXFhG9mEg/CeUhkABjcIvSI+Z3ja
	ip5VfjP+5Q8EAhxTbRRsed/ABhe8wZk0J9UpcOxSymZXF5lYqZCpYogp
X-Gm-Gg: AYBFou1IFAUiXNt4PqoDkqomOS+HVq8A9KnvMqqess+Yuqh9iFc9Klc5LbpY4gMItDK
	JBzOfk4DQm6XEisefPcobtamwThrxEXXVEpSXFqCBn7KemOpuGnQ5jEb6Vql1NRgwGm5JzVq4UP
	Tw5WMksdsppsrihMjO+JVZOo5gE93Vz1L9N6TGh6CyvaEVkXvrwvu0vIxxsoObNhXv2Y49sWvgU
	Ghdae0ASL+mAJGHtQhRTn+VbfiFNPqBSkzJHICIqmuGZcOCwv2kaYTbGhxa5I23AFUjwo0bv3R2
	A3971G3/GwAPwDVUpJ0zKxPf+4xvViq1Os83jVvq2zHaTzgM2ozHMMopXtW22EIhWQMr53aqKI9
	2cpBVAvGuXnPHkp0n56fXhydZORPB28cW+fbYYwHLz4dxw86hrIIT5EWCzVhSvGvourWyQnNNi1
	4hFZUlPxSXav/HpO8ic3eBliHH9r3R7ty5nUEHRSiUXVhdN5Kj6Rv4h/OfRyD8iTwPXKtoJnuyL
	n96u/y0DC9dXLBWNoNZdFzRWy3Vp2d1PqSPOMrx
X-Received: by 2002:a17:90b:3b91:b0:398:a486:81ec with SMTP id 98e67ed59e1d1-39e1e380e12mr2394470a91.11.1789530295541;
        Tue, 15 Sep 2026 20:44:55 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm1915990a91.11.2026.09.15.20.44.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 20:44:54 -0700 (PDT)
From: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Lian Wang <lianux.mm@gmail.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
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
Subject: Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports
Date: Wed, 16 Sep 2026 11:44:30 +0800
Message-ID: <20260916034439.28517-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916005810.101606-1-sj@kernel.org>
References: <20260915025514.2434-1-lianux.mm@gmail.com> <20260916005810.101606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Thank you for the questions.  I mixed the original field scenario and our
controlled reproducer in my previous mail.  I also jumped from the observation
problem to PMD mapping demotion before explaining why the deployment needs both
huge pages and finer-grained observation.  That made it sound as if our goal
was simply to stop using huge pages.

> The observation makes sense.  However, does the sparse access pattern
> realistic?  If so, what is the purpose or expected benefit of using huge page
> for workloads having such access pattern?

The original case is not a lab-created request to use huge pages for a sparse
microbenchmark.  It was reported by SXF from a KVM/QEMU deployment where the
VM has a large memory allocation backed by a shared tmpfs file, host THP is
enabled, and Oracle runs inside the guest.  They use host-side DAMON to measure
the VM's hot-memory proportion.  With the same business memory use, they
observed a much larger hot proportion when THP was enabled.

The guest tmpfs 4 KiB/2 MiB writer is their controlled diagnostic case for
isolating that observation; it is not a claim that the Oracle workload is
exactly a one-page-per-2-MiB loop.  We then reproduced and quantified the same
effect on a PC and on the x86 server.

For this deployment, keeping large pages is a real requirement at the host
virtualization layer.  QEMU owns a large resident guest-RAM mapping.  Host THP
allows that mapping to use PMDs and allows KVM to use large secondary mappings,
reducing host page-table memory, TLB and nested-page-walk pressure, and KVM
mapping/fault overhead.  These benefits are independent of whether every 4 KiB
page inside a particular 2 MiB range is hot at one observation time.

This host configuration should also not be confused with the guest database
page policy.  Oracle may separately use explicit HugePages for its SGA inside
the guest; the guest policy and the host THP backing of QEMU RAM are different
translation layers.  The requirement reported to us is to retain the host
large-page benefit while measuring the guest working-set proportion from the
host.  Disabling host THP merely to make DAMON's number smaller would change
the deployed VM configuration and remove the benefit the user is trying to
keep.

The monitoring requirement is different: DAMON is expected to estimate how
much of the guest memory is actually hot.  A host PMD is a translation unit for
guest RAM, not a semantic hotness unit for Oracle.  Guest allocation can place
small accessed pages across many guest-physical 2 MiB ranges, and one access
then makes each corresponding coarse mapping look accessed.

Our latest capture makes this mechanism concrete.  The sparse diagnostic
touched 24,576 guest 4 KiB pages spread over 24,575 guest-physical 2 MiB
buckets, while the dense control touched 12,582,912 pages.  They are 0.146%
and 75% of the monitored 64 GiB backend, respectively, but host DAMON reported
about 75% for both.  This is why the user needs huge-page mapping for VM
performance and, independently, finer-grained observation for a meaningful
hot-memory ratio.

The performance requirement and monitoring use case come from the deployment,
not from our lab model.  We will also report the measured Oracle/VM benefit and
the production access distribution when those data are ready.  The diagnostic
result establishes the observation mechanism, but it should not substitute for
those workload-level measurements.

> I'm not very sure if this is the right direction.  PMD mapping demotion sounds
> like you just don't want to use huge pages.  If so, you could disable huge
> pages.

I agree.  My reasoning in the previous mail was too jumpy: I went from a coarse
observation directly to a possible MM response, and that obscured the actual
goal.  PMD mapping demotion is not part of our current proposed solution.  The
current direction is to keep both the huge folio and PMD mapping unchanged and
use a genuinely fine-grained access primitive to improve the observation and
the stat-only decision.  We should first find out whether that is sufficient
before discussing any mapping change at all.

> technically speaking, it is not the report semantics.  Reporting allows any
> information to be reported.  Page faults like information could be coarse
> grained, same to the current page table accessed-bit based one.  Only finer
> grained access primitive reports, like those from perf events, would increase
> the accuracy for the sparse access pattern monitoring.

Agreed.  The report interface is the transport, not the source of accuracy.
Our recorded-address replay is intended only to test whether the DAMON
consumer and decision can use complete fine-grained address evidence.  The
eventual accuracy has to come from a fine-grained primitive such as an
appropriate perf event source, with its coverage and loss accounted for.  We
will use that terminology in the follow-up results.

With this context clarified, we will return to the immediate work: use the
existing IBS/perf-event proposal as the concrete strategy under test, and see
whether its fine-grained evidence can improve the observation and DAMOS
decision for this case.  We will use the results to test and review this series,
report both improvements and remaining gaps, and not assume in advance that it
is the final solution.

I hope this clarifies why keeping huge pages and requesting finer-grained
observation are not contradictory requirements in this case.

If I am still misunderstanding any part of your questions, or if any part of
this explanation remains unclear, please continue to correct me.  We will keep
sharing our findings and would like to make sure we are aligned before going
further.

Thanks,
Lian
