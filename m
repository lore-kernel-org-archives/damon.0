Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10D18A6C4;
	Thu, 13 Feb 2025 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411100; cv=none; b=ZAn20UP3akJKhCc/6truRl2v9gkxQA3YwJqrPDaWC9PYhMW9cTvsjrcVGq6thhHPi1P1z40rL9zyZ/SUMmF/5kDiCkPZs5hkroSXwY0Z1okaBQsTmnEHbLcbzxmi2pd6/ciDaSdcKPi10aa+gam+2QVCY+EQozLZhqHy4+NYYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411100; c=relaxed/simple;
	bh=NgazBziN0MDu+DwcW8IQ50YvCEMXV3o8RNioTMnFdIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QlvkgyPI/8KXOnoqXSWOpCK4F0mWLfxBFvZs/gXu9L/l8Brj6n6kjPagSzKmWc0frlkOSpo7S8bsBLGUw/7H8LUcsejlqw7eS+/BitpYy54B3oaDrYxrPU4L2jZrVGc7CN4CvOUi/2ng15qoyAuH6vK2qt78g3XuyWJi8FYYpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B56yflNN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B56yflNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78407C4CEEB;
	Thu, 13 Feb 2025 01:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411100;
	bh=NgazBziN0MDu+DwcW8IQ50YvCEMXV3o8RNioTMnFdIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B56yflNN+YVZte1bFv2Xk9dBJtNTjgVLwEg7xjgcpxG9ldYoO0PYjocz2DqQBaQZL
	 ItLkxeJbNJXpZgXgg+xMAtMfyT7Mpn0Z63sWdimkxqSZk9N3uvG+6faf0QdYW99lFj
	 u+Dr2e3mxkN9uKd5um7vyXiXRzMk40LJqrA5equavDWuc+MDKHJyiv3IFtTJDQqsBC
	 WWN4+IWOKsgCdELoHe6lz6hYQR0+USQPYax+1wEJCdb/4/kTc1iI6uYsFJYo3iGaSr
	 1vO5fRahKsJEwifDz3jmLGLLlCpJ5wkeaiFGR9GFK8fenkuI/eXPMvKisMGfDYL0cr
	 Yg8feMnQAjyhw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 7/8] Docs/ABI/damon: document intervals auto-tuning ABI
Date: Wed, 12 Feb 2025 17:44:37 -0800
Message-Id: <20250213014438.145611-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
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
index ccd13ca668c8..77603b5f7c0c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -91,6 +91,36 @@ Description:	Writing a value to this file sets the update interval of the
 		DAMON context in microseconds as the value.  Reading this file
 		returns the value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/samples_bp
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the monitoring intervals
+		auto-tuning target positive access check samples ratio within
+		the given time interval (aggrs in same directory), in bp
+		(1/10,000).  Reading this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/intrvals_goal/aggrs
+Date:		Feb 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the time interval to achieve
+		the monitoring intervals auto-tuning target positive access
+		check samples ratio (samples_bp in same directory) within.
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
