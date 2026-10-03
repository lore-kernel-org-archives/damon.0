Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C23A6F0B
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050379; cv=none; b=aNNfyBza9OXvPOuyLjukfDNJAUZWC5ZaIJii15y9cafkKu3Rvijus6APTtio6IXVCDHkl3SwEOnWUNnBn15UFLDxWOJ+WTPBcymvjS2OHxGQxUuU/CV3d/DoZzuq+D1T+ZM3O2WQET3v4RaJUvWk5aEzm/rpoeAktZu9bBX+NC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050379; c=relaxed/simple;
	bh=SxFeQ1x6V3RUnBN3ME9/GeMpWyZzmy8ZoB1d4uQ6mn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7eu+cT6g/BSjtakY8TdQTYsuyaQKFC1Pj9jaLNhm6MpMXKeG7sBBL79MnwpYHwlzml98ypkOmUtfdvjEw+fhw9iWXviWmdmS/V1QTDcn/a8jVfOwrD/l0wHeDuRHfWMRaCz5gNc2sGd1XbFR3VehHZQf/igmLcKlOCj3sMPFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBOBxbCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBOBxbCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67791F0089B;
	Sat,  3 Oct 2026 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050377;
	bh=1RtyHtdm/9ng46mlSwIkwMnr/KG5l0nzXU0D8IWjhpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBOBxbCjSWhc/kiS3AZuGTTy6pNquSlGpAIzCPtbG62f2HqeKn/beHVCt/FaMeRJe
	 b1BasvWxQAklI3MYq5JdQtPmU8UuW+oWrwADPVsXs+X5AHi2HznELQLyOwa7YuBvIp
	 lI+UkVP0JrDJzNV23l2YwsFq6lclGY3RKV5PKhMufCJ7hznBWramt13ST/Uw7Vfpjy
	 P350Y0J7yrSIVOvSdgb6p+AcAGKjNHXAgDV0V1RfyVEFgUuYYfff8Zrb2JuqjjzLK+
	 u7x8vhmp4OhIbf1zN8niic61QQkB3V6Cj/3j+Fj0Dkcpa8BeGU6VRnxjvowthCnqwf
	 i7y1LL0M6S8rQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.18.y] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Sat,  3 Oct 2026 10:59:32 -0700
Message-ID: <20261003175933.34727-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003175623.7F2081F0089B@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 03 Oct 2026 17:56:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] mm: damon: state leak in damos_skip_charged_region() on split failure
> - [High] mm: damon: double processing of regions due to dynamic iteration

I will fix the state leak.  The second one is a minor bug that also exist in
mainline, so no blocker of this patch in my opinion.  Please read my previous
reply [1] for more details.

[1] https://lore.kernel.org/20261003165326.32932-1-sj@kernel.org


Thanks,
SJ

[...]
