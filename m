Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D0218AB9;
	Tue,  7 Apr 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523942; cv=none; b=QyBk+sTYkkar0fGbW5/PX87rqxvVYde5+HpEBqbKa8bbGHx/Ohs+r1xfPB+10k3qxcEdDqR8vMVj0c9Sq4YzyZ6HeoHNFmosJo7+U8hiqk/0TvQdt/ze4wWAzusnL27nqY7311SH9K6ubuLucYDznk0KzKeLmKX/rJAJWBQauyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523942; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJSoXOSKFmnFg6vSGOQiEhia+ul9Rilp2P8UXLi6WsFHVHlk5cJ+e484Q9GNgNqEHVPi1r3OWrhE+oVL9llhdK6tjecFpomFzTjOQOrdmX7zVjAKR3g7JK8gstDW79u5FqiUW71ehlMStSveU4rCUuX8ug6yhE0BZCXwJSqPBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id46/Ofa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id46/Ofa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA67C4CEF7;
	Tue,  7 Apr 2026 01:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775523942;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Id46/OfaAZ00K5ClvIVUWb6pW1AehlQgKQuwbUeY7+YOgQfpDGSijPvJLSfqp37RA
	 rWgC40yAyYcZv5yGsVW3utBVGld+73Kg/2Sl3snA21zEPhfoia88/Fl2slMRwpbzYd
	 /RA3TZsaNzn5PtV2lLkGbyscD9adNDo26ijcaxEAYSzDmOnEB4K8OyUlveFgnEkcxh
	 /cXDwmu68UANFTWVWrPesnpKynchPvDXc/qLLGNv7vrlN9beoeWgKw5PmRLBrJCQiS
	 2HWmyh/lTkoYqAS6WNFjgqJQT8H/RNw9e58pQY+x0nYikRrQ0V8tqIJYknZ5/xvGsk
	 qKFKS94nyS3ZA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 06/10] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Mon,  6 Apr 2026 18:05:28 -0700
Message-ID: <20260407010536.83603-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-1-sj@kernel.org>
References: <20260407010536.83603-1-sj@kernel.org>
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
