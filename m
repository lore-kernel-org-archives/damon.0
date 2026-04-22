Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5934E765;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868508; cv=none; b=oukhpLuiss4eP0vLxfH6fZ4bixqQcJQEeLBlsAUMiFRd6d/QaK6F2e/zcyaJIApc//WWWUuOQ4pUeixUz8N6UVhSltJhmKlGjBT25wMBg23ytgLVdjlHJNS/2H+mbpRA3YF0eIxZbhptWLLqXin1JKlSd0NG9Bs3On7/FipC2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868508; c=relaxed/simple;
	bh=bi6XcGwk5Sb2RtrCfQVAavSWJYWkUYMGONOn/G5G6lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snM+LEnQQtINofC+WuSb5VS6/o7z8B7DHFfJx/UhmagsSH8vO4gzQ5Jyln8Xb4bgDClSxmVrTwGErOADWmQSOPKzdwbfcsJS3a0M3m+RNEsyvDOx8ZVwlIN3Z1M02N6pb3hafflgMC5gqHVjq6/TGnOL5iH6cEdFBAWbpCSeLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j72L0/mI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j72L0/mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF38AC19425;
	Wed, 22 Apr 2026 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868507;
	bh=bi6XcGwk5Sb2RtrCfQVAavSWJYWkUYMGONOn/G5G6lQ=;
	h=From:To:Cc:Subject:Date:From;
	b=j72L0/mI2RW3vfdJ3HLLEjpK4h7FpsFh8HwcMuZLZue/4Y0Cv4hPqIJj5chF6p6kl
	 ZtW4fD+t1j7RLaCGfaS70ssc3fatz7PyJmxkCI3GfwFCuzuABpraWCWok8W6DHYKvS
	 xNjBEnfGwrqj+kalLhz5RV/PwmF7mGW/gGDAsOkR/2X6Xig5XxOoSe4mNXgL7rt8Vh
	 SCNboo+cs9bGVI9o6p59CkZnSJF8MIUVTKENZvP+z5J3dYDxCSZMbyW4UNWL2zVRHy
	 fk2VU/adTpaNWVfA7jc2STqEyg/GIeiomUnEUMlxZ3m3pDanwjtsABT8GEucSKnYrD
	 zE9O5RefrPS6A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/sysfs-schemes: fix use-after-free for [memcg_]path
Date: Wed, 22 Apr 2026 07:34:59 -0700
Message-ID: <20260422143503.71357-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reads of 'path' and 'memcg_path' files in DAMON sysfs interface could
race with their writes, results in use-after-free.  Fix those.

SeongJae Park (2):
  mm/damon/sysfs-schemes: protect memcg_path kfree() with
    damon_sysfs_lock
  mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock

 mm/damon/sysfs-schemes.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)


base-commit: 0d45806f3a75bf53e59475b0e56be324f650ab09
-- 
2.47.3
