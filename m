Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A9202C48;
	Mon, 25 May 2026 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731210; cv=none; b=nATO7+81PVTY9bZWsKHFpgPupJreTgyseVxz/Ka5KTYrzctiSH+BVcTHf0MwVIIJJaV0Ho8HwNgdQIZQtVC7qsL5I1Q4I7rTod9++oullvHy5mu9jzBFqWQJ9N69NEOXPMDDS4TLpbZKBBtYQQgxcs9KA58Ij7+XQIVafZ8rDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731210; c=relaxed/simple;
	bh=xCdBsMGZdfbHI3Lle4ngP3OCRbUahbZvz3CMx9HV1/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6HxO/nH7Ifgg+GIc4tQO5rSd7kQy8yy0IB+LuJucOYKk2dNf365RJToxLxgriD8MM5wB/MB74wujqpVmg02GyNrcpwr0BeR2KhteO5CXajsmR/kZcRU/avgSwXVAny+8tvsL1fBRka4+tt4xysvxo8hsVXZ3zHgbouuD0Gsl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va0e+LQc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va0e+LQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05E01F000E9;
	Mon, 25 May 2026 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779731208;
	bh=4dZDc9GDzI0pN6F9b1XKxluJTPGuu27MglLZ8HYeE1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Va0e+LQckA05fwwX8igHgzU3UuDxvJM32eJDHqt0gHCr/h387ku0A94ouqy8H+ewO
	 cscPHOj2IZWWAFMsi1FnnqNC+6JmSSlmTP8xfc/gh7eQjPudTUxX7jbJMH+4KBRGo5
	 QQKrDgTb9X7LCg9JAz9vW2xjSA0mOI/uLA6SNw9pvQtHy4t8bWg3jSQTnC+Ni44TX8
	 QKiuS6Mbwfu2KjiceBCqEglcqCOZIpV75HziWeJxbh2wMgoSJgMqmOr+Aav8RLCwMB
	 a3a1QHBiDGIcZj6hJDKJP0H5nQUg2R0U0bk8vm/CV4437974Uf0x7hWXUiXwWqqUhI
	 +wl/XBPYAEQaA==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Wang Lian <lianux.mm@gmail.com>
Subject: Re: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
Date: Mon, 25 May 2026 10:46:39 -0700
Message-ID: <20260525174640.9440-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260525144846.604907-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 May 2026 22:48:46 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <chentao@kylinos.cn>

Thank you for this great patch!

> 
> damon_ptep_mkold() clears the PTE Access Flag so that a later
> access will set it again and damon_folio_young() can observe it
> via pte_young().
> 
> On arm64, however, ptep_test_and_clear_young() clears AF in the
> page tables without invalidating the corresponding TLB entry.
> Subsequent accesses can therefore continue hitting a stale TLB
> entry without a page table walk.  The PTE AF bit stays clear,
> pte_young() reports false, and DAMON treats the region as
> unaccessed.
> 
> folio_set_idle() does not help here.  It updates only software
> state, and accesses through a stale TLB entry do not clear the
> idle flag.
> 
> As a result, nr_accesses stays low regardless of the real access
> pattern.  DAMOS schemes fail to match, WSS estimation reports
> zero, and actions like pageout never trigger.

You are correct.  Nonetheless, we intentionally designed DAMON in this way, to
avoid the performance overhead from the added TLB flushes.  Meanwhile, we
believed this is ok in terms of the monitoring results accuracy on real world
production environment, becasue such environments would have large amount of
working set that flushes TLB buffers anyway.  We decided to take this way after
a measurement [1].

And apparently you found this behavior as problematic on a test environment
that having small size of working set.  We found a similar issue in DAMON
selftest, and we updated the test [2] to simulate the expected real world
production environments, rather than changing DAMON.

But, this kind of question is recurring.  In addition to the previous
discussion, there were a few private inqueries for this issue.  And though the
real world production environment is the priamry target of DAMON, I understand
it is better to support testing environment, too.  So, I think it is better to
make some changes for this issue, if it doesn't make other problems.

> 
> Fix this by switching to ptep_clear_flush_young() and
> pmdp_clear_flush_young().
> 
> On arm64 these perform the required TLB invalidation after
> clearing AF.  The invalidation is deferred, but still sufficient
> for DAMON's sampling granularity.
> 
> On x86, ptep_clear_flush_young() is equivalent to
> ptep_test_and_clear_young() for base pages, so there is no
> behavioral change.  pmdp_clear_flush_young() additionally performs
> a flush at PMD level, matching the existing x86 implementation.
> 
> On powerpc, riscv, and s390, the clear_flush variants currently
> map back to test_and_clear implementations, so this patch does not
> change their behavior.

This change seems much nicer and might be more optimized than my simple
implementation of tlb flush [1] that I tested before.

> 
> Reproduced on arm64 (128 CPUs, 7.1.0-rc4):
> 
>   before:
>     WSS estimation: 50th percentile error 100% (reported as zero)
>     apply_interval: schemes never tried
> 
>   after:
>     WSS estimation: 50th percentile error 0.08%
>     apply_interval: passes

And nice test results.  I guess you are referring to the tests in damon-tests?
Clarifying the context would be nice.

Also, have you had a chance to measure the performance impact?

So, I'd like to have this change.  But, unless we have very clear evidence
showing this change is not increasing the performance overhead, I'd prefer
making this as an optional feature.

For the user interface, we could add a new sysfs file for the option, say,
'flush_sample_tlb' under 'monitoring_attrs' directory.

For long term, I'm planning [1] to extend the data attributes monitoring
feature so that data access becomes just one of the attributes.  Once it is
done, we could control this tlb flush option using the probes interface.

I was initially thinking about asking Kunwu to wait until the data attributes
monitoring extension is done, and add this tlb flush option on top of that.
Because, otherwise, we may need to deprecate 'flush_sample_tlb' after the
extension is done.  But, we will anyway need to deprecate a few interfaces
including 'nr_accesses'.  Doing the deprecation of 'flush_sample_tlb' together
with it shouldn't be huge amount of overhead.

So, unless Kunwu and Lian has other concerns, I'd suggest the
'flush_sample_tlb' path.

[...]

[1] https://lore.kernel.org/20200403103059.12762-1-sjpark@amazon.com/
[2] https://lore.kernel.org/20260117020731.226785-3-sj@kernel.org/


Thanks,
SJ
