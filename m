Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4732B103
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728882; cv=none; b=QYPpUtRJ/FPnYsZTe+r9fr+sfrqA6v8oiqlyjEIIBVSc3IabX60h6M+ps00PMsF1O5QH0gEH1V4uwFWgA5t+e7QeytyD0lnhIIX5bzgJGkDvBYT0+tY510kYnKlch92zCPi1mo6ijj46LSFutag6xRWbXGQ5bmbpsjwzWIUOzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728882; c=relaxed/simple;
	bh=VsXq/CBIkaudGODBdXidjkP/Tz8x9B1bT4yZOBSkLuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvdUpkfhmCb/bYZyAmorTrSitAYCkumjRmThCKsR5Pl3ZCp8so28B96a9elHkLho89RutWzgjL+Mdj5N08E51IngLjpt0gozpONcwSzk1WN/id27c71ky9bSU5bFWfShKBhPSkSooiNHemK21xAQ8cNHNtOC0RZQ2D395b3fzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnCVqY5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnCVqY5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CA61F00A3A;
	Wed, 22 Jul 2026 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728881;
	bh=sQmQqnqMOYrUcNGVJ/3vfJ4PASaPSYi36WsJjmVd764=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnCVqY5Oyk7HD6BsFhm1GB9/W7hna3ghqXTbvVP6f0IKEExaDijrSGFtOzgenptG1
	 4wpmrJ0tOPv6JOJfxB0LuFWNwPRyVoN4LxT9nQk0V7tmfTc/A8+99TfsfVXBS6pMRR
	 KsyloTdd/CcG0LTPMJcNsj1YOd5T+p+fQ32y5aSEpp3eZKMJgEvj6JMTjXFL5g6+6g
	 lQy7VVe277Y3/XBMO628knfRVLwyhUrpO2WZD4Kr1NKf8szhUngN93ZMV9M3qA/DmK
	 J0g0zn1FIpmeIa/5cyjLYwrl3VGOZgP273OrK2uEICRRXW6QXAcXogncd7vIba0Rd+
	 5jhYZmujNZ/Vw==
From: SJ Park <sj@kernel.org>
To: dayou5941@163.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH] mm/damon/core: reject zero sample_interval
Date: Wed, 22 Jul 2026 07:01:13 -0700
Message-ID: <20260722140113.88379-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722094304.3132750-1-dayou5941@163.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello liyouhong,


Thank you for sharing this patch!

On Wed, 22 Jul 2026 17:43:04 +0800 dayou5941@163.com wrote:

> From: liyouhong <liyouhong@kylinos.cn>
> 
> damon_set_attrs() allows sample_interval == 0.  Sysfs likewise accepts
> sample_us=0.  kdamond_fn() then calls kdamond_usleep(0) every loop
> iteration, so kdamond busy-spins and can peg a CPU.
> 
> With a zero sampling interval the access-rate accounting also diverges:
> nr_accesses_bp no longer matches nr_accesses * 10000, and
> kdamond_reset_aggregated() hits:
> 
>   WARNING: invalid nr_accesses_bp at reset: ...

The warning has removed by nr_accesses_bp optimization patch series, which is
currently queued for 7.3-rc1.  So the warning will not be triggered on near
future mainline.
> 
> Reject sample_interval == 0 in damon_set_attrs(), which covers sysfs
> commit and other callers.  damon_lru_sort already refused a zero
> sample_interval; align the core validation with that.

This is a sort of behavioral change.  I also feel this adds another corner case
that makes my head complicated.  There are a few logic written under the
assumption of zero intervals.  Having inconsistencies between allowed input and
handling logic will make it difficult to maintain in long term.  Can't we keep
supporting zero sample interval and fix the warning or the real bug instead?

[1] https://lore.kernel.org/20260630040812.149729-1-sj@kernel.org


Thanks,
SJ

[...]
