Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297CD3DBD46;
	Thu,  9 Apr 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744521; cv=none; b=ApYldlpaZ1py9S0gycAWV0+7LHaq6vUqLXnL50i+vv2xLk0Bufv5tsHZnQ5tOYF4yt/bxIvFdq56r05cUkMpQJNrGL93S+3VBr/8+nvCsgXaCdY1+W/cW5Ri+/rzlSgPR4+efm4+vvyk2Ve7r2OyWlvUhQmZEO72W7k03RTz/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744521; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIBsINMt/BD2tnHiCTR6S06YWuKlcx0WTZhxq5Fgd7I7/pA6TsU8yAjpJokSm5yqe3AxRn9omudm550xN+QwLQNVjRfAAy8TKT01fgJagJDJ1gUXKDYKj3B6VvvW+p/j8gwXLDt7k4rnI3Orv9iEPmGQYn5yHF07WvLoT3lOCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYT5oBO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYT5oBO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1611C116C6;
	Thu,  9 Apr 2026 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744520;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYT5oBO6tiXFMuvEgp+KNnQo1cmvDK0jPdcht+aCfb+Pa4+rQHAWdVN1XOsqusoPU
	 Sc0PzqGmmzvIdU5tM/b7Jw7EBbCx8jj0SUp8ZJvuOSGEG9HFwRCB21ISKaV5I42nsx
	 j9MrDL3JV50XuRcYNRWTTo46hRr394ljnaMadDWtdbN4BAdCBqWgmJRctVV4erRP1a
	 tq3cyC1BsN7DFp3q42OS3kAA35WkUAfNzu7y6n9OBZe/K/oOmtYwPmvCG9F2guUhHK
	 Wk2i6s2F5A/RY3Qr2BMQjPqH24MUrho/vINs+aIA1W+2qCh6ngfOnrXYSanPm1ygIk
	 TWkQM6t+2ffEw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 07/11] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Thu,  9 Apr 2026 07:21:42 -0700
Message-ID: <20260409142148.60652-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409142148.60652-1-sj@kernel.org>
References: <20260409142148.60652-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMOS action failed regions quota
charge ratio control sysfs files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 7059f540940f0..971c22e34e722 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -329,6 +329,18 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		goal-based effective quota auto-tuning algorithm to use.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_num
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio numerator.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_denom
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio denominator.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
