Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE32C0303
	for <damon@lists.linux.dev>; Sun, 19 Apr 2026 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617545; cv=none; b=YkK9jkkMvSzJm7N2/RjZ3EmEIolIWVpAyR8lNbKcwfelkx0pUR4SQhyLdG3ZY3p0zuFz4PXGHQsaMlpSw0LWFeglTktHgPebHizJDWqudfVuVd8glfcJNAWys98yU69lYjc3sdbREMDy+oLYuzKKl99zSHRC2iqFrFEMcsXNe3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617545; c=relaxed/simple;
	bh=D7Ml06y6DExhFwezyZUEL4UmfrQ7mAEj2waVHFEWfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIkNod40CNB/W3TaDgXB5UDNw5QHDngLDPdl01P1l8X5CBkouTarAY/zn+0Sg6JNFOdg2oFMMapolUq8DFiKbo3d16lHHsfb9JtkNAQrJoUUgbbWD8cP43GwmpvSq1YUHrSHZ+sQfMNDSqWtIawL8849II7bYN1/Ig/yi4Bwrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcgNOhI3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcgNOhI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D345C2BCAF;
	Sun, 19 Apr 2026 16:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776617545;
	bh=D7Ml06y6DExhFwezyZUEL4UmfrQ7mAEj2waVHFEWfUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcgNOhI3zWPFtG4URNbPsz7tXbMgKyWDVtr1/1PVD+wbC/fmVYYdpsHYiTDQ8emef
	 1oD0J8KS6PUatr0v6+ygTC/Nf/iLNDi6OI00lrEq5QewsBFvf4vfKYvmNfmH1bir6c
	 vxiR5uqgj3Tv5RviXvJH329wK+aRD7S9VqmJBEIPD/6NIoH8+4G3kpfBgjZIOO4R4p
	 yWtGZyPec9sf6ey992dSnd6QQsfTBIVG3YbP12dpXny1HAD7FXYJ7EOJBdyirsdW4V
	 XRYp8DgItScVV9+I/tEWFignDKAVrnT112MUBAXwktduOADI1GFsWpwif2rK0zzQVg
	 ok+8KdhvHLqtw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Sun, 19 Apr 2026 09:52:21 -0700
Message-ID: <20260419165222.79948-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419164848.766D9C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 19 Apr 2026 16:48:47 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] Writing to the `enabled` sysfs parameter can cause a NULL pointer dereference if `damon_reclaim_init()` failed during boot.

As I replied [1] on the previous version, it is not caused by this patch.  I'm
separately working on it.

[1] https://lore.kernel.org/20260419014800.877-1-sj@kernel.org


Thanks,
SJ

[...]
