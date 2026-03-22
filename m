Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2D367F4A;
	Sun, 22 Mar 2026 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195059; cv=none; b=LVLQuuWwWfRopMzbrzJmBevHeLsqWLtVhit/fejETkCbA37m9dqDkJHBPjBZ7ltKIVMfb/7fqW/RG5N0lAp4l4dFxBls/RHKOTrwWEOPw8S/+yej7NPBGE44KamQN9yjUs2qfpGCmGxWfCNGsQUosCIg1YFaHFP9PMXc+uuY730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195059; c=relaxed/simple;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDAqjstE1b3KZdTdRCDVixG79iYXFFDDnGyYdbeJjCjIuVNLlODLWTiwyWWZAFqJ/qFvL869A1iYx90zNaF1QkemTkk5T6ApplBXl6GFpiw42xqBBRMre0JRXFlesnZK+3x8XjmULnVnf13SMrlStRYH2gRyNYzcXSvokYjOx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4ip5v5f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4ip5v5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C845C4AF0B;
	Sun, 22 Mar 2026 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774195059;
	bh=acrZio7SwTIWWe0wc5YY1SpE9hMTqgCgT01pPcG9A6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4ip5v5fJA3sWZJH3LAiEQvd95/Sr8atcd0zE1wUrvqBIJvlfFkZHFMPUjwJR8mWo
	 MnhDjMZ9158HqxUssR3dY5SQKl/BOizkDhD/nbtsrspS4dEn1LRunxghRws/GSz3Ua
	 vuz2bp/j70lLwEfBLsXPv9v7nh0h+1LQAhzPfOa+QxwdbiLYvXCCdKrHJOa0rIsIT2
	 PMc/7ntfk5vmZhgs+2ILmvSuHp3Q/TDDv4bxLIrj58LYA5wbdRJdR+6MtZyZOTF0Xt
	 +6BJwjtUv1dMCgzP02NcBIfiIzhvo4RC6gAU9OX9RdVNnAiANJ4VtPEeG5UzJFb9Yk
	 t/i+u6ZZcI0hw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 05/10] Docs/ABI/damon: update for pause sysfs file
Date: Sun, 22 Mar 2026 08:57:19 -0700
Message-ID: <20260322155728.81434-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-1-sj@kernel.org>
References: <20260322155728.81434-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMON context execution pause/resume
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2424237ebb105..7059f540940f0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -84,6 +84,13 @@ Description:	Writing an integer to this file sets the 'address unit'
 		parameter of the given operations set of the context.  Reading
 		the file returns the last-written 'address unit' value.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/pause
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a boolean keyword to this file sets the 'pause' request
+		parameter for the context.  Reading the file returns the
+		last-written 'pause' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
