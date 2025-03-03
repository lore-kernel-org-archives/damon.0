Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED723DE85;
	Mon,  3 Mar 2025 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040260; cv=none; b=VOqO7doJsMhT+o02jp2zYj+1FM9qDzwF/z57syDQLwhaaXqjj0o01UJwWPl7xlxF+IWXcmOINCMejR3qb1SKfxexgEwTmRKmhEREXD6ogyUCraKYuGWP9AUlzVToMAPztk0FhrNMvoifT7hy6hUGPcnCqoIQRyYau1b6YDVVuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040260; c=relaxed/simple;
	bh=XpcVMfDACd++qb3Pq98x+XaZ3PfwwLWSEoYntOcOzFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ePI1/118g9vAxcb2f9G7svb27f2dPRjdMY8t7Eo5wtP3zWUW41/AdAYMrKJxsrUA4w6gUgEwLXHZwckBSxF7UMeSlYFcFUYKFjVMzvajyCvV3QNWeeUiPe1P18mTXS74lMLPaGpdPsFE2JoAuK8xunFq801oi7nYuhW+MmTglC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfdZWy97; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfdZWy97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092DCC4CEF3;
	Mon,  3 Mar 2025 22:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040260;
	bh=XpcVMfDACd++qb3Pq98x+XaZ3PfwwLWSEoYntOcOzFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfdZWy97nH/eiYY8CQK2C3uoDHTugsPUgNxPosNITPG8ev16imKFJzsHQJ+RnLrm3
	 uhctjWkLWWpklHpE42SSz1cs1QJhNssM7NnzRx2i7MElFJ3dvRHC7PMSAfJj7ji08X
	 DUOQ6RJnH7/JBEqrmpk2eOqQF9fRck0Jt11ZuVxAs7Eo4d7IVuhn5h+m/qJcKEmEC3
	 x91GNxG8Rw7F38NSca/3dIR2jfU6Sr8vMxXc0p4WAFuMpIxhVNJOma4+7kTsTmtZX8
	 TfQ3nt5nW+pmx5q2+TSNfjadw5XsHXvaSBd1NcYZ/K5oxiFYjuEIpDHJOAv5VLqBK8
	 AvLHkF0doBvHw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/8] Docs/ABI/damon: document intervals auto-tuning ABI
Date: Mon,  3 Mar 2025 14:17:25 -0800
Message-Id: <20250303221726.484227-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the DAMON user-space ABI for DAMON sampling and aggregation
intervals auto-tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index ccd13ca668c8..76da77d7f7b6 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -91,6 +91,36 @@ Description:	Writing a value to this file sets the update interval of the
 		DAMON context in microseconds as the value.  Reading this file
 		returns the value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/access_bp
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the monitoring intervals
+		auto-tuning target DAMON-observed access events ratio within
+		the given time interval (aggrs in same directory), in bp
+		(1/10,000).  Reading this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/aggrs
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the time interval to achieve
+		the monitoring intervals auto-tuning target DAMON-observed
+		access events ratio (access_bp in same directory) within.
+		Reading this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/min_sample_us
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the minimum value of
+		auto-tuned sampling interval in microseconds.  Reading this
+		file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/max_sample_us
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the maximum value of
+		auto-tuned sampling interval in microseconds.  Reading this
+		file returns the value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/min
 
 WDate:		Mar 2022
-- 
2.39.5
