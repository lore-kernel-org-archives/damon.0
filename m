Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841550;
	b=b5NEc9tvk1dmRhF8QBdJ5rcTKBcEbKUwqIUtPkdcbSzHShZs89EkuDwReBSYRNKn6QUv
	 sGm0b7aiBpUu7Jv5SasULY9q6uFZGljW8zh/5gOt8R8ktI6idM667WnFMhFuPvosP3DTn
	 t2m11pgpHPyz20FYlF/VnE0glVVumW5PnPAMs5k58nnKNe/kKVqNQGQPu6cLSt4GyjWqA
	 zFP9Nsg3u9ohFvzfJvETV6EWr06Rw8y+uHx7Q4NGJub+/XQrlY+5iO8ue0RYJ1mjyFDJa
	 xlau4MG1Wlwa+d2QTZNk21Lw+691hBVMI1mnDNTsCLzsEZ5i4QjFilQQlLOHTTxFZmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RWLDU4EWfngmSrcCkbKdVTyatFJ0OqjQckEYPqGngkI=;
	b=1haaQ5ZIQcg6S7P9QpVpWe+pOghDNpGB6fnn8kdBX2Th9REOyDP8Mdpa3SkeuI0K6UKC
	 yALZARAvdQ5QiG7ZnGTMsYFRpiofQiGhoxrp/qJbCbId1TzzEQWz96kGEU4oAc/B/Zzb+
	 zpndczJ3gNIicSgqyuKU6Twax2c9psAdbYd/iDKam4D72e6e6IIwK6g8jlUUMVhDLuseZ
	 3fUOvaOyWEKRSpISLbvWvFOPCcW927oPL6stJqFoKzseYzymt8dgVU6yx/rhXikxPyz8C
	 Lh+AIxljZ7A5Xo7uJEVSh8sXHTn3ZQYb7GO2/S/IckWjWVydIcRRWKTXfmSmUFVkhqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzEjei9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CC606A31C;
	Mon, 16 Nov 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzEjei9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84921F000C5;
	Mon, 16 Nov 2026 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841550;
	bh=RWLDU4EWfngmSrcCkbKdVTyatFJ0OqjQckEYPqGngkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzEjei9C39bx/30fiWMJo3u/F0Eq3Uvo01kc85HuJz/fp0oiWeQJN9WJmLneGSbB4
	 JhADs6kxenLsjsEL2WN4qqLDkNZ2uvBsFHxm7xwrAc5+vhpAFHyO6TmkxjSMahmTSs
	 SCfr491ibmKagCRmtUKAZCNPUsN8vuxLw5eWgcVnCRkRFouDn9yphQK7NheS5iCUW6
	 cH5+DtbGmjFPqbBkltdlHReX2VhFskhdZTrFwzMwa2hreaGIhGcsoRm6qKufflW09c
	 oLhVcGmBh9P91Ok+9cBl7ulFynGy4ShKnKgO9zfiErOyIj8FKDGBhzkaFQMljejseN
	 YDRykM5cIFyMg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [RFC PATCH 14/27] mm/damon/paddr: support REPORT_MADE type probe filter
Date: Mon, 16 Nov 2026 07:05:42 -0800
Message-ID: <20261116150543.80514-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179481501691.2405628.8067144236288202449.b4-reply@b4>
References: 
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

Hi Aveline,


On Mon, 16 Nov 2026 18:43:36 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Sun, 15 Nov 2026 12:28:32 -0800 SJ Park wrote:
> 
> > +	case DAMON_FILTER_TYPE_REPORT_MADE:
> > +		addr_range.start = pa;
> > +		addr_range.end = pa + 1;
> > +		matched = damon_report_exist(filter->report_type, &addr_range,
> > +				jiffies -
> > +				usecs_to_jiffies(ctx->attrs.sample_interval));
> 
> Since the window is counted in jiffies and rounded up, how many samples
> see a given report depends on HZ.  With the default 5 ms sampling
> interval, the window is 2 jiffies at HZ=250, i.e. 8 to 12 ms, so a
> report is usually seen by two consecutive samples.  At HZ=1000 the
> window is 5 jiffies, but kdamond_usleep() sleeps via
> schedule_timeout_idle() there, and samples end up about 6 ms apart, so
> a report made right after a sample can fall out of the window before
> the next one.
> 
> With the queue indexing fixed, user reports submitted every 50 or
> 250 ms and covering the whole physical address range were counted
> about 2.0 times each on an x86_64 guest at HZ=250, and about 0.84
> times at HZ=1000.

Thank you for sharing your thought and test results.

> 
> Is this approximation intended?

Kind of intended.  DAMON uses many approximations for low overhead and easy
maintenance, as long as the results are practical.

For this case, I'm not that scared about such over-counting.  Users ain't
really care about the report counted just one more time.  I'd rather expect
users repeatedly submit reports to make sure DAMON shows the memory as hot.

Also I believe users could tune intervals, manually or using the auto-tuning
feature.

> If each report is meant to be counted
> once, maybe we could keep a per-context report sequence cursor and
> check only the reports enqueued since the previous probe run.  A quick
> local hack of that counted each report once on both HZ values.  If
> reports are rather meant to stay valid for a while, like a user saying
> a range is hot, a validity period separate from the sampling interval
> might fit better.

If it turns out the approximation is real problem for users, we could consider
this kind of improvements.


Thanks,
SJ

[...]
