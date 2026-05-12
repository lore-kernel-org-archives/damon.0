Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770442F8E81;
	Tue, 12 May 2026 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561638; cv=none; b=dEO9Idt/Ib4eB/o6CXvhrPtMLSO9Uh1MBk8Csm+LYH7eSGFuzA/XtWzBl7U8VC33xONKVi3W5nhuqZih0eoPc3FEDumdjtPXTuB0n+gyhDu3RWTOexhiqk9KPYAd76EmFT68BEMif2MxiSqoGmb2J5WMsHPzqrKqZYiOFosRgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561638; c=relaxed/simple;
	bh=v+BC38I/J+s7NNS8QzT926dbnk44scOJwG+CMFw9hVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4YtyfV+RDbMUVNvQ8mYNEsLi/prK61WGfl2lJveYu5HKZ2VgIwGxiJtnOOizH3ZEXUUxFf4rGUtGAGUMLWgCONsLSd2P6VSPpzQiPeZffx+rbUZXu8kijLcrEVc8cOCIXTbWN4EErkt/Qmam8OY5Kighb/hQV3rWHUQd+QUP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRDMdSHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRDMdSHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA61AC2BCB0;
	Tue, 12 May 2026 04:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778561638;
	bh=v+BC38I/J+s7NNS8QzT926dbnk44scOJwG+CMFw9hVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRDMdSHV66Ov5XGS84oFpqOnMVcpPTfnD0gsKq/cMSsxb2BnHcuCSCKDH6344QrUQ
	 8+3i/oKcRrQZZfca/Yq5cxEO0LemHDl8yqavnrLJZbTqmUpLIGx/Xh4HDwQdeEAyo2
	 w23VZkpsHJbpCE1nNrBDQ12xvUGJjlJkjlHMAw6OylLYG4pENkJKrDfjDo0Yy2n5Ez
	 X+bJtqNj6Hj1ygySzcpa1TAFt4+cxWzN9xlUW6lMSIPRn8R4DiE52woxd+QFQGUyr6
	 9NobtMNZEYVlB08a7IEzy4oZMFjxtxxDqYSbNlRyhaB858jtALLMXwoxduc31xhL/T
	 emYO+o+Xp4FwQ==
From: SeongJae Park <sj@kernel.org>
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix double increment of nr_regions
Date: Mon, 11 May 2026 21:53:47 -0700
Message-ID: <20260512045347.102434-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512041157.109845-1-agarwal.vineet2006@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 May 2026 09:41:57 +0530 Vineet Agarwal <agarwal.vineet2006@gmail.com> wrote:

> damos_sysfs_populate_region_dir() increments
> sysfs_regions->nr_regions twice when adding a new region:
> once explicitly before kobject_init_and_add(), and once
> again through the post-increment used for the kobject name.
> 
> As a result, nr_regions no longer matches the actual
> number of live regions, and region directory names skip
> numbers (1, 3, 5, ...).
> 
> Use the already incremented value for naming instead of
> incrementing nr_regions a second time.
> 
> Fixes: 66178e4ec30a ("mm/damon/sysfs: use damos_walk() for update_schemes_tried_{bytes,regions}")

FYI we decided [1] not to Cc stable@ because the bug is not making meaningful
real user issues.  The above Fixes: is only for people who seek more contexts
about from when the bug was introduced.

> Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---

From the next time, please consider adding patch changelog [2] here, with link
to previous revision.  To my understanding, this revision has no change from
the previous revision [1] except dropping the RFC tag.

[1] https://lore.kernel.org/20260511191218.98881-1-agarwal.vineet2006@gmail.com
[2] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
