Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5FF1E2842;
	Mon,  6 Jan 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192061; cv=none; b=o5uW66h9+CblxhNjD7jvIExOP48KgedY8WRODiYVq+G2klvxQ4oJFEbe8OAEpP4LEtsnMFoLVGRZ0XeF5j+GYAk2l4g5jHAF/Jqzb99OvrksFfcfLXcgwTQ/pcY9mPJ6yBAKFcrYvfjvNms7eFVWWJAaRPPwYQzkP71ynZebQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192061; c=relaxed/simple;
	bh=SpnwWXRTfkYMqczlFfBjIRSLjyD9BiybsCKabnuSowk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7rYx09t+HFjtZHWaxyzCLkKcuaTYa1oVxahC81z/F8wxEF7yqT/uG8IjbJwndKPeOdykM4tgdfZCqO7R7yYhk5Nje8/2qzSTI1a+86BiQ0qnW0B1p5OeY3BtZUUkFEqiybpXR32z1C8eI2NFNeY8UyUAXfQ2rbFZzmhWyjsBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCTv8uZx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCTv8uZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAD3C4CED2;
	Mon,  6 Jan 2025 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192060;
	bh=SpnwWXRTfkYMqczlFfBjIRSLjyD9BiybsCKabnuSowk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCTv8uZxErf78ZprG1RO+MaAdn/+YumcxlEMOAndzJSx0NLXFCOgWo+Tc9wZJAsPr
	 MNpE49L4MxUsRQpV+El7J9g21u03Gl0ptZn8hwDDEi7URVBkgHdOTmDDsFtcvjMz+5
	 zqbc9U6evu4n5i85gyQtU3wog0IJVQAoqTBllTL/2x+aW12WcLe0uDm+49dEAJpKyp
	 01opkbTIsBojoWy6t0XzKaWU0sPLKrDu7Bx2sGgZ7vTMvut9S69m/mNrUGSMdWCb+p
	 IFu6uIeTHkdTnKxH0Oq6PXLjclzB8apsT0Z3Jb0M2Cl5dlrKG7D8iGBnun1mqIceQj
	 DaSjTcXR4Vwng==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/16] Docs/ABI/damon: document per-scheme filter-passed bytes stat file
Date: Mon,  6 Jan 2025 11:33:56 -0800
Message-Id: <20250106193401.109161-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new ABI for per-scheme operations set layer-handled DAMOS
filters passed bytes statistic on the ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f1b90cf1249b..19cde386fd15 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -384,6 +384,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the total size of regions that the
 		action of the scheme has successfully applied in bytes.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_ops_filter_passed
+Date:		Dec 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total size of memory that passed
+		DAMON operations layer-handled filters of the scheme in bytes.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/qt_exceeds
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5
