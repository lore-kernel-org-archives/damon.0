Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F1349CDD;
	Fri, 16 Oct 2026 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160225; cv=none; b=Rtis5hvRNTobV5lOLJ6kVc32uXD1tbttFqcCbyk8sIPggX0MyIAGQslbiOsfk8ZOGNDQS+w4el4TpPAaZ4hORIoBdLsR8itKNuLcyEBixs/EpGxC/dxrfoPD551du1LF/Xr26gCnasIqGHB/w+ZfsxzmTqoz8OKFTij4N8o1vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160225; c=relaxed/simple;
	bh=SKTWk7HvFFA67Ryywjtu3nHcNULy8QYaQlDa3i0A0v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd772FEScPTa3WFQEXg6xmW5IYtt9BkryKxlpczXpA44wvK7aDILNu+zUIj5lK9RJRGcBxfwJDKnHtwRdMTZmn2mcs77HQTymM8FTRS6FpN8uwgSI72pFSbeOTmNBmr9TJoQ75GEhYWgKW/VN1tERkEfNQKchpsF8s/74AHLTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAXAfP9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAXAfP9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE571F000C5;
	Fri, 16 Oct 2026 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792160223;
	bh=b2VQkAftmXnblL7IeVaeDeAnYYS9mQ6ICu4SlOn3GcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EAXAfP9EuBjp2chpB8buw2ql+T/nNSCBvWeodlkEX1c0xKLO05HH6nVmzSZ0ckXoM
	 7ixtf6cBxqV2F4XjtO0nDq/LrOwREGst5oNVKujYyBK4o80v6zXeCd0WrgXKAlB3wG
	 U9DkTHD7hz/Us3hNuORN3cJghgiZad8Z2kzh+O5x/EQApZKqUnAyTkx+Xgm9lDuT6v
	 jI9e0dqvrE9gLdxD6l7wIxWn48RqlU+RVGqx7PwMRC/nR1JdIDSzApL71IedVSk9HV
	 9uU9wfiboBGpPHijAN2efJK2CoiW8+4S8lHJeC7HrAuR5Lb5sitBRIKPjzRgEEcESu
	 5CYoHfhgUE8jQ==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle percentiles
Date: Fri, 16 Oct 2026 07:16:56 -0700
Message-ID: <20261016141656.126278-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179207592479.3.11595453180868898703@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 22:52:04 +0800 Aveline Noir <jm5905938@gmail.com> wrote:

> On 32-bit, accounted_bytes * 100 can wrap before division by total_sz.
> Some entries in memory_idle_ms_percentiles then keep their old values
> instead of being updated.
> 
> For example, a 256 MiB i386 QEMU guest reported p0=19200 ms, but p50 and
> p100 were both zero.
> 
> Cast accounted_bytes to u64 before multiplying and use div64_ul() for
> the division. Compute the percentage once per region.
> 
> Link: https://lore.kernel.org/r/CANOyQmHad1vamnZT12M5yPrJ69==Pt1U0+MGw6u0MuNtr-DRCw@mail.gmail.com

From the next time, please give context about what the link is.

> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree, after slightly modifying the
commit message for the abovely mentioned small thing.  We are now quite close
to next merge window.  It may better to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this series is not really urgent.
Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
will request adding this to mm.git after next -rc1 release.  So, no action from
your side is needed for now.  Let me know if you think this is really  urgent.

> ---
> This is against mm-new ad9f2d463666. With the fix, the original test
> reports p0=p50=p100=19200 ms. The i386 kernel build, x86_64 W=1 stat.o
> build and external arithmetic checks passed.
> 
> I also ran 38 before/after VM tests and 20 same-image controls. Throughput
> was close overall, but median kdamond CPU rose by 0.0053 and 0.0221
> percentage points of one guest CPU for stream and sparse, respectively.
> Some pairs had 5.91% lower throughput or 15.49% higher scan P99. So I can't
> yet tell whether these differences come from the patch.
> 
> 
>  mm/damon/stat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c

The above empty space before 'diff --git' line was making 'git am' of this
patch fails.  I manually fixed it.  Please do not add such empty space or
something that could make 'git am' fails, from the next time.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
