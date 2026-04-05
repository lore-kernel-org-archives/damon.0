Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C330E82D;
	Sun,  5 Apr 2026 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401959; cv=none; b=Geb7zvfceS8ovoggZDsSdhHrzg07Tv+5QRd8liXNrcT+5s4V2Ckkcn3mOvxO1lCungI/P1HQ/AmbUDCJJN1PNTj9MfH5gSYP7ucIjRERZh+rxthQmhzHvFIVOX6zdsVDcMW5XCm+iiM8kGoBb8/TaYoAkxwnbcyAtMlyRsk/GtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401959; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spGdmUib/j/5+HgIwt3TZYrgi0R7MTXVtogEXIJCMCy7qYSVpp0EPFs5abg1yrqfpQM4AhLZPJ6FvoT1ajH93+Zez3sjG9GuwkZJQySHJuoOfgz2LWvuAos9pwVKgC9CzRHAYFcjVrrSxlDvRkrtChI4W8LKbINQ6nsO+pCe6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvmM9ifR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvmM9ifR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E84AC116C6;
	Sun,  5 Apr 2026 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775401959;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvmM9ifRdqTUlbXZYONJVHYmVCM4l2anuYGYIg+r2Pviuj0/hKVDWOlJGIOcqIG9k
	 vI4PTFaOH3/jsI2TQMiIqX01w60c8fAhKHQLAKftkWzSS3q5+uZnMuxTa8FGn7ZBzB
	 Btd3uLanbnFzBXAIdusN+gZNVIdpI7bOkdBIAgITYVoiT6aYlg74KxroWgm5wCY+UW
	 faP86iiDJA2elH6BylyItD6jnqXtJQmE9kbt1mHC37RI9swAoYm42ZXtAUgZxtT89M
	 xy6nJE7GMlRC0GQBQX9wjOQH4kyw+Vq9XtmpKp4svvWRVGu5A0l46YUbfTqvmZh4bM
	 o5jjGIjPyMm5g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/9] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Sun,  5 Apr 2026 08:12:23 -0700
Message-ID: <20260405151232.102690-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405151232.102690-1-sj@kernel.org>
References: <20260405151232.102690-1-sj@kernel.org>
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
