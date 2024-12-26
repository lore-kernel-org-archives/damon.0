Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076061D357A;
	Thu, 26 Dec 2024 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251308; cv=none; b=b51hJg1zN5VwFGRFgT/iKFu6pe/mu3SsOmqg1Z9W3hX/4AtDJu9CrJAy4ixXTsH0sdapYkeCHE7VF1z8GAeBLXVa9fV6h7FmxzsfE1PGqzRpKjcVKXrRtKlqqoX/Fz0urT1TmSLGEQJD5fhBiw3Ulks78CUJFcHu4bGrwQ0QhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251308; c=relaxed/simple;
	bh=juadYvUhIrNs11RvqR4w499ufNXf6y5+YZmNZP0gQvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3iNbCFnYKf+bPlbEdn/8Q6wU10kto2/FIMdlMR0RAuuV0pxkYD5j1vI7XqbxNlj8BCz6NRMkPlPsv10OeUtoR60E+PhNPFf/rV/UXNK8QHWcCn4VMTzVWYRCHevtOrvVV3dy3L35ixrXekMmyEPsSwa88nNUHExdEz4KM1hxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPjBLf78; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPjBLf78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606DAC4CED7;
	Thu, 26 Dec 2024 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251307;
	bh=juadYvUhIrNs11RvqR4w499ufNXf6y5+YZmNZP0gQvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPjBLf782yiUQxV2UcpxQo/O1rKLu/pFbXb6x9/ZcwmcuKgjOG7I6FXRA0xZk4Ybj
	 kKG+IjAweuFkwEF5Z6HZ0LVqUIoLMimFNaifeydwejNdTM8QTXSbic+d+l8J2LzYLI
	 hjudt0QdHdzdDnUebPTTI5M2T1wZvKXQaxgrz1TbyXHRla/A240QKzG9rjG/+u/1xW
	 veiSb2ae+BsAf6V5tJsYWbcZbwioj3pxZWvKLLKPCviv72FYPML2noi9I6ol4jTc52
	 cZx+4iTwcjn7UxHNRDK0ZzlI+Ke2jTodLo2g0YX8Ux5qoX8hxJtFTtQfjAvBPCv4Fx
	 gfm8JGYr87gnQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/10] Docs/ABI/damon: document DAMOS filter pass sysfs file
Date: Thu, 26 Dec 2024 14:14:43 -0800
Message-Id: <20241226221445.78433-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for added DAMOS filter 'pass' file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 8c0acb31638b..688bd27d8602 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -355,10 +355,16 @@ Description:	If 'target' is written to the 'type' file, writing to or
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/matching
 Date:		Dec 2022
 Contact:	SeongJae Park <sj@kernel.org>
-Description:	Writing 'Y' or 'N' to this file sets whether to filter out
-		pages that do or do not match to the 'type' and 'memcg_path',
-		respectively.  Filter out means the action of the scheme will
-		not be applied to.
+Description:	Writing 'Y' or 'N' to this file sets whether the filter is for
+		the memory of the 'type', or all except the 'type'.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/filters/<F>/pass
+Date:		Dec 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'Y' or 'N' to this file sets whether to allow (pass
+		through the filter) or deny (be blocked by the filter) applying
+		the scheme's action to the memory that satisfies the 'type' and
+		the 'matching' of the directory.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
 Date:		Mar 2022
-- 
2.39.5
