Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750D3B52E2;
	Sat, 11 Apr 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926170; cv=none; b=ojpCxyzBgsY9BX6H+S/wUPb18dlWQlTdKcNfWUStX1F7WJUAFy0mWbpBtyC3034aJjrxQroQuG2ucyTF42e3tUbzIWv452HlD/JXryApu720YvPNMFvgmTdyrnD1wcoYAJjvqIdJNd7YjYt28UA0Sm79IxexZOQHe/rajcCQj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926170; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBl2c0KL9DygoNT1le2iDPhRgLiZSCJdgBtBLXaxCM4zO9XpnjwB2ary4jzNCSCiy5yxZnyXR4p/n0RbRcKC8U5CPJ7DJJiYQoU2HXIPlBoHgzcc16mC6hLwm+fESn02LsTsDLfWt/kBYc2BYY7fCC0logcfHlo/LAd6nfEOOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNYxtZS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNYxtZS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889F7C2BC87;
	Sat, 11 Apr 2026 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775926169;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sNYxtZS1tdOejvA+4Kn34usOzwQPNpvKw88iKGSG85Zti9yROWmO50wi+KDN8QkwH
	 BLz57W2c5V9vkCGZ3CLrQEtZWBu5eYVFutIVnjeEUd11tpBp5oXF/UMALCChfkvxoM
	 EXv1SInihRiARg7e46ke9+FnUWxSWRDRi1gmD5F61bkw0c9Ci9DLPkf6wD8t7lrrRS
	 bCzEtIHRMxE1oIoFcjVYRtYWSwshcaN0jm6GkaGkzMpWhcCM3y6VSyhQ53fSrKNuX0
	 unw7lrQVK/IBIsUvimdkWgNSg2qgc3EsjmYZS2ClY+ymq/ETKoh1LNGSNiZcpvdAxG
	 v/9v9FnFRCMjw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.1 07/11] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Sat, 11 Apr 2026 09:49:00 -0700
Message-ID: <20260411164908.77189-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-1-sj@kernel.org>
References: <20260411164908.77189-1-sj@kernel.org>
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
