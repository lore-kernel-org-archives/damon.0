Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9B286425;
	Fri, 11 Sep 2026 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086852; cv=none; b=A2qIJ6oeQNatchMIuEpi0A2CuyZM2P2TY1IhUEGMtUmYJcmv7iWPdBUqjHgrzPhQWnGiQNxAWhjdjzuwa2KKJyYwkNtzAYfkLoP5LmD4/zm3G6t3dxvC9T/QDEihd2M0gSzd9U/zzHrKKCg6ctLJXwvVtE9+cF6uPbe9fuH4SIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086852; c=relaxed/simple;
	bh=7PY0z3oea4QnGY4I7Jm0doG+8GOUgmXQWic4N9yIUfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t03tUi4x4lriODI9B5Esi8tFWnfdxDb2W+cW2K3SqP/FY2PjIZa7w5CdKWNEf56vQPCv/humXW75x0/yvbaYX9hVGVDeLxanT6xb9tK4tLxNi6WKe+WHNnzXPpIXTCQzbKsxpc90Omas7RNsPNRsieZZ8GGUOzyM9ohXrDV0AFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRkCWV+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRkCWV+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0166D1F000FF;
	Fri, 11 Sep 2026 00:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086849;
	bh=9lHJMx7oqC0abhZJRPC6EZ/lpB5QzLF/Uxrh+RqEfaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRkCWV+6NtfpT16NZsCqsUyUufxp/ReZ/SfZzFG5LRFFwLcBW0ZGleb+KyBuaCONJ
	 IwH/dXNWfqxbGsaAiRA3Qbq7FTxOQOEhi068OI91SOuJEcrmMLRqA9A3TqzY6LYJ3J
	 A+y5I4Th7POhVnistBnvsfAMKV+R5XlfOXZi6UfDisd153oPhz5CW9GewwvzoBaCKv
	 o4iCfmIErROPPcLPrb9NmDk4y3kuov+RflqMe7SL9zgcqa+dHJNBZqB0ZX4Dk6C7py
	 XpVQayPMRLKp99j+Tz/3xTOQhlG6+mAXVtwFeXdvmcrRJXWlkk3L5L03oflglAoaH4
	 512yHMXAyyGZQ==
From: SJ Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>,
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
	gourry@gourry.net
Subject: Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports
Date: Thu, 10 Sep 2026 17:34:01 -0700
Message-ID: <20260911003402.90722-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 10:16:14 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> This series lets DAMON take its access information from a hardware sampler
> instead of from a page-table scan, and lets a scheme's score be weighted by what
> that sampler reported.
> 
> The change from v1 [1] is that it is now built on the data attribute probe
> infrastructure that has since landed in mm-new: a PMU is expressed as one more
> probe on a context, with its own weight and probe hits, rather than as a
> mechanism of its own beside the ops set.  The rest of this posting is the same
> substrate reworked onto that, plus two consumers.
> 
> This is not a merge request.  The series is based on damon/next at the
> base-commit below, which moves, so the tree it was built and tested from is also
> on
> 
>   https://github.com/ravis-opensrc/linux/tree/damon/perf-rfc-v2-09-06-26
> 
> It is posted for design feedback, on the substrate and on where it belongs in
> the roadmap for extending DAMON beyond the pte-accessed bit [2].  That roadmap's
> second milestone, now open, is a first data attribute monitored through
> `damon_report_access()`, and that is what a sampling PMU is here.  So this
> series keeps that function and its callers and replaces its body: the reporting
> path a hardware sampler needs cannot take a mutex, and the drain has to reach a
> virtual-address context as well as a physical one.  The shape of the ring, the
> drain and the sysfs surface are what is most useful to review.

Thank you for this series, Ravi!  I will take time to thoughly read and reply
this series by the end of this weekend.


Thanks,
SJ

[...]
