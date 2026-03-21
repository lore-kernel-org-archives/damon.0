Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAD329391;
	Sat, 21 Mar 2026 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054463; cv=none; b=KBPOcgQqbprSL371zm1WS9vXnc8Laj01pLEFOK17ki0l+RCwqhhURlC/wz8WaVRp6QGPBwhK8YeXj5096DccLh4lPkYOopSfIm149DZokTrw2k2z050vJThK6CJynkWQLwLgKMHJjbwqukS5g86PZRF2QAfYbsvknAsw4GQspTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054463; c=relaxed/simple;
	bh=PEeArNKfdFtHas/K96y4Ll77SY637LRRo0yTKUiZYcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBUBMriG91cEk/r/HW0SkvKzTNad60es1B+jvV9v1/FJdrmKgHqwxaTWdjAx8riHsa+BWCn8xTH7a6WqH0SsljkxxIwK+LQrEMwK7131cWd9I1VMR1MPSUcztoKR5B6fje0uTqlZ4BJG1Sevmxree55rVw6gSFR4CNETgtimb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnrnE65Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnrnE65Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E51C4CEF7;
	Sat, 21 Mar 2026 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774054463;
	bh=PEeArNKfdFtHas/K96y4Ll77SY637LRRo0yTKUiZYcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnrnE65YuUXx6wnZe89Pe8iU5GLqPwOxRUTc/lGakGTHrXAe056KH8+F0/0eC9+hd
	 OuSgVk6eCFkMm1LUPnYjqoGChMnSnkildU6yWNvDyW7PFu/vSK+4HKx2pBaD+xUcgQ
	 EUrgbXRoPKLRgDaLDX/I2kverlCh6icZ2CuahrzwSOCYjG6Fr8xic5NqUrOz3CbYGo
	 txpfW1U/R+sbbMGNi+IY/AD5mar9Wm2MNK23PGQvJ93YrALvHjotp2RmWZB7jRkqts
	 grePXrbvJB0zhp+wP3oMY34PmU3Vt8Gt+F8MNCh9RPK7K6VdCtDT6ODEEHEXjS6Rc8
	 szJr8/dx/SiNg==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Fri, 20 Mar 2026 17:54:19 -0700
Message-ID: <20260321005420.80596-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320163559.178101-3-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Mar 2026 16:35:59 +0000 Josh Law <objecting@objecting.org> wrote:

> damon_sysfs_repeat_call_fn() calls damon_sysfs_upd_tuned_intervals(),
> damon_sysfs_upd_schemes_stats(), and
> damon_sysfs_upd_schemes_effective_quotas() without checking
> contexts->nr.  If nr_contexts is set to 0 via sysfs while DAMON is
> running, these functions dereference contexts_arr[0] and cause a NULL
> pointer dereference.  Add the missing check.
> 
> Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work")
> Cc: <stable@vger.kernel.org> # 6.17.x
> Signed-off-by: Josh Law <objecting@objecting.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---

From the next time, please add patch changelog here.

[...]
Sashiko also added comments [1] that are very same as those for the previous
version of this patch.  I replied [2] to those on the thread.  In short, nice
findings but orthogonal to this patch, and I will work on those separately.

[1] https://sashiko.dev/#/patchset/20260320163559.178101-3-objecting@objecting.org
[2] https://lore.kernel.org/20260320020630.962-1-sj@kernel.org


Thanks,
SJ

[...]
